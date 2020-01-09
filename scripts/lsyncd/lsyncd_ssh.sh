#!/usr/bin/env bash

set -o errexit

sudo mkdir -p /var/log/lsyncd
sudo touch /var/log/lsyncd/lsyncd.{log,status}
sudo mkdir -p /etc/lsyncd
sudo touch /etc/lsyncd/lsyncd.conf.lua

remote_host="$(aws ec2 describe-instances --region us-east-1 --profile $LSYNCD_AWS_PROFILE --filters Name=tag:Name,Values=$LSYNCD_INSTANCE_NAME Name='instance-state-name',Values=running | jq '.Reservations[].Instances[] | [.PrivateIpAddress ] ')"
host_ip=$(echo "$remote_host" | jq '.[]')

echo "Updating lsyncd config to sync dir \"${LSYNCD_SOURCE_DIR}\" with dir \"${LSYNCD_TARGET_DIR}\" in ${LSYNCD_INSTANCE_NAME} with ip ${host_ip}."
sudo bash -c "cat << EOT > /etc/lsyncd/lsyncd.conf.lua
settings {
  logfile    = '/var/log/lsyncd/lsyncd.log',
  statusFile = '/var/log/lsyncd/lsyncd.status'
}

sync {
  default.rsyncssh,
  source    = \"$LSYNCD_SOURCE_DIR\",
  host      = $host_ip,
  targetdir = \"$LSYNCD_TARGET_DIR\",
  rsync     = { rsh=\"/usr/bin/ssh -l ec2-user -i $LSYNCD_KEY_PATH -o StrictHosteyChecking=no\" }

EOT"

echo "Restarting lsyncd service."
sudo service lsyncd restart

