{ pkgs, ... }: {
  home.packages = with pkgs; [
    (python3.withPackages (ps: with ps; [
      pip
      (ps.buildPythonPackage rec {
        pname = "pywalfox";
        version = "2.0.11";
        src = fetchPypi {
          inherit pname version;
          sha256 = "0gr3rczbd5hj3q6gk10biig8nv3mzxb8k4ywpfzps9y6hrfl9xl6";
        };
        propagatedBuildInputs = [];
      })
    ]))
  ];
}
