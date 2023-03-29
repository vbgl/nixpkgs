{ fetchFromGitHub, buildDunePackage, ocaml_pcre, mparser }:

buildDunePackage rec {
  pname = "mparser-pcre";
  duneVersion = "3";

  inherit (mparser) src version;

  propagatedBuildInputs = [ ocaml_pcre mparser ];

  meta = mparser.meta // { description = "PCRE-based regular expressions"; };
}
