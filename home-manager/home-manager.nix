{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.ben = import ./ben/home.nix;
  };
}
