let 
  pa_toggle_popup = "swaymsg [app_id='pa_popup'] focus && swaymsg kill || pavucontrol --name=pa_popup & sleep 0.5 && swaymsg [app_id='pa_popup'] focus && swaymsg resize set 30 ppt 30 ppt && swaymsg move position 70 ppt 0";
in {
  mainBar = {
    layer = "top";
    position = "top";
    height = 30;
    spacing = 4;
    modules-left = [ "sway/workspaces" "sway/mode" ];
    modules-center = [ "sway/window" ];
    modules-right = [ "tray" "network" "bluetooth" "cpu" "memory" "battery" "pulseaudio" "clock" ];

    "sway/mode" = {
      format = "> {}";
    };

    "sway/workspaces" = {
      all-outputs = false;
      disable-scroll = true;
      format = " {icon} ";
    };

    "sway/window" = {
      on-click = "krunner";
    };

    "tray" = {
      spacing = 5;
    };

    "clock" = {
      format = "{:%b %d %Y %R}";
      tooltip-format = "<tt><small>{calendar}</small></tt>";
      calendar = {
        mode-mon-col = 4;
        weeks-pos = "left";
        on-scroll = 1;
        on-click-right = "mode";
      };
      on-click = "swaync-client -t -sw";
    };

    "cpu" = {
      format = "{usage}% ";
    };

    "memory" = {
      format = "{}% ";
    };

    "battery" = {
      full-at = 80;
      format = "{capacity}% {icon}";
      format-icons = ["" "" "" "" ""];
      states = {
        "critical" = 15;
      };
    };

    "network" = {
      format-wifi = "{essid} ({signalStrength}%) ";
      format-ethernet = "{ipaddr}/{cidr} ";
      tooltip-format = "{ifname} via {gwaddr} ";
      format-linked = "{ifname} (No IP) ";
      format-disconnected = "Disconnected ⚠";
      format-alt = "{ifname}: {ipaddr}/{cidr}";
    };

    "pulseaudio" = {
      format = "{volume}% {icon}";
      format-bluetooth = "{volume}% {icon}";
      format-bluetooth-muted = " {icon}";
      format-icons = {
        headphone = "";
        hands-free = "";
        headset = "";
          phone = "";
          portable = "";
          car = "";
          default = ["" "" ""];
     };
     on-click = pa_toggle_popup;
    };

    "bluetooth" = {
      on-click = "plasma-open-settings kcm_bluetooth";
    };
  };
}
