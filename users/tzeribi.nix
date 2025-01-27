{
  home-manager.backupFileExtension = "backup";

  imports = [
    ./dev.nix
    ./firefox.nix
    ./ghostty.nix
    ./git.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./python.nix
    ./vscode.nix
    ./zsh.nix
  ];
}
