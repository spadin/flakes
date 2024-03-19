{
  description = "NodeJS 18";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }: 
  flake-utils.lib.eachDefaultSystem (system: 
  let
    pkgs = import nixpkgs { inherit system; };
    nodejs = pkgs.nodejs_18;
  in {
    packages = {
      default = nodejs;
    };

    devShells.default = pkgs.mkShell {
      name = "nodejs-18";
      packages = [ nodejs ];
    };

  });
}
