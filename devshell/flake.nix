{
  description = "Testing out devshell feature";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    devshell.url = "github:numtide/devshell";
  };

  outputs = {
    flake-parts,
    ...
  } @ inputs:
  flake-parts.lib.mkFlake {inherit inputs;} {
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    imports = [
      inputs.devshell.flakeModule
    ];

    perSystem = { config, pkgs, ... }: {
      devshells.default = {
        env = [
          {
            name = "HTTP_PORT";
            value = 8080;
          }
        ];

        commands = [
          {
            help = "print hello";
            name = "hello";
            command = "echo hello";
          }
        ];

        packages = [
          pkgs.cowsay
        ];
      };
    };
  };
}

