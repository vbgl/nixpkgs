{
  buildDunePackage,
  conan,
  alcotest,
  crowbar,
  fmt,
  rresult,
}:

buildDunePackage {
  pname = "conan-unix";
  inherit (conan) version src meta;

  propagatedBuildInputs = [
    conan
  ];

  doCheck = true;

  checkInputs = [
    alcotest
    crowbar
    fmt
    rresult
  ];
}
