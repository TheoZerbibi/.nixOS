{pkgs, ...}: {
  home.packages = [
    (pkgs.python3.withPackages (ps: with ps; [
      pip
      (pkgs.python3Packages.buildPythonPackage {
        pname = "pywalfox";
        version = "2.0.11";
        src = pkgs.fetchPypi {
          inherit pname version;
          sha256 = "0gr3rczbd5hj3q6gk10biig8nv3mzxb8k4ywpfzps9y6hrfl9xl6";
        };
        propagatedBuildInputs = [ ps.pip ];
      })
    ]))
  ];
}
