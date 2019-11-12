{ stdenv, fetchFromGitHub, coq, coq-ext-lib, paco }:

stdenv.mkDerivation rec {
  pname = "InteractionTrees";
  version = "20191104";
  name = "coq${coq.coq-version}-${pname}-${version}";

  src = fetchFromGitHub {
    owner = "DeepSpec";
    repo = pname;
    rev = "d408b9151f7f77d1ab0b8a0f2d57f210e16206ae";
    sha256 = "1pjad3y6y7nmmjd9hyw6zn1314igkxd3vcj1rmnariff69slcpdk";
  };

  buildInputs = [ coq ];
  propagatedBuildInputs = [ coq-ext-lib paco ];

  enableParallelBuilding = true;

  installFlags = "COQLIB=$(out)/lib/coq/${coq.coq-version}/";

  passthru.compatibleCoqVersions = v: builtins.elem v [ "8.8" "8.9" ];

}
