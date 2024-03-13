{
  description = "My development environment, someday";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    nixvim = {
      url = "../nixvim/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tmux = {
      url = "../tmux/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixvim,
    flake-parts,
    ...
  } @ inputs:
  flake-parts.lib.mkFlake { inherit inputs; } {
    debug = true;

    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    perSystem = {
      pkgs,
      config,
      system,
      devShells,
      inputs',
      ...
    }: let
      # system = "aarch64-darwin"; # "x86_64-linux"
      # pkgs = pkgs.legacyPackages.${system};
      nvim = inputs'.nixvim.packages.default;
      tmux = inputs'.tmux.packages.default;
      cowsay = pkgs.cowsay;
      # config = {
      #   config = {
      #     shortcut = "a";
      #   };
      # };
    in
    {
      # devShells.${system}.default = nvim.devShells;

      packages = {
        default = nvim;
        cowsay = pkgs.cowsay;
        tmux = tmux;
      };

      devShells.default = pkgs.mkShell {
        buildInputs = [nvim cowsay tmux];
      };
    };
  };
}
