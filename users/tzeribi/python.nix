{ pkgs, ... }: {
  home.packages = with pkgs; [
    (python3.withPackages (ps: with ps; [
      pip
      (ps.buildPythonPackage rec {
        pname = "pywalfox";
        version = "0.3.5";
        src = pkgs.fetchurl {
          url = "https://files.pythonhosted.org/packages/b7/cc/c31688b9d5d4ddc73d713cde14c5ab09a95046fb0ede2e6fa7ee7e904900/pywolf-0.3.5.tar.gz";
          sha256 = "0cv6v11ygrljcfy6w2pzi8418wk4yrx10xrpbahkciwcij3p71bj";
        };
        doCheck = false;
        propagatedBuildInputs = [];
      })
    ]))
  ];
}