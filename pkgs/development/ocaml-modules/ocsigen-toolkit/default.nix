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
  version = "4.1.0-git-20250422";

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
    rev = "5127728cfdf1f5370b8640928ce5edbc9404e02d";
    hash = "sha256-zUZt6cBhMjT3ZO5R4qoEU0EEET3QWvLyY7nFZ/PRx0M=";
  };

  meta = {
    homepage = "http://ocsigen.org/ocsigen-toolkit/";
    description = "User interface widgets for Ocsigen applications";
    license = lib.licenses.lgpl21;
    maintainers = [ lib.maintainers.gal_bolle ];
    inherit (ocaml.meta) platforms;
  };

}
