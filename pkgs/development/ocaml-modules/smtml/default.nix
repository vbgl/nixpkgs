{
  lib,
  stdenv,
  buildDunePackage,
  ocaml,
  fetchpatch,
  fetchFromGitHub,
  menhir,
  darwin,
  bitwuzla-cxx,
  bos,
  cmdliner,
  dolmen_model,
  dolmen_type,
  dune-build-info,
  dune-site,
  fpath,
  hc,
  menhirLib,
  mtime,
  # fix eval on legacy ocaml versions
  ocaml_intrinsics ? null,
  prelude,
  ppx_enumerate,
  rresult,
  scfg,
  yojson,
  z3,
  zarith,
  mdx,
  ounit2,
}:

buildDunePackage (finalAttrs: {
  pname = "smtml";
  version = "0.25.0";

  src = fetchFromGitHub {
    owner = "formalsec";
    repo = "smtml";
    tag = "v${finalAttrs.version}";
    hash = "sha256-dWZrN0hTxxqGC2queit91GDuw/x5fyRPwHbmKxkvc/w=";
  };

  patches = [
    (fetchpatch {
      url = "https://github.com/formalsec/smtml/commit/c3d55a4c93f322e3d7834ea441fca913a093ef2a.patch";
      hash = "sha256-WPwU8x6aSc/IF0zRr6DWIMBuZbWN6yeJmSzK6QYfQXU=";
    })
  ];

  minimalOCamlVersion = "4.14";

  nativeBuildInputs = [
    menhir
  ]
  ++ lib.optionals stdenv.hostPlatform.isDarwin [
    darwin.sigtool
  ];

  buildInputs = [
    dune-build-info
    dune-site
  ];

  propagatedBuildInputs = [
    bitwuzla-cxx
    bos
    cmdliner
    dolmen_model
    dolmen_type
    fpath
    hc
    menhirLib
    mtime
    ocaml_intrinsics
    ppx_enumerate
    prelude
    rresult
    scfg
    yojson
    z3
    zarith
  ];

  checkInputs = [
    mdx
    ounit2
  ];

  nativeCheckInputs = [
    mdx.bin
  ];

  doCheck =
    # Checks fail with cmdliner ≥ 2.0
    false
    && !(
      lib.versions.majorMinor ocaml.version == "5.0"
      || lib.versions.majorMinor ocaml.version == "5.4"
      || stdenv.hostPlatform.isDarwin
    );

  meta = {
    description = "SMT solver frontend for OCaml";
    homepage = "https://formalsec.github.io/smtml/smtml/";
    downloadPage = "https://github.com/formalsec/smtml";
    changelog = "https://github.com/formalsec/smtml/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.mit;
    teams = with lib.teams; [ ngi ];
    maintainers = with lib.maintainers; [
      ethancedwards8
      redianthus
    ];
  };
})
