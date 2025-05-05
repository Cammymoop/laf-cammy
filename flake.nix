{
  description = "Cammy's dev environment flake for aseprite/laf";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        packages.default = pkgs.hello;
        
        devShells.default = pkgs.mkShell {
          stdenv = pkgs.gcc13Stdenv;
          nativeBuildInputs = with pkgs; [ gcc13 ninja cmake clang-tools ];
          buildInputs = with pkgs; [
            pixman
            libpng
            freetype
            harfbuzz
            xorg.libX11
            xorg.libxcb
            xorg.libXcursor
            xorg.libXi
          ];
        };
      };
    };
}
