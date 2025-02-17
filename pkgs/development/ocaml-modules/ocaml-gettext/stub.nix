{
  lib,
  buildDunePackage,
  ocaml_gettext,
  dune-configurator,
  ounit2,
}:

buildDunePackage {
  pname = "gettext-stub";
  inherit (ocaml_gettext) src version;

  buildInputs = [ dune-configurator ];
  propagatedBuildInputs = [ ocaml_gettext ];

  doCheck = true;
  checkInputs = [ ounit2 ];

  meta = builtins.removeAttrs ocaml_gettext.meta [ "mainProgram" ];
}
