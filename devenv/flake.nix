{
  description = "My development environment, someday";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixvim.url = "../nixvim/";
  };

  outputs = { self, nixpkgs, nixvim }:
  let
    system = "aarch64-darwin"; # "x86_64-linux"
    pkgs = nixpkgs.legacyPackages.${system};
    nvim = nixvim;
  in
  {
    devShells.${system}.default = nvim.devShells;
  };
}
