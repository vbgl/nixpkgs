{
  lib,
  stdenv,
  fetchFromGitLab,
  ocamlPackages,
  dune_3,
}:

stdenv.mkDerivation {

  pname = "acgtk";
  version = "2.2.0";

  src = fetchFromGitLab {
    domain = "gitlab.inria.fr";
    owner = "acg";
    repo = "dev/acgtk";
    tag = "release-2.2.0";
    hash = "sha256-cDP41a3CHh+KW2PAZ3WTRA2HTXKhb8mMCTNddv6M8Bg=";
  };

  strictDeps = true;

  nativeBuildInputs = with ocamlPackages; [
    menhir
    ocaml
    findlib
    dune_3
    js_of_ocaml
  ];

  buildInputs = with ocamlPackages; [
    ansiterminal
    cmdliner
    dune-site
    fmt
    js_of_ocaml
    js_of_ocaml-ppx
    js_of_ocaml-tyxml
    logs
    menhirLib
    mtime
    ocamlgraph
    readline
    sedlex
    yojson
  ];

  buildPhase = ''
    runHook preBuild
    dune build --profile=release ''${enableParallelBuilding:+-j $NIX_BUILD_CORES}
    runHook postBuild
  '';

  installPhase = ''
    dune install --prefix $out --libdir $OCAMLFIND_DESTDIR
  '';

  meta = {
    homepage = "https://acg.loria.fr/";
    description = "Toolkit for developing ACG signatures and lexicon";
    license = lib.licenses.cecill20;
    inherit (ocamlPackages.ocaml.meta) platforms;
    maintainers = with lib.maintainers; [ jirkamarsik ];
  };
}
