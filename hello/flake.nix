{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
      system = "aarch64-darwin"; # "x86_64-linux"
      pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    devShells.${system}.default =
      pkgs.mkShell 
        {
          buildInputs = [
            pkgs.neovim
              pkgs.vim
          ];

          shellHook = ''
            echo "Hola there!"
          '';
        };
  };
}
