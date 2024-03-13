{
  description = "NodeJS 16";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }: 
  flake-utils.lib.eachDefaultSystem (system: 
  let
    pkgs = import nixpkgs { inherit system; };
    old-pkgs = import (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/9957cd48326fe8dbd52fdc50dd2502307f188b0d.tar.gz";
      sha256 = "1l2hq1n1jl2l64fdcpq3jrfphaz10sd1cpsax3xdya0xgsncgcsi"; 
    }) {
      inherit system;

      config = {
        permittedInsecurePackages = [ "nodejs-16.20.2" ];
      };
    };
    nodejs = old-pkgs.nodejs_16;
  in {
    env = {
      NIXPKGS_ALLOW_INSECURE = 1;
    };

    packages = {
      default = nodejs;
    };

    devShells.default = pkgs.mkShell {
      name = "nodejs-16";
      packages = [ nodejs ];
    };

  });
}
