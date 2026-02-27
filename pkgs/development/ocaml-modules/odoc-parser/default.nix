{
  lib,
  fetchurl,
  buildDunePackage,
  astring,
  camlp-streams,
}:

buildDunePackage (finalAttrs: {
  pname = "odoc-parser";
  version = "3.1.0";

  src = fetchurl {
    url = "https://github.com/ocaml/odoc/releases/download/${finalAttrs.version}/odoc-${finalAttrs.version}.tbz";
    hash = "sha256-NVs8//STSQPLrti1HONeMz6GCZMtIwKUIAqfLUL/qRQ=";
  };

  propagatedBuildInputs = [
    astring
    camlp-streams
  ];

  meta = {
    description = "Parser for Ocaml documentation comments";
    license = lib.licenses.isc;
    maintainers = with lib.maintainers; [ momeemt ];
    homepage = "https://github.com/ocaml-doc/odoc-parser";
    changelog = "https://github.com/ocaml-doc/odoc-parser/raw/${finalAttrs.version}/CHANGES.md";
  };
})
