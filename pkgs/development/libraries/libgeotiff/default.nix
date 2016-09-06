{ stdenv, fetchurl, proj, libtiff }:

stdenv.mkDerivation {
  name = "libgeotiff-1.4.1";

  src = fetchurl {
    url = http://download.osgeo.org/geotiff/libgeotiff/libgeotiff-1.4.1.tar.gz;
    sha256 = "08zx84xmgcmrplkkp7y0jqx8j4ylap581dz8qywipm5k37p7dz5c";
  };

  buildInputs = [ proj libtiff ];

  hardeningDisable = [ "format" ];

  meta = with stdenv.lib; {
    description = "Library implementing attempt to create a tiff based interchange format for georeferenced raster imagery";
    homepage = http://geotiff.osgeo.org/;
    license = licenses.mit;
    maintainers = [ maintainers.marcweber ];
    platforms = platforms.unix;
  };
}
