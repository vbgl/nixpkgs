{ lib, fetchFromGitHub, buildDunePackage, ocaml, cppo
, camlp-streams, dune-site
, version ? "1.0.2"
}:

let params =
  {
    "1.0.2" = {
      src = fetchFromGitHub {
        owner = "yoriyuki";
        repo = "camomile";
        rev = version;
        sha256 = "00i910qjv6bpk0nkafp5fg97isqas0bwjf7m6rz11rsxilpalzad";
      };

      nativeBuildInputs = [ cppo ];

      configurePhase = ''
        runHook preConfigure
        ocaml configure.ml --share $out/share/camomile
        runHook postConfigure
      '';

      postInstall = ''
        echo "version = \"${version}\"" >> $out/lib/ocaml/${ocaml.version}/site-lib/camomile/META
      '';

    };

    "2.0.0" = {
      src = fetchFromGitHub {
        owner = "ocaml-community";
        repo = "camomile";
        rev = "v${version}";
        hash = "sha256-HklX+VPD0Ta3Knv++dBT2rhsDSlDRH90k4Cj1YtWIa8=";
      };

      propagatedBuildInputs = [ camlp-streams dune-site ];
    };
  }
; in


buildDunePackage (params."${version}" // {
  pname = "camomile";
  inherit version;

  meta = {
    homepage = "https://github.com/ocaml-community/Camomile";
    maintainers = [ lib.maintainers.vbgl ];
    license = lib.licenses.lgpl21;
    description = "A Unicode library for OCaml";
  };
})
