{ lib, fetchzip, buildDunePackage, gen, ppx_tools_versioned, uchar }:

buildDunePackage rec {
  pname = "sedlex";
  version = "2.0";

  src = fetchzip {
    url = "http://github.com/ocaml-community/sedlex/archive/v${version}.tar.gz";
    sha256 = "00nrl980jk2rkrjwkbdzscbvijfz0bcy2avzvij25zn1wi0g2dpc";
  };

  buildInputs = [ ppx_tools_versioned ];

  propagatedBuildInputs = [ gen uchar ];

  doCheck = true;

  dontStrip = true;

  meta = {
    homepage = https://github.com/ocaml-community/sedlex;
    description = "An OCaml lexer generator for Unicode";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.vbgl ];
  };
}
