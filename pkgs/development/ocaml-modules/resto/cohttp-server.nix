{
  buildDunePackage,
  resto,
  resto-directory,
  resto-acl,
  resto-cohttp,
  cohttp-lwt-unix,
  conduit-lwt-unix,
  lwt,
}:

buildDunePackage {
  pname = "resto-cohttp-server";
  inherit (resto)
    src
    version
    doCheck
    ;

  propagatedBuildInputs = [
    resto
    resto-directory
    resto-acl
    resto-cohttp
    cohttp-lwt-unix
    conduit-lwt-unix
    lwt
  ];
  meta = resto.meta // {
    broken = true; # Not compatible with cohttp 6
  };
}
