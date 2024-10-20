{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in
    flake-utils.lib.eachSystem
      (with flake-utils.lib.system; [
        x86_64-linux
        aarch64-linux
      ])
      (system: {
        packages.eduroam-linux-UoG = import ./make-eduroam-pkg.nix {
          inherit pkgs;
          profile = 574;
          institution-name = "UoG";
          version = "1";
          hash = "sha256-4fHkfknkjIOCt0pp3RLqDd197jk4RTPWIVZI1t5Ou/4=";
        };
      });
}
