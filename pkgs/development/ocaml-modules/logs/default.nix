{
  lib,
  stdenv,
  fetchurl,
  ocaml,
  topkg,
  buildTopkgPackage,
  cmdlinerSupport ? true,
  cmdliner,
  fmtSupport ? lib.versionAtLeast ocaml.version "4.08",
  fmt,
  jsooSupport ? true,
  js_of_ocaml-compiler,
  lwtSupport ? true,
  lwt,
}:

buildTopkgPackage rec {
  pname = "logs";
  version = "0.8.0";

  minimalOCamlVersion = "4.03";

  src = fetchurl {
    url = "https://erratique.ch/software/logs/releases/logs-${version}.tbz";
    hash = "sha256-mmFRQJX6QvMBIzJiO2yNYF1Ce+qQS2oNF3+OwziCNtg=";
  };

  buildInputs = lib.optional cmdlinerSupport cmdliner;

  propagatedBuildInputs =
    lib.optional fmtSupport fmt
    ++ lib.optional jsooSupport js_of_ocaml-compiler
    ++ lib.optional lwtSupport lwt;

  strictDeps = true;

  buildPhase = "${topkg.run} build ${
    lib.escapeShellArgs [
      "--with-cmdliner"
      (lib.boolToString cmdlinerSupport)

      "--with-fmt"
      (lib.boolToString fmtSupport)

      "--with-js_of_ocaml-compiler"
      (lib.boolToString jsooSupport)

      "--with-lwt"
      (lib.boolToString lwtSupport)
    ]
  }";

  meta = {
    description = "Logging infrastructure for OCaml";
    homepage = "https://erratique.ch/software/logs";
    inherit (ocaml.meta) platforms;
    maintainers = with lib.maintainers; [ sternenseemann ];
    license = lib.licenses.isc;
  };
}
