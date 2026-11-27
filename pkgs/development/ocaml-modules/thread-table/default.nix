{
  lib,
  ocaml,
  fetchurl,
  buildDunePackage,
  alcotest,
  mdx,
}:

buildDunePackage (finalAttrs: {
  pname = "thread-table";
  version = "1.0.0";

  src = fetchurl {
    url = "https://github.com/ocaml-multicore/thread-table/releases/download/${finalAttrs.version}/thread-table-${finalAttrs.version}.tbz";
    hash = "sha256-pIzYhGNZfflELEuqaczAYJHKd7px5DjTYJ+64PO4Hd0=";
  };

  # mdx is not available for OCaml < 4.11
  doCheck = lib.versionAtLeast ocaml.version "4.11";

  checkInputs = [
    alcotest
    mdx
  ];

  nativeCheckInputs = [
    mdx.out
  ];

  meta = {
    homepage = "https://github.com/ocaml-multicore/ocaml-thread-table";
    changelog = "https://github.com/ocaml-multicore/ocaml-thread-table/raw/${finalAttrs.version}/CHANGES.md";
    description = "Lock-free thread-safe integer keyed hash table";
    license = lib.licenses.isc;
    maintainers = with lib.maintainers; [ toastal ];
  };
})
