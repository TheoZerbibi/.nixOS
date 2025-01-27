{nixpkgs, pkgs, lib, ...}: {
  home.packages = with nixpkgs.unstable; [
    (pkgs.python3.withPackages (ps: with ps; [
      pip
    ]))
  ];
  home.activation.installPywalfox = {
    text = ''
      #!/usr/bin/env bash
      if ! pip show pywalfox &>/dev/null; then
        echo "Installing pywalfox..."
        pip install --user pywalfox
      fi
    '';
    enable = true;
  };

}
