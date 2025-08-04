{
  lib,
  stdenv,
  fetchurl,
  ocaml,
  version ? if lib.versionAtLeast ocaml.version "4.14" then "0.9.0" else "0.8.0",
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

let
  param =
    {
      "0.8.0" = {
        minimalOCamlVersion = "4.03";
        hash = "sha256-mmFRQJX6QvMBIzJiO2yNYF1Ce+qQS2oNF3+OwziCNtg=";
      };
      "0.9.0" = {
        minimalOCamlVersion = "4.14";
        hash = "sha256-7pcGW6Qc4o8Z3qlFPGvsTg7yYWWtc5TEEx6gxlwPBtU=";
      };
    }
    .${version};
in
buildTopkgPackage rec {
  inherit version;
  inherit (param) minimalOCamlVersion;

  pname = "logs";

  src = fetchurl {
    url = "https://erratique.ch/software/logs/releases/logs-${version}.tbz";
    inherit (param) hash;
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
    maintainers = with lib.maintainers; [
      sternenseemann
      toastal
    ];
    license = lib.licenses.isc;
  };
}
