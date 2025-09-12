local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Close Confirmation
config.window_close_confirmation = "NeverPrompt"

-- Font
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Regular" })
config.font_size = 20
config.line_height = 1

-- Color Scheme
config.color_scheme = "Catppuccin Mocha"

-- Tab bar
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.enable_tab_bar = true

-- Padding
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

-- smart splits

local function is_vim(pane) return pane:get_user_vars().IS_NVIM == "true" end

local direction_keys = {
    LeftArrow = "Left",
    DownArrow = "Down",
    UpArrow = "Up",
    RightArrow = "Right",
}

local function split_nav(resize_or_move, key)
    return {
        key = key,
        mods = resize_or_move == "resize" and "META" or "CTRL",
        action = wezterm.action_callback(function(win, pane)
            if is_vim(pane) then
                -- pass the keys through to vim/nvim
                win:perform_action({
                    SendKey = {
                        key = key,
                        mods = resize_or_move == "resize" and "META" or "CTRL",
                    },
                }, pane)
            else
                if resize_or_move == "resize" then
                    win:perform_action(
                        { AdjustPaneSize = { direction_keys[key], 3 } },
                        pane
                    )
                else
                    win:perform_action(
                        { ActivatePaneDirection = direction_keys[key] },
                        pane
                    )
                end
            end
        end),
    }
end

-- Keys
config.disable_default_key_bindings = true
act = wezterm.action
config.keys = {
    -- move between split panes
    split_nav("move", "LeftArrow"),
    split_nav("move", "DownArrow"),
    split_nav("move", "UpArrow"),
    split_nav("move", "RightArrow"),
    -- resize panes
    split_nav("resize", "LeftArrow"),
    split_nav("resize", "DownArrow"),
    split_nav("resize", "UpArrow"),
    split_nav("resize", "RightArrow"),

    -- Copy & paste using Ctrl+Shift
    { key = "c", mods = "ALT", action = act.CopyTo("Clipboard") },
    { key = "v", mods = "ALT", action = act.PasteFrom("Clipboard") },
    -- spawn command to new tab
    {
        key = "S",
        mods = "ALT",
        action = act.SpawnCommandInNewTab({ args = { "ncspot" } }),
    },
    -- New tab
    { key = "t", mods = "ALT", action = act.SpawnTab("CurrentPaneDomain") },
    -- Close Pane
    { key = "w", mods = "CTRL", action = act.CloseCurrentPane({ confirm = true }) },
    -- Close tab
    { key = "w", mods = "ALT", action = act.CloseCurrentTab({ confirm = true }) },
    -- Split vertical
    {
        key = "s",
        mods = "SHIFT|CTRL",
        action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    -- Split horizontal
    {
        key = "v",
        mods = "SHIFT|CTRL",
        action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    -- go to tab
    { key = "1", mods = "SHIFT|CTRL", action = act.ActivateTab(0) },
    { key = "2", mods = "SHIFT|CTRL", action = act.ActivateTab(1) },
    { key = "3", mods = "SHIFT|CTRL", action = act.ActivateTab(2) },
    { key = "4", mods = "SHIFT|CTRL", action = act.ActivateTab(3) },
    { key = "5", mods = "SHIFT|CTRL", action = act.ActivateTab(4) },
    { key = "6", mods = "SHIFT|CTRL", action = act.ActivateTab(5) },
    -- next/prev tab
    { key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
    { key = "Tab", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },
    -- move tab relative
    { key = "Tab", mods = "ALT", action = act.MoveTabRelative(1) },
    { key = "Tab", mods = "SHIFT|ALT", action = act.MoveTabRelative(-1) },
    -- Scroll
    { key = "PageUp", mods = "CTRL", action = act.ScrollByPage(-1) },
    { key = "PageDown", mods = "CTRL", action = act.ScrollByPage(1) },
    { key = "UpArrow", mods = "CTRL|SHIFT", action = act.ScrollByLine(-15) },
    { key = "DownArrow", mods = "CTRL|SHIFT", action = act.ScrollByLine(15) },
    -- activate copy mode
    { key = "X", mods = "CTRL|SHIFT", action = act.ActivateCopyMode },
    -- toggle the pane zoom state
    { key = "Z", mods = "CTRL|SHIFT", action = act.TogglePaneZoomState },
}

return config
