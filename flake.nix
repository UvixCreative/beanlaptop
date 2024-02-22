{
        description = "test idk";
        inputs = {
                nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
                home-manager = {
                        url = "github:nix-community/home-manager";
                        inputs.nixpkgs.follows = "nixpkgs";
                };
        };

        outputs = inputs@{ nixpkgs, home-manager, ... }: {
		nixosConfigurations.beanmachine = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager
				./home-manager/home-manager.nix
			];
		};
	};
}
