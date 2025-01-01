
{ lib, ... }:
let
  screenlock = "swaylock -f -l -c 000000";
  mode_system = "What to do? (l) lock, (e) logout, (r) reboot, (s) suspend, (Shift+s) shutdown";
  mode_power = "Select a power profile: (s) Power saver, (b) Balanced, (p) Performance, (d) Don't screen timeout";
  mode_audio = "Select an audio output: (f) Focusrite Scarlett, (s) Speakers, (h) HDMI, (j) Audio Jack";

  screenshot_selected_area_clipboard = "slurp | grim -g- - | wl-copy";
  screenshot_full_clipboard = "grim - | wl-copy";

  theme = {
    focus_green = "#588158";
    unfocus_green = "374f2f";
    focusinactive_green = "#466946";
    text = "#dad7cd";
    indicator = "#77fc77";
  };

  monitors = rec {
    primary = "DP-3";
    secondary = "eDP-2";
    left = secondary;
    right = primary;
  };

in rec {
  modifier = "Mod4";
  terminal = "kitty";
  output = {
    "*" = {
      bg = "${./wallpaper.jpg} fill";
      adaptive_sync = "on";
    };
    eDP-2 = {
      scale = "1.4";
    };
    DP-3 = {
      mode = "2560x1440@143.973Hz";
    };
  };
  input = {
    "type:touchpad" = {
      pointer_accel = "0.3";
      scroll_factor = "0.5";
      natural_scroll = "enabled";
      drag = "enabled";
      tap = "enabled";
      dwt = "enabled";
      tap_button_map = "lrm";
    };
  };
  menu = ''fuzzel --font="DejaVu Sans Monospace" -b 223322dd -s aaddaadd -S eeeeeeff -C 113311ff -t ddddddee -m bb99ddff -M 9922aaff'';
  #menu = "krunner";
  gaps.outer = 4;
  gaps.inner = 4;
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
  workspaceOutputAssign = [
    { output = monitors.secondary; workspace = "10" ; }
    { output = monitors.secondary; workspace = "9" ; }
    { output = monitors.secondary; workspace = "8" ; }
    { output = monitors.secondary; workspace = "7" ; }

    { output = monitors.primary; workspace = "1" ; }
    { output = monitors.primary; workspace = "2" ; }
    { output = monitors.primary; workspace = "3" ; }
    { output = monitors.primary; workspace = "4" ; }
  ];

  floating.criteria = [
    { title = "Picture-in-Picture" ;}
    { app_id="pa_popup" ;}
    { app_id="com.nextcloud.desktopclient.nextcloud" ;}
  ];

  assigns = {
    "10" = [
      { class = "discord"; }
      { class = "Signal"; }
      { app_id = "bluebubbles"; }
    ];
  };

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

   ${mode_power} = {
      s = "output eDP-2 mode 2560x1600@60Hz; exec powerprofilesctl set power-saver; exec systemctl --user start swayidle-powersaver.service; mode default";
      b = "output eDP-2 mode 2560x1600@165Hz; exec powerprofilesctl set balanced; exec systemctl --user start swayidle-balanced.service; mode default";
      p = "output eDP-2 mode 2560x1600@165Hz; exec powerprofilesctl set performance; exec systemctl --user start swayidle-performance.service; mode default";
      d = "exec systemctl --user stop swayidle-powersaver.service swayidle-balanced.service swayidle-performance.service; mode default";
      Escape = "mode default";
      Return = "mode default";
    };

   ${mode_audio} = {
      f = "exec pactl set-default-sink alsa_output.usb-Focusrite_Scarlett_2i2_USB_Y868Z9E9B8652D-00.Direct__Direct__sink; mode default";
      s = "exec pactl set-default-sink alsa_output.pci-0000_c4_00.6.analog-stereo; mode default";
      h = "exec pactl set-default-sink alsa_output.pci-0000_c4_00.1.hdmi-stereo-extra2; mode default";
      j = "exec pactl set-default-sink alsa_output.usb-Framework_Audio_Expansion_Card-00.analog-stereo; mode default";
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
      "${modifier}+o" = "move container to output left; focus output left";
      "${modifier}+t" = "sticky toggle";

      "${modifier}+space" = "exec ${menu}";
      "${modifier}+n" = "exec 'swaync-client -t -sw'";

      "${modifier}+Shift+s" = "exec ${screenshot_selected_area_clipboard}";
      "${modifier}+s" = "exec ${screenshot_full_clipboard}";

      "${modifier}+Shift+e" = "mode \"${mode_system}\"";
      "${modifier}+Shift+p" = "mode \"${mode_power}\"";
      "${modifier}+Shift+a" = "mode \"${mode_audio}\"";

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
    { command = "/user/libexec/polkit-gnome-authentication-agent-1" ;}
    { command = "systemctl --user import-environment"; always=true ;}
    { command = "swaync --style /etc/sway/swaync/style.css --config /etc/sway/swaync/config.json"; always=true ;}
    { command = "swayrd" ; always=true ;}
    { command = "kwalletd6" ; always=true ;}
    { command = "firefox" ;}
    { command = "discord" ;}
    { command = "nextcloud --background" ;}
  ];
}
