{ pkgs, ... }: {
  home.packages = with pkgs; [
    (python3.withPackages (ps: with ps; [
      pip
      (ps.buildPythonPackage rec {
        pname = "pywalfox";
        version = "0.3.5";
        src = pkgs.fetchurl {
          url = "https://github.com/Frewacom/pywalfox/releases/download/v2.0.11/pywalfox-2.0.11.zip";
          sha256 = "0839e6c003341e192a7be1802fa40d8b05842dad1a3a3beac88f67fba8149dec";
        };
        doCheck = false;
        nativeBuildInputs = [ ps.flit ];
      })
    ]))
  ];
}