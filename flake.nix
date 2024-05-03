{
        description = "test idk";
        inputs = {
                nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
                home-manager = {
                        url = "github:nix-community/home-manager";
                        inputs.nixpkgs.follows = "nixpkgs";
                };
		nix-flatpak.url = "github:gmodena/nix-flatpak";
                nixos-hardware.url = "github:NixOS/nixos-hardware";
        };

        outputs = inputs@{ nixpkgs, home-manager, nix-flatpak, nixos-hardware, ... }: {
		nixosConfigurations.beanmachine = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				nixos-hardware.nixosModules.framework-16-7040-amd
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
			];
		};
	};
}
