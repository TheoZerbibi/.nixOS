{...}: {
  programs.git = {
    enable = true;

    userName = "Theo ZERIBI";
    userEmail = "theo.zeribi.invisensing.io";

    ignores = [".env"];
    lfs.enable = true;

    extraConfig = {
      init.defaultBranch = "main";

      gpg.format = "ssh";
      commit.gpgsign = true;
      tag.forceSignAnnotated = true;
    };
  };

  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };
}