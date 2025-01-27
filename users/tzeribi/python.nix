{ pkgs, ... }: {
  home.packages = with pkgs; [
    (python3.withPackages (ps: with ps; [
      pip
      (ps.buildPythonPackage rec {
        pname = "pywalfox";
        version = "0.3.5";
        src = fetchPypi {
          inherit pname version;
          sha256 = "0cv6v11ygrljcfy6w2pzi8418wk4yrx10xrpbahkciwcij3p71bj";
        };
        propagatedBuildInputs = [];
      })
    ]))
  ];
}
