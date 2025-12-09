{
  buildDunePackage,
  prometheus,
  asetmap,
  astring,
  cohttp-lwt,
  cohttp-lwt-unix,
  cmdliner,
  fmt,
  logs,
  lwt,
  re,
  alcotest,
  alcotest-lwt,
}:

buildDunePackage {
  pname = "prometheus-app";
  inherit (prometheus)
    version
    src
    ;

  propagatedBuildInputs = [
    asetmap
    astring
    cmdliner
    cohttp-lwt
    cohttp-lwt-unix
    fmt
    logs
    lwt
    prometheus
    re
  ];

  doCheck = true;

  checkPhase = ''
    runHook preCheck
    dune runtest
    runHook postCheck
  '';

  checkInputs = [
    alcotest
    alcotest-lwt
  ];

  meta = prometheus.meta // {
    description = "A web-server reporting prometheus metrics.";
  };
}
