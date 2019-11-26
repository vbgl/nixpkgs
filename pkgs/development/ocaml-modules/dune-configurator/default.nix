{ buildDunePackage, dune, dune-private-libs }:

buildDunePackage {
  pname = "dune-configurator";
  inherit (dune) version src;

  dontConfigure = true;

  propagatedBuildInputs = [ dune-private-libs ];

  meta = {
    description = "Helper library for gathering system configuration";
    inherit (dune.meta) homepage license;
  };
}
