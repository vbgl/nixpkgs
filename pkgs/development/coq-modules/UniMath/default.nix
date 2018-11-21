{ stdenv, fetchFromGitHub, coq }:

stdenv.mkDerivation rec {
  version = "20181104";
  name = "coq${coq.coq-version}-UniMath-${version}";
  src = fetchFromGitHub {
    owner = "UniMath";
    repo = "UniMath";
    rev = "61005278293dd60f58feceeadc33deacbd692a28";
    sha256 = "05am34k5jvphh5dmc49ry1awzxbac8q4bg597yias3xyv65526az";
  };

  sourceRoot = "source/UniMath";

  buildInputs = [ coq ];
  enableParallelBuilding = true;

  configurePhase = ''
    echo "-R . UniMath" >> _CoqProject
    echo "-arg -indices-matter" >> _CoqProject
    echo "-arg -type-in-type" >> _CoqProject
    echo "-arg -noinit" >> _CoqProject
    find . -name '*.v' >> _CoqProject
    coq_makefile -f _CoqProject -o Makefile
  '';

  installFlags = "COQLIB=$(out)/lib/coq/${coq.coq-version}/";

  passthru = {
    compatibleCoqVersions = v: stdenv.lib.versionAtLeast v "8.8";
  };

  meta = {
    description = "A Coq formalization of a substantial body of mathematics using the univalent point of view";
    inherit (src.meta) homepage;
    inherit (coq.meta) platforms;
  };
}
