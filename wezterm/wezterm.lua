local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = "Dracula+"
config.font_size = 18.0
config.use_ime = true
config.window_background_opacity = 0.9
config.macos_window_background_blur = 20
config.window_decorations = "RESIZE"
config.colors = {
	tab_bar = {
		inactive_tab_edge = "none",
	},
}
config.font = wezterm.font("HackGen", {weight="Regular", stretch="Normal", style="Normal"})
config.use_fancy_tab_bar = true
return config