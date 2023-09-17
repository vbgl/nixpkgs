{ lib, fetchFromGitHub, buildDunePackage, camomile, result }:

buildDunePackage rec {
  pname = "charInfo_width";
  version = "2.0.0";
  src = fetchFromGitHub {
    owner = "kandu";
    repo = pname;
    rev = version;
    hash = "sha256-JYAa3awHqW5lS4a+TSyK3+xQSi123PhfWwNUt5iOmjg=";
  };

  propagatedBuildInputs = [ camomile result ];

  meta = {
    homepage = "https://bitbucket.org/zandoye/charinfo_width/";
    description = "Determine column width for a character";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.vbgl ];
  };
}
