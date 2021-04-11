{ lib, stdenv, fetchurl }:
stdenv.mkDerivation rec {
  pname = "matio";
  version = "1.5.21";
  src = fetchurl {
    url = "https://github.com/tbeu/matio/releases/download/v${version}/matio-${version}.tar.gz";
    sha256 = "21809177e55839e7c94dada744ee55c1dea7d757ddaab89605776d50122fb065";
  };

  meta = with lib; {
    description = "A C library for reading and writing Matlab MAT files";
    license = licenses.bsd2;
    platforms = platforms.all;
    maintainers = [ maintainers.vbgl ];
    homepage = "http://matio.sourceforge.net/";
  };
}
