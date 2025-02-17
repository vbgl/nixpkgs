{
  lib,
  fetchurl,
  buildDunePackage,
  cppo,
  gettext,
  dune-site,
  fileutils,
  ounit2,
}:

buildDunePackage rec {
  pname = "gettext";
  version = "0.5.0";

  src = fetchurl {
    url = "https://github.com/gildor478/ocaml-gettext/releases/download/v${version}/gettext-${version}.tbz";
    hash = "sha256-CN2d9Vsq8YOOIxK+S+lCtDddvBjCrtDKGSRIh1DjT10=";
  };

  nativeBuildInputs = [ cppo ];

  propagatedBuildInputs = [
    gettext
    dune-site
    fileutils
  ];

  # Tests of version 0.5.0 fail
  doCheck = false;

  checkInputs = [ ounit2 ];

  meta = with lib; {
    description = "OCaml Bindings to gettext";
    homepage = "https://github.com/gildor478/ocaml-gettext";
    license = licenses.lgpl21;
    maintainers = [ ];
    mainProgram = "ocaml-gettext";
  };
}
