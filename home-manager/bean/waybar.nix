{
  mainBar = {
    layer = "top";
    position = "top";
    height = 30;
    spacing = 4;
    modules-left = [ "sway/workspaces" "sway/mode" ];
    modules-center = [ ];
    modules-right = [ "tray" "network" "bluetooth" "cpu" "memory" "battery" "pulseaudio" "clock" ];

    "sway/mode" = {
      format = "> {}";
    };

    "sway/workspaces" = {
      all-outputs = false;
      disable-scroll = true;
      format = " {icon} ";
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

    "network" = {
      format-wifi = "{essid} ({signalStrength}%) ";
      format-ethernet = "{ipaddr}/{cidr} ";
      tooltip-format = "{ifname} via {gwaddr} ";
      format-linked = "{ifname} (No IP) ";
      format-disconnected = "Disconnected ⚠";
      format-alt = "{ifname}: {ipaddr}/{cidr}";
    };

    "pulseaudio" = {
      format = "{volume}% {icon} {format_source}";
      format-bluetooth = "{volume}% {icon} {format_source}";
      format-bluetooth-muted = " {icon} {format_source}";
      format-muted = " {format_source}";
      format-source = "{volume}% ";
      format-source-muted = "";
      format-icons = {
        headphone = "";
        hands-free = "";
        headset = "";
          phone = "";
          portable = "";
          car = "";
          default = ["" "" ""];
     };
     on-click = "pavucontrol";
    };
  };
}
