{ pkgs, vars }:
let
  terminal = "${pkgs.${vars.terminal}}/bin/${vars.terminal}";
in
''
environment {
    CLUTTER_BACKEND "wayland"
    MOZ_ENABLE_WAYLAND "1"
    NIXOS_OZONE_WL "1"
    QT_QPA_PLATFORM "wayland;xcb"
    QT_WAYLAND_DISABLE_WINDOWDECORATION "1"
    SDL_VIDEODRIVER "wayland"
    QT_QPA_PLATFORMTHEME "qt6ct"
}

spawn-at-startup "wl-paste" "--watch" "cliphist" "store"
spawn-at-startup "wl-paste" "--type" "text" "--watch" "cliphist" "store"
spawn-at-startup "nm-applet"
spawn-at-startup "blueman-applet"
spawn-at-startup "quickshell"
spawn-at-startup "waybar"
spawn-at-startup "swaybg" "-i" "/home/${vars.user}/nix-config/potental-walls/photo-1755541608283-1f83b5be9e6e.avif" "-m" "fill"

input {
    keyboard {
        xkb {
            layout "us"
        }
    }
    touchpad {
        click-method "button-areas"
        dwt
        dwtp
        natural-scroll
        scroll-method "two-finger"
        tap
        tap-button-map "left-right-middle"
        accel-profile "adaptive"
    }
    focus-follows-mouse max-scroll-amount="90%"
    warp-mouse-to-focus
    workspace-auto-back-and-forth
}

screenshot-path "~/Pictures/Screenshots/Screenshot-from-%Y-%m-%d-%H-%M-%S.png"

output "eDP-1" {
    scale 1.0
    position x=0 y=0
}

output "HDMI-A-1" {
    scale 1.0
    position x=1920 y=0
}

output "DP-1" {
    scale 1.0
    position x=1920 y=0
}

output "DP-2" {
    scale 1.0
    position x=1920 y=0
}

workspace "1" {
    open-on-output "eDP-1"
}
workspace "2" {
    open-on-output "eDP-1"
}
workspace "3" {
    open-on-output "eDP-1"
}
workspace "4" {
    open-on-output "eDP-1"
}
workspace "5" {
    open-on-output "eDP-1"
}
workspace "6" {
    open-on-output "HDMI-A-1"
}
workspace "7" {
    open-on-output "HDMI-A-1"
}
workspace "8" {
    open-on-output "HDMI-A-1"
}
workspace "9" {
    open-on-output "HDMI-A-1"
}

cursor {
    xcursor-size 24
}

layout {
    focus-ring {
        width 2
        active-color "#ddd6c1"
        inactive-color "#4a4d4a"
    }
    border {
        width 2
        active-color "#ddd6c1"
        inactive-color "#2d3436"
    }
    preset-column-widths {
        proportion 0.25
        proportion 0.5
        proportion 0.75
        proportion 1.0
    }
    default-column-width {
        proportion 0.5
    }
    gaps 8
    struts {
        left 0
        right 0
        top 32
        bottom 0
    }
}

prefer-no-csd
hotkey-overlay {
    skip-at-startup
}

window-rule {
    geometry-corner-radius 8.0 8.0 8.0 8.0
    clip-to-geometry true
}

window-rule {
    match is-floating=true
    shadow {
        on
        color "#1a2122"
    }
}

window-rule {
    match app-id="pavucontrol"
    open-floating true
}

window-rule {
    match app-id="blueman-manager"
    open-floating true
}

window-rule {
    match app-id="nm-connection-editor"
    open-floating true
}

window-rule {
    match app-id="xdg-desktop-portal-gtk"
    open-floating true
}

window-rule {
    match app-id="file-roller"
    open-floating true
}

window-rule {
    match app-id="org.gnome.FileRoller"
    open-floating true
}

