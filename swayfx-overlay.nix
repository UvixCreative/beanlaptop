({ config, pkgs, ... }: {
  nixpkgs.overlays = let
    version = "2024-04-27";
  in [(
    final: prev: {
      swayfx-unwrapped = prev.swayfx-unwrapped.overrideAttrs (oldAttrs: {
        inherit version;
        src = prev.fetchFromGitHub {
          owner = "WillPower3309";
          repo = "swayfx";
          rev = "a5a69d4d4e9a8fe306e27ca46cde3a8b9d312ae3";
          sha256 = "sha256-aQVHGi6oqceTlyzzzZnErVHYDJbDfG0sdWe+ItuH8a4=";
        };
      });

      swayfx = (prev.swayfx.override (oldArgs: {
        swayfx-unwrapped = final.swayfx-unwrapped;
      })).overrideAttrs (oldAttrs: {
        inherit version;
      });
    }
  )];
})
