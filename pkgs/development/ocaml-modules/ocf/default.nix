{
  lib,
  buildDunePackage,
  fetchFromGitLab,
  yojson,
}:

buildDunePackage rec {
  pname = "ocf";
  version = "0.9.0";
  patches = ./yojson.patch;
  src = fetchFromGitLab {
    domain = "framagit.org";
    owner = "zoggy";
    repo = "ocf";
    rev = version;
    sha256 = "sha256-tTNpvncLO/WfcMbjqRfqzcdPv2Bd877fOU5AZlkkcXA=";
  };

  propagatedBuildInputs = [ yojson ];

  meta = with lib; {
    description = "OCaml library to read and write configuration options in JSON syntax";
    homepage = "https://zoggy.frama.io/ocf/";
    license = licenses.lgpl3;
    maintainers = with maintainers; [ regnat ];
  };
}
