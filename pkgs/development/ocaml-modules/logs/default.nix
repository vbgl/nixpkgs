{
  lib,
  stdenv,
  fetchurl,
  ocaml,
  findlib,
  ocamlbuild,
  topkg,
  result,
  lwt,
  cmdliner,
  fmt,
  fmtSupport ? lib.versionAtLeast ocaml.version "4.08",
  js_of_ocaml-compiler,
  jsooSupport ? true,
  lwtSupport ? true,
  cmdlinerSupport ? true,
}:

if lib.versionOlder ocaml.version "4.03" then
  throw "logs is not available for OCaml ${ocaml.version}"
else

  stdenv.mkDerivation rec {
    name = "ocaml${ocaml.version}-logs-${version}";
    version = "0.8.0";

    src = fetchurl {
      url = "https://erratique.ch/software/logs/releases/logs-${version}.tbz";
      hash = "sha256-mmFRQJX6QvMBIzJiO2yNYF1Ce+qQS2oNF3+OwziCNtg=";
    };

    nativeBuildInputs = [
      ocaml
      findlib
      ocamlbuild
      topkg
    ];

    buildInputs = [
      topkg
    ]
    ++ lib.optional cmdlinerSupport cmdliner
    ++ lib.optional fmtSupport fmt
    ++ lib.optional jsooSupport js_of_ocaml-compiler
    ++ lib.optional lwtSupport lwt;

    propagatedBuildInputs = [ result ];

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

    inherit (topkg) installPhase;

    meta = with lib; {
      description = "Logging infrastructure for OCaml";
      homepage = "https://erratique.ch/software/logs";
      inherit (ocaml.meta) platforms;
      maintainers = [ maintainers.sternenseemann ];
      license = licenses.isc;
    };
  }
