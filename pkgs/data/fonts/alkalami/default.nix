{ lib, fetchzip }:

let version = "1.200"; in

fetchzip rec {
  name = "alkalami-${version}";

  url = "https://software.sil.org/downloads/r/alkalami/Alkalami-${version}.zip";

  postFetch = ''
    mkdir -p $out/share/{doc,fonts}
    unzip -l $downloadedFile
    unzip -j $downloadedFile \*.ttf                        -d $out/share/fonts/truetype
    unzip -j $downloadedFile \*/FONTLOG.txt  \*/README.txt -d $out/share/doc/${name}
    unzip -j $downloadedFile \*/documentation/\*           -d $out/share/doc/${name}/documentation
  '';

  sha256 = "1i5k3v0552sd9a6dg49l76l9r6qb3rkb788f30a309qmxnsgzm2v";

  meta = with lib; {
    homepage = "https://software.sil.org/alkalami/";
    description = "A font for Arabic-based writing systems in the Kano region of Nigeria and in Niger";
    license = licenses.ofl;
    maintainers = [ maintainers.vbgl ];
    platforms = platforms.all;
  };
}