binds {
    Mod+Return { spawn "${terminal}"; }
    Mod+Shift+Q { close-window; }
    Mod+D { spawn "wmenu-run" "-l" "10" "-p" "run:" "-N" "#2d3436" "-n" "#ddd6c1" "-M" "#4a4d4a" "-m" "#ddd6c1" "-S" "#4a4d4a" "-s" "#ddd6c1"; }
    Mod+V { spawn "sh" "-c" "cliphist list | wmenu -l 10 -p 'clipboard:' -N '#2d3436' -n '#ddd6c1' -M '#4a4d4a' -m '#ddd6c1' -S '#4a4d4a' -s '#ddd6c1' | cliphist decode | wl-copy"; }

    Mod+Shift+E { quit; }
    Mod+Shift+R { spawn "sh" "-c" "pkill -SIGUSR2 niri"; }

    XF86AudioMute allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
    XF86AudioRaiseVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"; }
    XF86AudioLowerVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
    XF86AudioMicMute allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }
    XF86MonBrightnessUp allow-when-locked=true { spawn "brightnessctl" "set" "5%+"; }
    XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "set" "5%-"; }

    Print { screenshot-screen; }
    Mod+Shift+S { screenshot; }

    Mod+S { switch-preset-column-width; }
    Mod+F { maximize-column; }
    Mod+Shift+F { expand-column-to-available-width; }
    Mod+Space { toggle-window-floating; }
    Mod+W { toggle-column-tabbed-display; }
    Mod+Comma { consume-window-into-column; }
    Mod+Period { expel-window-from-column; }
    Mod+C { center-visible-columns; }
    Mod+Tab { switch-focus-between-floating-and-tiling; }

    Mod+1 { focus-workspace 1; }
    Mod+2 { focus-workspace 2; }
    Mod+3 { focus-workspace 3; }
    Mod+4 { focus-workspace 4; }
    Mod+5 { focus-workspace 5; }
    Mod+6 { focus-workspace 6; }
    Mod+7 { focus-workspace 7; }
    Mod+8 { focus-workspace 8; }
    Mod+9 { focus-workspace 9; }

    Mod+Shift+1 { move-column-to-workspace 1; }
    Mod+Shift+2 { move-column-to-workspace 2; }
    Mod+Shift+3 { move-column-to-workspace 3; }
    Mod+Shift+4 { move-column-to-workspace 4; }
    Mod+Shift+5 { move-column-to-workspace 5; }
    Mod+Shift+6 { move-column-to-workspace 6; }
    Mod+Shift+7 { move-column-to-workspace 7; }
    Mod+Shift+8 { move-column-to-workspace 8; }
    Mod+Shift+9 { move-column-to-workspace 9; }

    Mod+Minus { set-column-width "-10%"; }
    Mod+Equal { set-column-width "+10%"; }
    Mod+Shift+Minus { set-window-height "-10%"; }
    Mod+Shift+Equal { set-window-height "+10%"; }

    Mod+H { focus-column-left; }
    Mod+L { focus-column-right; }
    Mod+J { focus-window-or-workspace-down; }
    Mod+K { focus-window-or-workspace-up; }
    Mod+Left { focus-column-left; }
    Mod+Right { focus-column-right; }
    Mod+Down { focus-workspace-down; }
    Mod+Up { focus-workspace-up; }

    Mod+Shift+H { move-column-left; }
    Mod+Shift+L { move-column-right; }
    Mod+Shift+K { move-column-to-workspace-up; }
    Mod+Shift+J { move-column-to-workspace-down; }

    Mod+Ctrl+H { focus-monitor-left; }
    Mod+Ctrl+L { focus-monitor-right; }
    Mod+Ctrl+J { focus-monitor-down; }
    Mod+Ctrl+K { focus-monitor-up; }

    Mod+Shift+Ctrl+H { move-column-to-monitor-left; }
    Mod+Shift+Ctrl+L { move-column-to-monitor-right; }
    Mod+Shift+Ctrl+J { move-column-to-monitor-down; }
    Mod+Shift+Ctrl+K { move-column-to-monitor-up; }
}
''
