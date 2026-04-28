{
  alcotest-lwt,
  buildDunePackage,
  ca-certs,
  colombe,
  containers,
  domain-name,
  emile,
  fetchFromGitHub,
  fetchpatch,
  fmt,
  lib,
  logs,
  lwt,
  mrmime,
  ptime,
  rresult,
  sendmail,
  tls-lwt,
  x509,
}:

let
  version = "0.4.0";
in
buildDunePackage {
  pname = "letters";
  inherit version;
  src = fetchFromGitHub {
    owner = "oxidizing";
    repo = "letters";
    tag = version;
    hash = "sha256-75uLg+0AVDNdQ0M4w8H7MrTYwAKMhe8R5xC4vPNGkuQ=";
  };
  patches = [
    # Compatibility with colombe 0.13.0
    (fetchpatch {
      url = "https://github.com/oxidizing/letters/commit/7a6f748f60dc97382b321c9b9a915b066f6061b1.patch";
      hash = "sha256-UEp+z/WjgjuAsFIlXgyJQtHj7HdBuXlI7rhJz22dcFw=";
    })
  ];
  propagatedBuildInputs = [
    ca-certs
    colombe
    containers
    domain-name
    emile
    fmt
    logs
    lwt
    mrmime
    ptime
    rresult
    sendmail
    tls-lwt
    x509
  ];
  doCheck = true;
  checkInputs = [ alcotest-lwt ];
  meta = {
    description = "OCaml library for creating and sending emails over SMTP using LWT";
    homepage = "https://github.com/oxidizing/letters";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.vog ];
  };
}
