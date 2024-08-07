{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  pname = "sddm-chili";
  version = "latest";
  src = pkgs.fetchFromGitHub {
    owner = "MarianArlt";
    repo = "sddm-chili";
    rev = "6516d50176c3b34df29003726ef9708813d06271";
    sha256 = "036fxsa7m8ymmp3p40z671z163y6fcsa9a641lrxdrw225ssq5f3";
  };

  nativeBuildInputs = [ pkgs.unzip ];

  installPhase = ''
    mkdir -p $out/share/sddm/themes/chili
    cp -r * $out/share/sddm/themes/chili
  '';
}
