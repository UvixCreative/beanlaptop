{ pkgs, ... }:

let
  swayidle = "${pkgs.swayidle}/bin/swayidle";
  display_dim = "${pkgs.light}/bin/light -O; ${pkgs.light}/bin/light -S 0";
  display_undim = "${pkgs.light}/bin/light -I";
  displays_off = "${pkgs.sway}/bin/sway output '*' power off";
  displays_on = "${pkgs.sway}/bin/sway output '*' power on";
  swaylock = "${pkgs.swaylock}/bin/swaylock -f -l -c 000000";
in {
  systemd.user.services.swayidle-powersaver = {
    enable = false;
    wantedBy = [ "default.target" ];
    description = "Swayidle timeouts for power saver mode";
    documentation = "man:swayidle(1)";
    serviceConfig = {
        Type = "simple";
        ExecStart = ''${swayidle} -w timeout 290 '${display_dim}' resume '${display_undim}' timeout 300 '${displays_off}' resume '${displays_on}' timeout 320 '${swaylock}; systemctl suspend' before-sleep '${displays_off}; ${swaylock}' after-resume '${displays_on}' '';
    };
  };
}
