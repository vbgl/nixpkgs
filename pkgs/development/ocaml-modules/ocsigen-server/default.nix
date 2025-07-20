{
  lib,
  buildDunePackage,
  fetchFromGitHub,
  which,
  ocaml,
  lwt_react,
  ssl,
  lwt_ssl,
  findlib,
  bigstringaf,
  lwt,
  cstruct,
  mirage-crypto,
  zarith,
  mirage-crypto-ec,
  ptime,
  mirage-crypto-rng,
  mtime,
  ca-certs,
  cohttp,
  cohttp-lwt-unix,
  logs-syslog,
  re,
  cryptokit,
  xml-light,
  ipaddr,
  camlzip,
  makeWrapper,
}:

let
  mkpath = p: "${p}/lib/ocaml/${ocaml.version}/site-lib/stublibs";
in

let
  caml_ld_library_path = lib.concatMapStringsSep ":" mkpath [
    bigstringaf
    lwt
    ssl
    cstruct
    mirage-crypto
    zarith
    mirage-crypto-ec
    ptime
    mirage-crypto-rng
    mtime
    ca-certs
    cryptokit
    re
  ];
in

buildDunePackage rec {
  version = "6.0.0-git-20250706";
  pname = "ocsigenserver";

  minimalOCamlVersion = "4.08";

  src = fetchFromGitHub {
    owner = "ocsigen";
    repo = "ocsigenserver";
    rev = "4c79e09b03607685687b77e33812e099902387a3";
    hash = "sha256-3ZUsJ3LlktZ5MhwIvo+7calAIpttxcyAt8mdDaM16FE=";
  };

  nativeBuildInputs = [
    makeWrapper
    which
  ];
  buildInputs = [
    lwt_react
    camlzip
    findlib
  ];

  propagatedBuildInputs = [
    cohttp
    cohttp-lwt-unix
    cryptokit
    ipaddr
    logs-syslog
    lwt_ssl
    re
    xml-light
  ];

  configureFlags = [
    "--root $(out)"
    "--prefix /"
    "--temproot ''"
  ];

  dontAddPrefix = true;
  dontAddStaticConfigureFlags = true;
  configurePlatforms = [ ];

  postInstall = ''
    make install.files
  '';

  postFixup = ''
    rm -rf $out/var/run
    wrapProgram $out/bin/ocsigenserver \
      --suffix CAML_LD_LIBRARY_PATH : "${caml_ld_library_path}"
  '';

  dontPatchShebangs = true;

  meta = {
    homepage = "http://ocsigen.org/ocsigenserver/";
    description = "Full featured Web server";
    longDescription = ''
      A full featured Web server. It implements most features of the HTTP protocol, and has a very powerful extension mechanism that make very easy to plug your own OCaml modules for generating pages.
    '';
    license = lib.licenses.lgpl21Only;
    inherit (ocaml.meta) platforms;
    maintainers = [ lib.maintainers.gal_bolle ];
  };

}
