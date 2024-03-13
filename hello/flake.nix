{
  description = "hello";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
  flake-utils.lib.eachDefaultSystem(system:
  let
    pkgs = import nixpkgs { inherit system; };
    hello = pkgs.hello;
  in{
    packages = {
      inherit hello;
      default = hello;
    };
  });
}
