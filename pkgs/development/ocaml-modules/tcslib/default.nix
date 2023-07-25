{ lib, fetchFromGitHub, stdenv, ocaml, findlib, ocamlbuild, camlp-streams, extlib, num }:

lib.throwIf (lib.versionOlder ocaml.version "4.03")
  "tcslib is not available for OCaml ${ocaml.version}"

stdenv.mkDerivation rec {
  pname = "ocaml${ocaml.version}-tcslib";
  version = "0.3";

  src = fetchFromGitHub {
    owner  = "tcsprojects";
    repo   = "tcslib";
    rev    = "v${version}";
    sha256 = "05g6m82blsccq8wx8knxv6a5fzww7hi624jx91f9h87nk2fsplhi";
  };

  postPatch = lib.optionalString (lib.versionAtLeast ocaml.version "4.07") ''
    substituteInPlace src/data/tcsset.ml --replace Pervasives. Stdlib.
  '';

  strictDeps = true;

  nativeBuildInputs = [ ocaml ocamlbuild findlib ];
  buildInputs = [ camlp-streams ocamlbuild ];

  buildPhase = ''
    runHook preBuild
    ocamlbuild -use-ocamlfind -plugin-tag 'package(camlp-streams)' src/TCSLib.cma src/TCSLib.cmxs
    runHook postBuild
  '';

  createFindlibDestdir = true;

  installPhase = ''
    runHook preInstall
    find _build/src -name '*.cm[aitx]*' | xargs ocamlfind install TCSLib src/META _build/src/TCSLib.a
    runHook postInstall
  '';

  propagatedBuildInputs = [ extlib num ];

  meta = {
    homepage = "https://github.com/tcsprojects/tcslib";
    description = "A multi-purpose library for OCaml";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ mgttlinger ];
  };
}
