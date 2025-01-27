{pkgs, ...}: {
  home.packages = [
    (pkgs.python3.withPackages (ps: with ps; [
      pip
      (pkgs.python3Packages.buildPythonPackage {
        pname = "pywalfox";
        version = "2.0.11";
        src = pkgs.fetchPypi {
          inherit pname version;
          sha256 = "sha256-hash";
        };
        propagatedBuildInputs = [ ps.pip ];
      })
    ]))
  ];
}