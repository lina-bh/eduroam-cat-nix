{
  pkgs,
  lib ? pkgs.lib,
  profile,
  institution-name,
  version,
  hash ? "",
}:
let
  pname = "eduroam-linux-${institution-name}";
in
pkgs.stdenvNoCC.mkDerivation {
  inherit pname version;
  src = pkgs.fetchurl {
    inherit hash;
    url = "https://cat.eduroam.org/user/API.php?action=downloadInstaller&profile=${toString profile}&device=linux";
  };
  dontUnpack = true;
  dontBuild = true;
  buildInputs = [
    (pkgs.python3.withPackages (
      pythonPackages: with pythonPackages; [
        pyopenssl
        tkinter
        dbus-python
      ]
    ))
  ];
  installPhase = ''
    mkdir -p $out/bin
    install -m 0755 $src $out/bin/${pname}.py
  '';
  meta.mainProgram = "${pname}.py";
}
