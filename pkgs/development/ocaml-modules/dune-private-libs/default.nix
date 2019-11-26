{ buildDunePackage, dune }:

buildDunePackage {
  pname = "dune-private-libs";
  inherit (dune) version src;

  minimumOCamlVersion = "4.06";

  dontConfigure = true;

  meta = {
    description = "Private libraries of Dune";
    inherit (dune.meta) homepage license;
  };
}

