{ lib, fetchFromGitHub, buildDunePackage
, alcotest
, asn1-combinators, domain-name, fmt, gmap, pbkdf, mirage-crypto, mirage-crypto-ec, mirage-crypto-pk, ipaddr
, logs, base64, ohex
}:

buildDunePackage rec {
  minimalOCamlVersion = "4.08";

  pname = "x509";
  version = "1.0.2";

  src = fetchFromGitHub {
    owner = "mirleft";
    repo = "ocaml-x509";
    rev = "v${version}";
    hash = "sha256-9cDvHISpjwOFEOa+D0GiscstlCZ69n/EibegJm27XxI=";
  };

  checkInputs = [ alcotest ];
  propagatedBuildInputs = [ asn1-combinators domain-name fmt gmap mirage-crypto mirage-crypto-pk mirage-crypto-ec pbkdf logs base64 ipaddr ohex ];

  doCheck = true;

  meta = with lib; {
    homepage = "https://github.com/mirleft/ocaml-x509";
    description = "X509 (RFC5280) handling in OCaml";
    license = licenses.bsd2;
    maintainers = with maintainers; [ vbgl ];
  };
}
