{
  lib,
  fetchFromGitHub,
  fetchpatch,
  buildDunePackage,
  camlp-streams,
  cppo,
  cryptokit,
  ocurl,
  yojson,
  ounit2,
}:

buildDunePackage rec {
  pname = "gapi-ocaml";
  version = "0.4.7";

  src = fetchFromGitHub {
    owner = "astrada";
    repo = "gapi-ocaml";
    tag = "v${version}";
    hash = "sha256-uQJfrgF0oafURlamHslt9hX9MP4vFeVqDhuX7T/kjiY=";
  };

  patches = lib.optional (lib.versionAtLeast cryptokit.version "1.21") (fetchpatch {
    url = "https://github.com/astrada/gapi-ocaml/commit/04f2c1ac5bba033fbe3eea585d2aaac904c5c7ae.patch";
    hash = "sha256-HbcFPKIplssDwPKEytj93XqMN68PsDWZDBgdCjGwELE=";
  });

  nativeBuildInputs = [ cppo ];

  propagatedBuildInputs = [
    camlp-streams
    cryptokit
    ocurl
    yojson
  ];

  doCheck = true;
  checkInputs = [ ounit2 ];

  meta = {
    description = "OCaml client for google services";
    homepage = "https://github.com/astrada/gapi-ocaml";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ bennofs ];
  };
}
