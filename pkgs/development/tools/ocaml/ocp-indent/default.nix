{
  lib,
  fetchFromGitHub,
  buildDunePackage,
  cmdliner,
  findlib,
}:

buildDunePackage rec {
  version = "1.9.0";
  pname = "ocp-indent";

  duneVersion = "3";

  src = fetchFromGitHub {
    owner = "OCamlPro";
    repo = "ocp-indent";
    rev = version;
    sha256 = "sha256-71dbZ8c842MYZfHad6RT0E48JlgzJSHnQgLVA5dGLv8=";
  };

  minimalOCamlVersion = "4.03";

  buildInputs = [ cmdliner ];
  propagatedBuildInputs = [ findlib ];

  meta = with lib; {
    homepage = "https://www.typerex.org/ocp-indent.html";
    description = "Customizable tool to indent OCaml code";
    mainProgram = "ocp-indent";
    license = licenses.gpl3;
    maintainers = [ maintainers.jirkamarsik ];
  };
}
