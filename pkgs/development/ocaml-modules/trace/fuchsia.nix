{ buildDunePackage, trace, mtime, thread-local-storage }:

buildDunePackage {
  pname = "trace-fuchsia";
  inherit (trace) src version;

  propagatedBuildInputs = [ mtime thread-local-storage trace ];

  doCheck = true;

  meta = trace.meta // {
    description = "A high-performance backend for trace, emitting a Fuchsia trace into a file";
  };

}
