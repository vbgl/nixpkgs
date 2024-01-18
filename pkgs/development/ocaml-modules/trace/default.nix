{ lib, fetchurl, buildDunePackage, ocaml, mtime }:

buildDunePackage rec {
  pname = "trace";
  version = "0.6";

  minimalOCamlVersion = "4.07";

  src = fetchurl {
    url = "https://github.com/c-cube/ocaml-trace/releases/download/v${version}/trace-${version}.tbz";
    hash = "sha256-l8xBWblkKa3AGoS/8e00uPBnRrxWpAohSmMGA2vi3zg=";
  };

  propagatedBuildInputs = lib.optional (lib.versionAtLeast ocaml.version "4.08") mtime;

  meta = {
    description = "Common interface for tracing/instrumentation libraries in OCaml";
    license = lib.licenses.mit;
    homepage = "https://c-cube.github.io/ocaml-trace/";
    maintainers = [ lib.maintainers.vbgl ];
  };

}
