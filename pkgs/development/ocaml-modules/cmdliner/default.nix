{
  lib,
  stdenv,
  fetchurl,
  ocaml,
  version ? "2.0.0",
}:

lib.throwIfNot (lib.versionAtLeast ocaml.version "4.08")
  "cmdliner 2 is not available for OCaml ${ocaml.version}"

  stdenv.mkDerivation
  rec {
    pname = "cmdliner";
    inherit version;

    src = fetchurl {
      url = "https://erratique.ch/software/${pname}/releases/cmdliner-${version}.tbz";
      hash =
        {
          "2.0.0" = "sha256-TlR6Yxw2+6rf9g0713JOs/g7onTpL7cllQuueGg3hYI=";
          "1.3.0" = "sha256-joGA9XO0QPanqMII2rLK5KgjhP7HMtInhNG7bmQWjLs=";
        }
        ."${version}";
    };

    nativeBuildInputs = [ ocaml ];

    makeFlags = [ "PREFIX=$(out)" ];
    installTargets = "install install-doc";
    installFlags = [
      "LIBDIR=$(out)/lib/ocaml/${ocaml.version}/site-lib/${pname}"
      "DOCDIR=$(out)/share/doc/${pname}"
    ];
    postInstall = ''
      mv $out/lib/ocaml/${ocaml.version}/site-lib/${pname}/{opam,${pname}.opam}
    '';

    meta = with lib; {
      homepage = "https://erratique.ch/software/cmdliner";
      description = "OCaml module for the declarative definition of command line interfaces";
      license = licenses.isc;
      inherit (ocaml.meta) platforms;
      maintainers = [ maintainers.vbgl ];
    };
  }
