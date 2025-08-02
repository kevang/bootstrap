local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Color scheme
-- config.color_scheme = 'Gruvbox dark, hard (base16)'
config.color_scheme = 'Kanagawa Dragon (Gogh)'

-- Fonts
config.font = wezterm.font("Noto Sans Mono" )
config.font_size = 11.0

-- Window opacitiy
config.window_background_opacity = 0.90

-- Terminal window padding
config.window_padding = {
  left = '1.5cell',
  right = '1.5cell',
  top = '0.5cell',
  bottom = '0.5cell',
}

-- Start tmux at start up
-- config.default_prog = { 'tn' }

return config
