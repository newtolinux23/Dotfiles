self: super:

{
  sddm-chili = super.stdenv.mkDerivation {
    pname = "sddm-chili";
    version = "latest";
    src = super.fetchFromGitHub {
      owner = "MarianArlt";
      repo = "sddm-chili";
      rev = "6516d50176c3b34df29003726ef9708813d06271";
      sha256 = "036fxsa7m8ymmp3p40z671z163y6fcsa9a641lrxdrw225ssq5f3";
    };

    nativeBuildInputs = [ super.unzip ];

    installPhase = ''
      mkdir -p $out/share/sddm/themes/chili
      cp -r * $out/share/sddm/themes/chili
    '';
  };
}
