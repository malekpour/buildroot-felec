{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        crossPkgs = pkgs.pkgsCross.aarch64-multiplatform;
      in {
        devShell = pkgs.mkShellNoCC {
          buildInputs = with pkgs; [
            # tools
            file
            gcc
            bc
            rsync
            unzip
            libxcrypt

            # AArch64 cross toolchain (binaries: aarch64-unknown-linux-gnu-gcc, etc.)
            crossPkgs.buildPackages.binutils
            crossPkgs.buildPackages.gcc
          ];

          shellHook = ''
            export PS1="[🏗️ buildroot] \u@\h:\w\$ "
          '';
        };
      }
    );
}