local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- リーダーキー
config.leader = { key = 'a', mods = 'CTRL' }

-- カラースキーム
config.color_scheme = 'Pro'

-- 背景透過
config.window_background_opacity = 0.7
config.macos_window_background_blur = 20

-- タイトルバーの非表示
config.window_decorations = "RESIZE"

-- タブバーの設定
config.window_frame = {
  inactive_titlebar_bg = "none",
  active_titlebar_bg = "none",
  font = wezterm.font('JetBrains Mono', { weight = 'Bold' }),
}
config.window_background_gradient = {
  colors = { "#000000" },
}
config.show_new_tab_button_in_tab_bar = false
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)

   -- デフォルトの背景色、文字色、区切り部分の背景色を設定
   local background = "#49575C"
   local foreground = "#FFFFFF"
   local edge_background = "none"
   
   -- タブがアクティブな場合の色を上書き
   if tab.is_active then
     background = "#FFE1E1"
     foreground = "#000000"
   end

   -- 区切り部分の文字色を背景色に合わせる
   local edge_foreground = background

   -- タイトルテキストを生成（左右に余白を追加）
   local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "

   return {
     { Background = { Color = edge_background } },
     { Foreground = { Color = edge_foreground } },
     { Text = SOLID_LEFT_ARROW },
     { Background = { Color = background } },
     { Foreground = { Color = foreground } },
     { Text = title },
     { Background = { Color = edge_background } },
     { Foreground = { Color = edge_foreground } },
     { Text = SOLID_RIGHT_ARROW },
   }
 end)

 -- フォントの設定
config.font = wezterm.font("JetBrains Mono", {weight="Regular", stretch="Normal", style="Normal"})

-- フォントサイズの設定
config.font_size = 12

-- 日本語入力
config.use_ime = true

-- カーソルの色設定を追加
config.colors = {
  cursor_bg = '#FFFFFF',
  cursor_fg = '#000000',
  cursor_border = '#00FF00',
  selection_bg = '#D4F7D4',
  selection_fg = '#000000',
  tab_bar = {
    inactive_tab_edge = "none",
  },
}

-- ショートカットキーの作成
local act = wezterm.action
config.keys = {
  -- フルスクリーン切り替え
  { key = "f", mods = "CTRL", action = act.ToggleFullScreen },
  -- 新規タブ
  { key = "t", mods = "CTRL", action = act({ SpawnTab = "CurrentPaneDomain" }) },
  -- 新規ペイン
  { key = "p", mods = "CTRL", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
}

return config
