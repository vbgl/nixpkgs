{
  stdenv,
  lib,
  fetchFromGitHub,
  ocaml,
  findlib,
  opaline,
  calendar,
  eliom,
  js_of_ocaml-ppx_deriving_json,
}:

stdenv.mkDerivation rec {
  pname = "ocsigen-toolkit";
  name = "ocaml${ocaml.version}-${pname}-${version}";
  version = "4.1.0";

  propagatedBuildInputs = [
    calendar
    js_of_ocaml-ppx_deriving_json
    eliom
  ];
  nativeBuildInputs = [
    ocaml
    findlib
    opaline
    eliom
  ];

  strictDeps = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $OCAMLFIND_DESTDIR
    export OCAMLPATH=$out/lib/ocaml/${ocaml.version}/site-lib/:$OCAMLPATH
    make install
    opaline -prefix $out
    runHook postInstall
  '';

  src = fetchFromGitHub {
    owner = "ocsigen";
    repo = pname;
    rev = "6ef5a15c2bee72650ea4ab7c1642f8a2d88c5afc";
    hash = "sha256-O9FHQzxSP0Bb7tYj1wT/ohx50tQSkrt63KwjUSHMpJg=";
  };

  meta = {
    homepage = "http://ocsigen.org/ocsigen-toolkit/";
    description = "User interface widgets for Ocsigen applications";
    license = lib.licenses.lgpl21;
    maintainers = [ lib.maintainers.gal_bolle ];
    inherit (ocaml.meta) platforms;
  };

}
