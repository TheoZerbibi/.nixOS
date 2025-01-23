{nixpkgs, pkgs, lib, ...}: {
  home.packages = with nixpkgs.unstable; [
    (pkgs.python3.withPackages (ps: with ps; [
      pip
    ]))
  ];
}
