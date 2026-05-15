local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Color scheme
config.color_scheme = "Kanagawa Dragon (Gogh)"

-- Fonts
config.font = wezterm.font("Noto Sans Mono")
config.font_size = 11.0

-- Window opacitiy
config.window_background_opacity = 1.00

config.enable_tab_bar = false

-- Terminal window padding
config.window_padding = {
    left = "1.5cell",
    right = "1.5cell",
    top = "0.5cell",
    bottom = "0.5cell",
}

config.visual_bell = {
  fade_in_duration_ms = 0,
  fade_out_duration_ms = 0,
}

config.audible_bell = "Disabled"

-- Start tmux at start up
config.default_prog = { "tmux", "new-session", "-A", "-s", "main" }

return config
