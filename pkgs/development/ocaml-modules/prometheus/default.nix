{
  lib,
  fetchurl,
  buildDunePackage,
  astring,
  asetmap,
  re,
  lwt,
}:

buildDunePackage rec {
  pname = "prometheus";
  version = "1.3";

  src = fetchurl {
    url = "https://github.com/mirage/prometheus/releases/download/v${version}/prometheus-${version}.tbz";
    hash = "sha256-4C0UzwaCgqtk5SGIY89rg0dxdrKm63lhdcOaQAa20L8=";
  };

  propagatedBuildInputs = [
    astring
    asetmap
    re
    lwt
  ];

  # The tests depend on prometheus-app, which in turn depends on this package
  # To avoid an infinite recursion, tests are run in the prometheus-app package
  doCheck = false;

  meta = {
    description = "Client library for Prometheus monitoring";
    license = lib.licenses.asl20;
    maintainers = [ lib.maintainers.ulrikstrid ];
  };
}
