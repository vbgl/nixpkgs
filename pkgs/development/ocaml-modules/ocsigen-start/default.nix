{
  stdenv,
  lib,
  fetchFromGitHub,
  ocaml,
  findlib,
  ocsigen-toolkit,
  pgocaml_ppx,
  safepass,
  yojson,
  cohttp-lwt-unix,
  eliom,
  resource-pooling,
  ocsigen-ppx-rpc,
}:

stdenv.mkDerivation rec {
  pname = "ocaml${ocaml.version}-ocsigen-start";
  version = "7.1.0-git-20250422";

  nativeBuildInputs = [
    ocaml
    findlib
    eliom
  ];
  buildInputs = [ ocsigen-ppx-rpc ];
  propagatedBuildInputs = [
    pgocaml_ppx
    safepass
    ocsigen-toolkit
    yojson
    resource-pooling
    cohttp-lwt-unix
  ];

  strictDeps = true;

  patches = [
    ./logs.patch
    ./templates-dir.patch
  ];

  src = fetchFromGitHub {
    owner = "ocsigen";
    repo = "ocsigen-start";
    rev = "a4dcc73734413d1340371bee48e84fe4897eba15";
    hash = "sha256-wVlLus60x2G3FNw78zKiLp5qBBDgqQ/ZcZHhDqyiXEU=";
  };

  preInstall = ''
    mkdir -p $OCAMLFIND_DESTDIR
  '';

  meta = {
    homepage = "http://ocsigen.org/ocsigen-start";
    description = "Eliom application skeleton";
    longDescription = ''
      An Eliom application skeleton, ready to use to build your own application with users, (pre)registration, notifications, etc.
    '';
    license = lib.licenses.lgpl21Only;
    inherit (ocaml.meta) platforms;
    maintainers = [ lib.maintainers.gal_bolle ];
  };

}
