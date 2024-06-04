{ lib, pkgs, ... }:

let
  swayidle = "${pkgs.swayidle}/bin/swayidle";
  display_dim = "${pkgs.light}/bin/light -O; ${pkgs.light}/bin/light -S 0";
  display_undim = "${pkgs.light}/bin/light -I";
  displays_off = "${pkgs.sway}/bin/sway output '*' power off";
  displays_on = "${pkgs.sway}/bin/sway output '*' power on";
  swaylock = "${pkgs.swaylock}/bin/swaylock -f -l -c 000000";
  to = { # timeouts
    s = {
      display_off = 5;
      suspend = 10;
    };
    b = {
      display_off = 10;
      suspend = 30;
    };
    p = {
      display_off = 20;
      suspend = 60;
    };
  };
    
in rec {
  systemd.user.services = {
    swayidle-powersaver = {
      enable = true;
      description = "Swayidle timeouts for power saver mode";
      documentation = ["man:swayidle(1)"];
      environment.PATH = lib.mkForce "${pkgs.bash}/bin";
      conflicts = [ "swayidle-balanced.service" "swayidle-performance.service" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = ''${swayidle} -w timeout ${toString ((to.s.display_off * 60) - 10)} '${display_dim}' resume '${display_undim}' timeout ${toString (to.s.display_off * 60)} '${displays_off}' resume '${displays_on}' timeout ${toString (to.s.suspend * 60)} '${swaylock}; systemctl suspend' before-sleep '${displays_off}; ${swaylock}' after-resume '${displays_on}' '';
      };
    };
    swayidle-balanced = {
      enable = true;
      wantedBy = [ "default.target" ];
      description = "Swayidle timeouts for balanced mode";
      documentation = ["man:swayidle(1)"];
      environment.PATH = lib.mkForce "${pkgs.bash}/bin";
      conflicts = [ "swayidle-powersaver.service" "swayidle-performance.service" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = ''${swayidle} -w timeout ${toString ((to.b.display_off * 60) - 10)} '${display_dim}' resume '${display_undim}' timeout ${toString (to.b.display_off * 60)} '${displays_off}' resume '${displays_on}' timeout ${toString (to.b.suspend * 60)} '${swaylock}; systemctl suspend' before-sleep '${displays_off}; ${swaylock}' after-resume '${displays_on}' '';
      };
    };
    swayidle-performance = {
      enable = true;
      description = "Swayidle timeouts for performance mode";
      documentation = ["man:swayidle(1)"];
      environment.PATH = lib.mkForce "${pkgs.bash}/bin";
      conflicts = [ "swayidle-powersaver.service" "swayidle-balanced.service" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = ''${swayidle} -w timeout ${toString ((to.p.display_off * 60) - 10)} '${display_dim}' resume '${display_undim}' timeout ${toString (to.p.display_off * 60)} '${displays_off}' resume '${displays_on}' timeout ${toString (to.p.suspend * 60)} '${swaylock}; systemctl suspend' before-sleep '${displays_off}; ${swaylock}' after-resume '${displays_on}' '';
      };
    };
  };
}
