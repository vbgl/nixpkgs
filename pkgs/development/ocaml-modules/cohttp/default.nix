{
  lib,
  fetchurl,
  buildDunePackage,
  ppx_sexp_conv,
  base64,
  http,
  logs,
  re,
  stringext,
  uri-sexp,
  fmt,
  alcotest,
  ppx_expect,
  version ? "6.1.1",
}:

buildDunePackage rec {
  pname = "cohttp";
  inherit version;

  minimalOCamlVersion = "4.08";

  src = fetchurl {
    url = "https://github.com/mirage/ocaml-cohttp/releases/download/v${version}/cohttp-${version}.tbz";
    hash = "sha256-a0IMViA7OgtRWWTwNrzqD7mjYodrV5HNf/UOEjZsSJw=";
  };

  buildInputs = [
    ppx_sexp_conv
  ];

  propagatedBuildInputs = [
    base64
    http
    logs
    re
    stringext
    uri-sexp
  ];

  doCheck = true;
  checkInputs = [
    fmt
    alcotest
    ppx_expect
  ];

  meta = {
    description = "HTTP(S) library for Lwt, Async and Mirage";
    license = lib.licenses.isc;
    maintainers = [ lib.maintainers.vbgl ];
    homepage = "https://github.com/mirage/ocaml-cohttp";
  };
}
