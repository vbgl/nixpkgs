{
  mkDerivation,
  lib,
  ghostscript,
  replaceVars,
  extra-cmake-modules,
  karchive,
  kio,
  libkexiv2,
  libkdcraw,
  kdegraphics-mobipocket,
}:

mkDerivation {
  pname = "kdegraphics-thumbnailers";
  meta = {
    license = [ lib.licenses.lgpl21 ];
    maintainers = [ lib.maintainers.ttuegel ];
  };
  nativeBuildInputs = [ extra-cmake-modules ];
  buildInputs = [
    karchive
    kio
    libkexiv2
    libkdcraw
    kdegraphics-mobipocket
  ];

  patches = [
    # Hardcode patches to Ghostscript so PDF thumbnails work OOTB.
    # Intentionally not doing the same for dvips because TeX is big.
    (replaceVars ./gs-paths.patch {
      gs = "${ghostscript}/bin/gs";
    })
  ];
}
