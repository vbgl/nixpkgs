{
  lib,
  buildDunePackage,
  cohttp,
}:

buildDunePackage {
  pname = "http";
  inherit (cohttp) src version;

  meta = cohttp.meta // {
    description = "Type definitions of HTTP essentials";
  };
}
