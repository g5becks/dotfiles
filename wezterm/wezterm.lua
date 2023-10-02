-- Pull in the wezterm API
local wezterm = require 'wezterm'

if wezterm.config_builder then
  config = wezterm.config_builder()
end


config.font = wezterm.font_with_fallback {
  'Cartograph CF',
  'Fira Code',
}

config.font_size = 16

config.color_scheme = 'github_dimmed'

config.default_cwd = "~/Dev/"

return config
