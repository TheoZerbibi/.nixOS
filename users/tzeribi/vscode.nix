{nixpkgs, ...}: {
  home.packages = with nixpkgs.unstable; [
    vscode
  ];
}