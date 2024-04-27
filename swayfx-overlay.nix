{config, pkgs, lib, ...}: {		nixpkgs.overlays = [
			(self: super:
			{
				swayfx = super.swayfx.overrideAttrs (oldArrts: rec {
					version = "a5a69d";
					src = super.fetchFromGitHub {
						owner = "WillPower3309";
						repo = "swayfx";
						rev = "a5a69d4d4e9a8fe306e27ca46cde3a8b9d312ae3";
						sha256 = "sha256-aQVHGi6oqceTlyzzzZnErVHYDJbDfG0sdWe+ItuH8a4=";
					};
				});
			})
		];}
