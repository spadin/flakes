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
    old-pkgs = import (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/976fa3369d722e76f37c77493d99829540d43845.tar.gz";
      sha256 = "1r6c7ggdk0546wzf2hvd5a7jwzsf3gn1flr8vjd685rm74syxv6d"; 
    }) {
      inherit system;

      config = {
        permittedInsecurePackages = [ "nodejs-18.17.1" ];
      };
    };
    nodejs = old-pkgs.nodejs_18;
  in {
    env = {
      NIXPKGS_ALLOW_INSECURE = 1;
    };

    packages = {
      default = nodejs;
    };

    devShells.default = pkgs.mkShell {
      name = "nodejs-18";
      packages = [ nodejs ];
    };

  });
}
