{
  description = "My development environment, someday";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    mynixvim.url = "../nixvim/";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = {
    nixpkgs,
    mynixvim,
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
      nvim = inputs'.mynixvim.packages.default;
      cowsay = pkgs.cowsay;
      tmux = pkgs.tmux;
      # config = {
      #   config = {
      #     shortcut = "a";
      #   };
      # };
    in
    {
      # devShells.${system}.default = nvim.devShells;

      tmux-overlays = {
        config = {
          shortcut = "a";
        };
      };

      packages = {
        default = nvim;
        cowsay = pkgs.cowsay;
        tmux = tmux;
      };

      overlayAttrs = final: prev: {
        tmux = prev.tmux.override {
          shortcut = "a";
        };
      };

      devShells.default = pkgs.mkShell {
        buildInputs = [nvim cowsay tmux];

        shellHook = ''
          tmux new-session -s devenv
        '';
      };
    };
  };
}
