{ lib, config, pkgs, ... }:
let
  cfg = config.main-user;
in
{
  options.main-user = {
    enable = lib.mkEnableOption "Enable the main user module (theo).";

    userName = lib.mkOption {
      type = lib.types.str;
      default = "theo";
      description = "Name for the main user with root privileges.";
    };
  };

  config = lib.mkIf cfg.enable {
    users.users."${cfg.userName}" = {
      isNormalUser   = true;    # => UID=0, c’est le compte root
      description    = "Root user named theo";
      initialPassword = "1234";  # à changer rapidement
      # On peut ajouter extraGroups si on veut, mais root en a peu besoin
      extraGroups = [ "wheel" ];
      shell = pkgs.zsh;
    };
  };
}
