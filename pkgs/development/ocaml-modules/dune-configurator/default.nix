{ lib, buildDunePackage, dune_3, csexp, result }:

buildDunePackage rec {
  pname = "dune-configurator";

  inherit (dune_3) src version;

  preConfigure = ''
    rm -rf vendor/csexp
  '';

  duneVersion = "3";

  minimalOCamlVersion = "4.03";

  dontAddPrefix = true;

  propagatedBuildInputs = [ csexp result ];

  meta = with lib; {
    description = "Helper library for gathering system configuration";
    maintainers = [ maintainers.marsam ];
    license = licenses.mit;
  };
}
