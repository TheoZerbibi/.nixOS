{ pkgs, ... }: {
  home.packages = with pkgs; [
    pywalfox-native
    (python3.withPackages (ps: with ps; [
      pip
    ]))
  ];
}