{
  lib,
  fetchurl,
  buildDunePackage,
  yojson,
  logs,
  ppx_yojson_conv_lib,
  uutf,
  trace,
}:

buildDunePackage rec {
  pname = "linol";
  version = "0.10";

  minimalOCamlVersion = "4.14";

  src = fetchurl {
    url = "https://github.com/c-cube/linol/releases/download/v${version}/linol-${version}.tbz";
    hash = "sha256-F0u4ytW4sMJg1isKhdoTxPXKuk/O4ELuWChLCd54luo=";
  };

  propagatedBuildInputs = [
    yojson
    logs
    ppx_yojson_conv_lib
    uutf
    trace
  ];

  meta = with lib; {
    description = "LSP server library";
    license = licenses.mit;
    maintainers = [ maintainers.ulrikstrid ];
    homepage = "https://github.com/c-cube/linol";
  };
}
