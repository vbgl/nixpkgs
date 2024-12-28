{
  lib,
  fetchurl,
  buildDunePackage,
  yojson,
  logs,
  lsp,
  ppx_yojson_conv_lib,
  trace,
}:

buildDunePackage rec {
  pname = "linol";
  version = "0.7";

  minimalOCamlVersion = "4.14";

  src = fetchurl {
    url = "https://github.com/c-cube/linol/releases/download/v${version}/linol-${version}.tbz";
    hash = "sha256-IyUUpC2ea8BTDFN4Xg0Kn2axWcN5EQYM1klMG8Ww4Gk=";
  };

  postPatch = ''
    substituteInPlace src/dune --replace-warn atomic ""
  '';

  propagatedBuildInputs = [
    yojson
    logs
    (lsp.override { version = "1.18.0"; })
    ppx_yojson_conv_lib
    trace
  ];

  meta = with lib; {
    description = "LSP server library";
    license = licenses.mit;
    maintainers = [ maintainers.ulrikstrid ];
    homepage = "https://github.com/c-cube/linol";
  };
}
