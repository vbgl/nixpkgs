{
  lib,
  stdenv,
  fetchurl,
  buildDunePackage,
  ocaml,
  findlib,
  alcotest,
  astring,
  cmdliner,
  cppo,
  fmt,
  logs,
  ocaml-version,
  camlp-streams,
  lwt,
  re,
  result,
  csexp,
  gitUpdater,
}:

buildDunePackage (finalAttrs: {
  pname = "mdx";
  version = "2.6.0";

  src = fetchurl {
    url = "https://github.com/realworldocaml/mdx/releases/download/${finalAttrs.version}/mdx-${finalAttrs.version}.tbz";
    hash = "sha256-OAEfnA0LogRP34whxTCsgGIR57cw2qUoJ5iODH5Ddjw=";
  };

  minimalOCamlVersion = "4.11";

  env =
    # Fix build with gcc15
    lib.optionalAttrs
      (
        lib.versionAtLeast ocaml.version "4.10" && lib.versionOlder ocaml.version "4.14"
        || lib.versions.majorMinor ocaml.version == "5.0"
      )
      {
        NIX_CFLAGS_COMPILE = "-std=gnu11";
      };

  nativeBuildInputs = [ cppo ];
  propagatedBuildInputs = [
    astring
    fmt
    logs
    csexp
    cmdliner
    ocaml-version
    camlp-streams
    re
    result
    findlib
  ];
  checkInputs = [
    alcotest
    lwt
  ];

  doCheck = !stdenv.hostPlatform.isDarwin;

  passthru.updateScript = gitUpdater { };

  meta = {
    description = "Executable OCaml code blocks inside markdown files";
    homepage = "https://github.com/realworldocaml/mdx";
    changelog = "https://github.com/realworldocaml/mdx/raw/${finalAttrs.version}/CHANGES.md";
    license = lib.licenses.isc;
    maintainers = [ lib.maintainers.romildo ];
    mainProgram = "ocaml-mdx";
  };
})
