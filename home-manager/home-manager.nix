{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.bean = import ./bean/home.nix;
  };
}
