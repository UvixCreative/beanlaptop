
{ lib, ... }:
let
  screenlock = "swaylock -f -l -c 000000";
  mode_system = "What to do? (l) lock, (e) logout, (r) reboot, (s) suspend, (Shift+s) shutdown";

  screenshot_selected_area_clipboard = "slurp | grim -g- - | wl-copy";
  screenshot_full_clipboard = "grim - | wl-copy";

  theme = {
    focus_green = "#588158";
    unfocus_green = "374f2f";
    focusinactive_green = "#466946";
    text = "#dad7cd";
    indicator = "#77fc77";
  };
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
  gaps.outer = 0;
  gaps.inner = 0;
  gaps.smartGaps = true;
  window = {
    border = 2;
    titlebar = false;
  };

  colors = {
    unfocused = {
      background = theme.unfocus_green;
      border = theme.unfocus_green;
      childBorder = theme.unfocus_green;
      indicator = theme.indicator;
      text = theme.text;
    };
    focused = {
      background = theme.focus_green;
      border = theme.focus_green;
      childBorder = theme.focus_green;
      indicator = theme.indicator;
      text = theme.text;
    };
    focusedInactive = {
      background = theme.focusinactive_green;
      border = theme.focusinactive_green;
      childBorder = theme.unfocus_green;
      indicator = theme.indicator;
      text = theme.text;
    };
  };

  defaultWorkspace = "workspace number 1";

  floating.criteria = [
    { title = "Picture-in-Picture" ;}
    { app_id="pa_popup" ;}
    { app_id="com.nextcloud.desktopclient.nextcloud" ;}
  ];

  # System mode menu (poweroff, suspend, etc)
  modes = {
    ${mode_system} = {
      l = "exec ${screenlock}; mode default";
      e = "exit; mode default";
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
      "${modifier}+o" = "move container to output left";
      "${modifier}+p" = "move container to output right";
      "${modifier}+t" = "sticky toggle";

      "${modifier}+space" = "exec ${menu}";
      "${modifier}+n" = "exec 'swaync-client -t -sw'";

      "${modifier}+Shift+s" = "exec ${screenshot_selected_area_clipboard}";
      "${modifier}+s" = "exec ${screenshot_full_clipboard}";

      "${modifier}+Shift+e" = "mode \"${mode_system}\"";

      "${modifier}+b" = "exec 'pkill waybar || waybar'"; # Toggle bar

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
    { command = "krunner -d" ; always=true ;}
    { command = "/user/libexec/polkit-gnome-authentication-agent-1" ;}
    { command = "systemctl --user import-environment"; always=true ;}
    { command = "swaync --style /etc/sway/swaync/style.css --config /etc/sway/swaync/config.json"; always=true ;}
    { command = "swayrd" ; always=true ;}
    { command = "kwalletd5" ; always=true ;}
    { command = "firefox" ;}
    { command = "discord" ;}
    { command = "nextcloud" ;}
  ];
}
