local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.default_prog = {"wsl.exe", "--distribution", "Ubuntu-22.04"}

-- カラースキームの設定
config.color_scheme = 'iceberg-dark'

-- 背景透過
config.window_background_opacity = 0.93

-- tab bar
config.use_fancy_tab_bar = false
config.colors = {
  cursor_bg= "#c6c8d1",
  tab_bar = {
    background = "#1b1f2f",

    active_tab = {
      bg_color = "#444b71",
      fg_color = "#c6c8d1",
      intensity = "Normal",
      underline = "None",
      italic = false,
      strikethrough = false,
    },

    inactive_tab = {
      bg_color = "#282d3e",
      fg_color = "#c6c8d1",
      intensity = "Normal",
      underline = "None",
      italic = false,
      strikethrough = false,
    },

    inactive_tab_hover = {
      bg_color = "#1b1f2f",
      fg_color = "#c6c8d1",
      intensity = "Normal",
      underline = "None",
      italic = true,
      strikethrough = false,
    },

    new_tab = {
      bg_color = "#1b1f2f",
      fg_color = "#c6c8d1",
      italic = false
    },

    new_tab_hover = {
      bg_color = "#444b71",
      fg_color = "#c6c8d1",
      italic = false
    },
  }
}

-- font
config.font = wezterm.font("Fira Code", {weight="Regular", stretch="Normal", style="Normal"})
config.font_size = 12

-- ショートカットキー
local act = wezterm.action
config.keys = {
  {
    key = 'd',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
}


return config
