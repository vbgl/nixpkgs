{ stdenv, buildOcaml, ocaml, fetchurl, cppo, csv, ocaml_lwt, ppx_tools, re, ocaml_sqlite3 }:

if !stdenv.lib.versionAtLeast ocaml.version "4.02"
then throw "sqlexpr is not available for OCaml ${ocaml.version}"
else

buildOcaml rec {
  name = "sqlexpr";
  version = "0.8.0";

  src = fetchurl {
    url = "https://github.com/mfp/ocaml-sqlexpr/releases/download/0.8.0/ocaml-sqlexpr-0.8.0.tar.gz";
    sha256 = "0v1wavqzjnjd3v7z398rfmvpbavzb56i1qrnhjkcsg458jr5nbkp";
  };

  configurePhase = "ocaml setup.ml -configure --prefix $out --disable-camlp4";

  buildInputs = [ cppo ppx_tools re ];
  propagatedBuildInputs = [ csv ocaml_lwt ocaml_sqlite3 ];

  meta = with stdenv.lib; {
    homepage = https://github.com/mfp/ocaml-sqlexpr;
    description = "Type-safe, convenient SQLite database access";
    license = licenses.lgpl21;
  };
}
