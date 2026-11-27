{
  lib,
  fetchurl,
  ocaml,
  buildDunePackage,
  mdx,
  ounit2,
  qcheck-core,
}:

buildDunePackage (finalAttrs: {
  pname = "iter";
  version = "1.9";

  src = fetchurl {
    url = "https://github.com/c-cube/iter/releases/download/v${finalAttrs.version}/iter-${finalAttrs.version}.tbz";
    hash = "sha256-26nluxUuDQ2wBUw2sqlHZ0eihKdzjxXxGVo+IDXH6Wg=";
  };

  # mdx is not available for OCaml < 4.11
  doCheck = lib.versionAtLeast ocaml.version "4.11";
  nativeCheckInputs = [ mdx.out ];
  checkInputs = [
    ounit2
    qcheck-core
  ];

  meta = {
    homepage = "https://github.com/c-cube/sequence";
    description = "Simple sequence (iterator) datatype and combinators";
    longDescription = ''
      Simple sequence datatype, intended to transfer a finite number of
      elements from one data structure to another. Some transformations on sequences,
      like `filter`, `map`, `take`, `drop` and `append` can be performed before the
      sequence is iterated/folded on.
    '';
    license = lib.licenses.bsd2;
  };
})
