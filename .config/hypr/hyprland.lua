local colors = require("hyprland-colors")
local base = colors.foreground

-- programs
local terminal = "kitty"
local browser = "helium-browser"
local file_manager = "thunar"
local menu_drun = "tofi-drun --drun-launch=true --fuzzy-match true"
local home = os.getenv("HOME")
local script_scratchpad = home .. "/.config/hypr/scripts/scratchpad"
local xdg_runtime_dir = os.getenv("XDG_RUNTIME_DIR")
local ssh_auth_sock = xdg_runtime_dir .. "/ssh-agent.socket"

-- main modifier
local mainMod = "SUPER"

local function float_exec(cmd)
    local monitor = hl.get_active_monitor()
    if monitor then
        local w = math.floor(monitor.width * 0.8)
        local h = math.floor(monitor.height * 0.8)
        hl.exec_cmd(cmd, { float = true, size = tostring(w) .. " " .. tostring(h), center = true })
    else
        hl.dispatch(hl.dsp.exec_cmd(cmd))
    end
end

-- environment
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("WLR_RENDERER_ALLOW_SOFTWARE", "1")
hl.env("GTK_THEME", "Adwaita:dark")
hl.env("WLR_DRM_NO_ATOMIC", "1")
hl.env("HYPRSHOT_DIR", "Pictures/Screenshots")
hl.env("XCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("XDG_CONFIG_HOME", home .. "/.config")
hl.env("SSH_AUTH_SOCK", ssh_auth_sock)
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("_JAVA_OPTIONS", "-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true")

-- autostart
hl.on("hyprland.start", function()
    hl.exec_cmd("eww open bar_0")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprsunset")
    hl.exec_cmd("hyprpm reload -n")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("ssh-agent -D -a " .. ssh_auth_sock)
    hl.exec_cmd(home .. "/.local/bin/load_ssh_keys.sh")
    hl.exec_cmd("udiskie")
end)

-- config
hl.config({
    cursor = {
        no_hardware_cursors = true,
        inactive_timeout = 15,
    },
    input = {
        kb_layout = "pl",
        kb_variant = "",
        kb_model = "",
        kb_options = "ctrl:nocaps",
        kb_rules = "",
        follow_mouse = 1,
        touchpad = {
            natural_scroll = true,
        },
        sensitivity = -0.75,
    },
    general = {
        gaps_in = 0,
        gaps_out = 0,
        border_size = 2,
        col = {
            active_border = colors.green,
            inactive_border = colors.black,
        },
        layout = "master",
        allow_tearing = true,
    },
    decoration = {
        dim_special = 0.4,
    },
    animations = {
        enabled = true,
    },
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        force_default_wallpaper = 0,
        mouse_move_enables_dpms = true,
        background_color = colors.background,
    },
    xwayland = {
        force_zero_scaling = true,
    },
})

-- animations
hl.animation({ leaf = "windows",    enabled = true, speed = 1, bezier = "default", style = "slide" })
hl.animation({ leaf = "windowsIn",  enabled = true, speed = 1, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "fade",       enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "layers",     enabled = true, speed = 1, bezier = "default" })
hl.animation({ leaf = "border",     enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1, bezier = "default", style = "slidefadevert 20%" })

-- layer rules
hl.layer_rule({
    name = "blur-launcher",
    match = { namespace = "launcher" },
    blur = true,
})
hl.layer_rule({
    name = "noanim-hyprpicker",
    match = { namespace = "hyprpicker" },
    no_anim = true,
})
hl.layer_rule({
    name = "noanim-selection",
    match = { namespace = "selection" },
    no_anim = true,
})

-- window rules
hl.window_rule({
    name = "border-floating",
    match = { float = true },
    rounding = 8,
})
hl.window_rule({
    name = "border-no-floating",
    match = { float = false },
    border_color = base .. " " .. colors.green .. " " .. base,
    border_size = 2,
    no_shadow = true,
})
hl.window_rule({
    name = "special-border-color",
    match = { workspace = "s[true]" },
    border_color = colors.black .. " " .. colors.blue .. " " .. colors.black,
})
hl.window_rule({
    name = "float-windows",
    match = { class = "(org.pulseaudio.pavucontrol)" },
    float = true,
})
hl.window_rule({
    name = "render-unfocused-java",
    match = { title = "^(GT)(.*)$" },
    render_unfocused = true,
})

-- keybinds
-- media controls
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86Search", hl.dsp.exec_cmd("launchpad"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +10%"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"), { locked = true })

-- screenshots
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot --freeze -z -m output"))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot --freeze -z -m window"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot --freeze -z -m region"))

-- opening apps
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Q", function() float_exec(terminal) end)
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(file_manager))
hl.bind(mainMod .. " + SHIFT + E", function() float_exec(file_manager) end)
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu_drun .. " --prompt-text \"Apps: \""))

-- layout
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + CTRL + P", hl.dsp.window.pseudo())

-- screenlock
hl.bind(mainMod .. " + CTRL + L", hl.dsp.exec_cmd("hyprlock"))

-- suspend
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("systemctl suspend && hyprlock"))

-- move focus with mainMod + hjkl
hl.bind(mainMod .. " + h", function()
    hl.dispatch(hl.dsp.focus({ direction = "l" }))
    hl.dispatch(hl.dsp.window.bring_to_top())
end)
hl.bind(mainMod .. " + l", function()
    hl.dispatch(hl.dsp.focus({ direction = "r" }))
    hl.dispatch(hl.dsp.window.bring_to_top())
end)
hl.bind(mainMod .. " + k", function()
    hl.dispatch(hl.dsp.focus({ direction = "u" }))
    hl.dispatch(hl.dsp.window.bring_to_top())
end)
hl.bind(mainMod .. " + j", function()
    hl.dispatch(hl.dsp.focus({ direction = "d" }))
    hl.dispatch(hl.dsp.window.bring_to_top())
end)

-- cycle focus
hl.bind(mainMod .. " + n", function()
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.bring_to_top())
end)
hl.bind(mainMod .. " + m", function()
    hl.dispatch(hl.dsp.window.cycle_next("prev"))
    hl.dispatch(hl.dsp.window.bring_to_top())
end)

-- switch workspaces with mainMod + [0-9]
hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))

-- move active window to a workspace with mainMod + SHIFT + [0-9]
hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- scratchpad S
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("scratchpad_S"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(script_scratchpad .. " -n scratchpad_S"))

-- scratchpad A
hl.bind(mainMod .. " + A", hl.dsp.workspace.toggle_special("scratchpad_A"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd(script_scratchpad .. " -n scratchpad_A"))

-- scratchpad D
hl.bind(mainMod .. " + D", hl.dsp.workspace.toggle_special("scratchpad_D"))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd(script_scratchpad .. " -n scratchpad_D"))

-- move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- switch workspaces with super+arrow
hl.bind(mainMod .. " + left", hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ workspace = "r+1" }))

-- select sink
hl.bind("F4", hl.dsp.exec_cmd(home .. "/.local/bin/sink_changer.py"))

-- toggle internal monitor
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(home .. "/.local/bin/monitor_manager.py"))

-- password menu
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd(home .. "/.local/bin/passmenu.sh"))

-- per-machine config
local hostname_file = io.open("/proc/sys/kernel/hostname", "r")
if hostname_file then
    local hostname = hostname_file:read("*a"):gsub("%s+", "")
    hostname_file:close()
    pcall(require, "workstations." .. hostname)
end
