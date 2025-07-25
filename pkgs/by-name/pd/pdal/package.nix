{
  lib,
  stdenv,
  callPackage,
  ctestCheckHook,
  fetchFromGitHub,
  testers,

  enableE57 ? lib.meta.availableOn stdenv.hostPlatform libe57format,

  cmake,
  curl,
  gdal,
  hdf5-cpp,
  laszip,
  libe57format,
  libgeotiff,
  libtiff,
  libxml2,
  openscenegraph,
  pkg-config,
  libpq,
  proj,
  sqlite,
  tiledb,
  xercesc,
  zlib,
  zstd,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "pdal";
  version = "2.8.4";

  src = fetchFromGitHub {
    owner = "PDAL";
    repo = "PDAL";
    rev = finalAttrs.version;
    hash = "sha256-52v7oDmvq820mJ91XAZI1rQEwssWcHagcd2QNVV6zPA=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    curl
    gdal
    hdf5-cpp
    laszip
    libgeotiff
    libtiff
    libxml2
    openscenegraph
    libpq
    proj
    sqlite
    tiledb
    xercesc
    zlib
    zstd
  ]
  ++ lib.optionals enableE57 [
    libe57format
  ];

  strictDeps = true;

  cmakeFlags = [
    "-DBUILD_PLUGIN_E57=${if enableE57 then "ON" else "OFF"}"
    "-DBUILD_PLUGIN_HDF=ON"
    "-DBUILD_PLUGIN_PGPOINTCLOUD=ON"
    "-DBUILD_PLUGIN_TILEDB=ON"
    "-DWITH_COMPLETION=ON"
    "-DWITH_TESTS=ON"
    "-DBUILD_PGPOINTCLOUD_TESTS=OFF"

    # Plugins can probably not be made work easily:
    "-DBUILD_PLUGIN_CPD=OFF"
    "-DBUILD_PLUGIN_FBX=OFF" # Autodesk FBX SDK is gratis+proprietary; not packaged in nixpkgs
    "-DBUILD_PLUGIN_GEOWAVE=OFF"
    "-DBUILD_PLUGIN_I3S=OFF"
    "-DBUILD_PLUGIN_ICEBRIDGE=OFF"
    "-DBUILD_PLUGIN_MATLAB=OFF"
    "-DBUILD_PLUGIN_MBIO=OFF"
    "-DBUILD_PLUGIN_MRSID=OFF"
    "-DBUILD_PLUGIN_NITF=OFF"
    "-DBUILD_PLUGIN_OCI=OFF"
    "-DBUILD_PLUGIN_RDBLIB=OFF" # Riegl rdblib is proprietary; not packaged in nixpkgs
    "-DBUILD_PLUGIN_RIVLIB=OFF"
  ];

  doCheck = true;
  # tests are flaky and they seem to fail less often when they don't run in
  # parallel
  enableParallelChecking = false;

  disabledTests = [
    # Tests failing due to TileDB library implementation, disabled also
    # by upstream CI.
    # See: https://github.com/PDAL/PDAL/blob/bc46bc77f595add4a6d568a1ff923d7fe20f7e74/.github/workflows/linux.yml#L81
    "pdal_io_tiledb_writer_test"
    "pdal_io_tiledb_reader_test"
    "pdal_io_tiledb_time_writer_test"
    "pdal_io_tiledb_time_reader_test"
    "pdal_io_tiledb_bit_fields_test"
    "pdal_io_tiledb_utils_test"
    "pdal_io_e57_read_test"
    "pdal_io_e57_write_test"
    "pdal_io_stac_reader_test"

    # Segfault
    "pdal_io_hdf_reader_test"

    # Failure
    "pdal_app_plugin_test"

    # Removed in GDAL 3.11
    "pdal_io_gdal_writer_test"
  ];

  nativeCheckInputs = [
    gdal # gdalinfo
    ctestCheckHook
  ];

  postInstall = ''
    patchShebangs --update --build $out/bin/pdal-config
  '';

  passthru.tests = {
    version = testers.testVersion {
      package = finalAttrs.finalPackage;
      command = "pdal --version";
      version = "pdal ${finalAttrs.finalPackage.version}";
    };
    pdal = callPackage ./tests.nix { pdal = finalAttrs.finalPackage; };
    pkg-config = testers.hasPkgConfigModules {
      package = finalAttrs.finalPackage;
    };
  };

  meta = with lib; {
    description = "PDAL is Point Data Abstraction Library. GDAL for point cloud data";
    homepage = "https://pdal.io";
    license = licenses.bsd3;
    teams = [ teams.geospatial ];
    platforms = platforms.all;
    pkgConfigModules = [ "pdal" ];
  };
})
