{nixpkgs, ...}: {
  home.packages = with nixpkgs.unstable; [
    python3
  ];
}