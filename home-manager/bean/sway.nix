{ lib, ... }:
let
  screenlock = "swaylock -f -l -c 000000";
  mode_system = "What to do? (l) lock, (e) logout, (r) reboot, (s) suspend, (Shift+s) shutdown";

  screenshot_selected_area_clipboard = "slurp | grim -g- - | wl-copy";
  screenshot_full_clipboard = "grim - | wl-copy";
in rec {
  modifier = "Mod4";
  terminal = "kitty";
  output.Virtual-1 = {
    mode = "1920x1080@60Hz";
  };
  output."*" = {
    bg = "${./wallpaper.jpg} fill";
  };
  menu = "krunner";
  gaps.outer = 2;
  gaps.inner = 2;
  gaps.smartGaps = true;
  window = {
    border = 2;
  };

  colors = {
    focused = {
      background = "#344e41";
      border = "#588157";
      childBorder = "#3a5a40";
      indicator = "#ff0000";
      text = "#dad7cd";
    };
    unfocused = {
      background = "#3a5a40";
      border = "#3a5a40";
      childBorder = "#588157";
      indicator = "#ff0000";
      text = "#dad7cd";
    };
  };

  defaultWorkspace = "workspace 1";

  floating.criteria = [
    { title = "Picture-in-Picture" ;}
    { app_id="pavucontrol" ;}
  ];

  # System mode menu (poweroff, suspend, etc)
  modes = {
    ${mode_system} = {
      l = "exec ${screenlock}; mode default";
      e = "swaymsg exit; mode default";
      r = "exec systemctl reboot; mode default";
      s = "exec systemctl suspend; mode default";
      "shift+s" = "exec systemctl poweroff; mode default";
      Escape = "mode default";
      Return = "mode default";
    };
  };

  # Bar
  bars = [
    { command = "waybar" ;}
  ];

  # Keybindings
  keybindings =
    lib.mkOptionDefault {
      "${modifier}+q" = "kill";
      "${modifier}+space" = "exec ${menu}";
      "${modifier}+n" = "exec 'swaync-client -t -sw'";

      "${modifier}+Shift+s" = "exec ${screenshot_selected_area_clipboard}";
      "${modifier}+s" = "exec ${screenshot_full_clipboard}";

      "${modifier}+Shift+e" = "mode \"${mode_system}\"";

      "XF86MonBrightnessDown" = "exec light -U 10";
      "XF86MonBrightnessUp" = "exec light -A 10";
      "XF86AudioRaiseVolume" = "exec 'amixer sset Master 5%+'";
      "XF86AudioLowerVolume" = "exec 'amixer sset Master 5%-'";
      "XF86AudioMute" = "exec 'amixer sset Master toggle'";

      "alt+tab" = "exec swayr prev-window all-workspaces";
      "shift+alt+tab" = "exec swayr next-window all-workspaces";
      "${modifier}+tab" = "exec swayr switch-window";
    };

  # Startup
  startup = [
    { command = "firefox" ;}
    { command = "discord" ;}
    { command = "/user/libexec/polkit-gnome-authentication-agent-1" ;}
    { command = "systemctl --user import-environment"; always=true ;}
    { command = "swaync --style /etc/sway/swaync/style.css --config /etc/sway/swaync/config.json"; always=true ;}
    { command = "swayrd" ; always=true ;}
  ];
}
