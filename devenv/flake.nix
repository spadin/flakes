{
  description = "My development environment, someday";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixvim'.url = "github:spadin/flakes#nixvim";
  };

  outputs = { self, nixpkgs, nixvim', ... }:
  let
    system = "aarch64-darwin"; # "x86_64-linux"
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    devShells.${system}.default =
      pkgs.mkShell 
      {
        buildInputs = [
          nixvim'
        ];

        shellHook = ''
        echo "Hola there!"
        '';
      };
    };
  }
