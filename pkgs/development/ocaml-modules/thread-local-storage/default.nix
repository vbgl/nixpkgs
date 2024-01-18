{ lib
, fetchurl
, buildDunePackage
}:

buildDunePackage rec {
  pname = "thread-local-storage";
  version = "0.1";

  minimalOCamlVersion = "4.03";

  src = fetchurl {
    url = "https://github.com/c-cube/thread-local-storage/releases/download/v${version}/thread-local-storage-${version}.tbz";
    hash = "sha256-cq35CNiJlpfr6JHGXqYNra8Z57upe5O65g8zpZwAZ64=";
  };

  doCheck = true;

  meta = {
    description = "The classic threading utility: have variables that have a value for each thread";
    homepage = "https://github.com/c-cube/thread-local-storage";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.vbgl ];
  };
}
