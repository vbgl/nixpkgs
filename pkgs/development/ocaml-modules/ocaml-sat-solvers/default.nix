{ stdenv, lib, fetchFromGitHub, ocaml, ocamlbuild, findlib, minisat, z3, z3-dev }:

lib.throwIf (lib.versionAtLeast ocaml.version "5.0")
  "ocaml-sat-solvers is not available for OCaml ≥ 5.0"

stdenv.mkDerivation rec {
  pname = "ocaml${ocaml.version}-ocaml-sat-solvers";
  version = "0.7.1";

  src = fetchFromGitHub {
    owner = "tcsprojects";
    repo = "ocaml-sat-solvers";
    rev  = "v${version}";
    hash = "sha256-hESHus3DlPp3YoqfQm/Pp1N91d9BPSGLD5FIbOeYOp8=";
  };

  nativeBuildInputs = [
    ocaml
    findlib
    ocamlbuild
  ];

  buildInputs = [ z3-dev ];

  strictDeps = true;

  configureScript = "ocaml setup.ml -configure";

  buildPhase = ''
    runHook preBuild
    ocaml setup.ml -build
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    ocaml setup.ml -install
    runHook postInstall
  '';

  createFindlibDestdir = true;

  propagatedBuildInputs = [ minisat z3 ];

  meta = {
    homepage = "https://github.com/tcsprojects/ocaml-sat-solvers";
    description = "SAT Solvers For OCaml";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ mgttlinger ];
    inherit (ocaml.meta) platforms;
  };
}
