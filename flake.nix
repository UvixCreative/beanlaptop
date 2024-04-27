{
        description = "test idk";
        inputs = {
                nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
                home-manager = {
                        url = "github:nix-community/home-manager";
                        inputs.nixpkgs.follows = "nixpkgs";
                };
		nix-flatpak.url = "github:gmodena/nix-flatpak";
		swayfx = {
			url = "github:WillPower3309/swayfx";
			inputs.nixpkgs.follows = "nixpkgs";
		};
        };

        outputs = inputs@{ nixpkgs, home-manager, nix-flatpak, swayfx, ... }: {
		nixosConfigurations.beanmachine = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./configuration.nix
				./machines/beanmachine.nix
				home-manager.nixosModules.home-manager
				nix-flatpak.nixosModules.nix-flatpak
			];
		};
		nixosConfigurations.bl-lab = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./configuration.nix
				./machines/bl-lab.nix
				home-manager.nixosModules.home-manager
				nix-flatpak.nixosModules.nix-flatpak
				({...}: {nixpkgs.overlays = [
					swayfx.overlays.default
				];})
			];
		};
	};
}
