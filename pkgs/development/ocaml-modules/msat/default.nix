{
  lib,
  fetchFromGitHub,
  ocaml,
  buildDunePackage,
  iter,
  containers,
  mdx,
}:

buildDunePackage (finalAttrs: {
  pname = "msat";
  version = "0.9.1";

  src = fetchFromGitHub {
    owner = "Gbury";
    repo = "mSAT";
    tag = "v${finalAttrs.version}";
    hash = "sha256-ER7ZUejW+Zy3l2HIoFDYbR8iaKMvLZWaeWrOAAYXjG4=";
  };

  propagatedBuildInputs = [
    iter
  ];

  postPatch = ''
    substituteInPlace dune --replace mdx ocaml-mdx
  '';

  # mdx is not available for OCaml < 4.11
  doCheck = lib.versionAtLeast ocaml.version "4.11";
  checkInputs = [ containers ];
  nativeCheckInputs = [ mdx.out ];

  meta = {
    description = "Modular sat/smt solver with proof output";
    homepage = "https://gbury.github.io/mSAT/";
    license = lib.licenses.asl20;
    maintainers = [ lib.maintainers.vbgl ];
  };
})
