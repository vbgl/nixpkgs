{
  lib,
  fetchPypi,
  python3Packages,
}:

python3Packages.buildPythonApplication rec {
  pname = "frida-tools";
  version = "13.7.1";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-c0Gq1ep75WAvTGIj4c7xSy0NjCGK5wrRPYzeYyFHDgU=";
  };

  propagatedBuildInputs = with python3Packages; [
    pygments
    prompt-toolkit
    colorama
    frida-python
    websockets
  ];

  meta = {
    description = "Dynamic instrumentation toolkit for developers, reverse-engineers, and security researchers (client tools)";
    homepage = "https://www.frida.re/";
    maintainers = with lib.maintainers; [ s1341 ];
    license = lib.licenses.wxWindows;
  };
}
