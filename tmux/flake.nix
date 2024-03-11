{
  description = "Tmux config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = { nixpkgs, flake-parts, self, ... } @ inputs:
  flake-parts.lib.mkFlake { inherit inputs; } {
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    perSystem = { system, self', ... }: let
      pkgs = import nixpkgs {
        inherit system;

        config = {
          programs.tmux = {
            shortcut = "a";
          };
        };
      };

      tmux = pkgs.tmux;
    in
    {
      packages = {
        default = tmux;
      };
    };
  };
}
