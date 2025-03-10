{
  lib,
  buildDunePackage,
  ocaml-crunch,
  astring,
  cohttp,
  digestif,
  graphql,
  ocplib-endian,
  alcotest,
  cohttp-lwt-unix,
  graphql-lwt,
}:

buildDunePackage rec {
  pname = "graphql-cohttp";

  inherit (graphql) version src;

  patches = [ ./cohttp-6.1.0.patch ];

  nativeBuildInputs = [ ocaml-crunch ];
  propagatedBuildInputs = [
    astring
    cohttp
    digestif
    graphql
    ocplib-endian
  ];

  checkInputs = lib.optionals doCheck [
    alcotest
    cohttp-lwt-unix
    graphql-lwt
  ];

  doCheck = true;

  meta = graphql.meta // {
    description = "Run GraphQL servers with “cohttp”";
  };

}
