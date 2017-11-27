{ stdenv, ocaml, cstruct, ppx_tools_versioned }:

stdenv.mkDerivation rec {
	name = "ocaml${ocaml.version}-ppx_cstruct-${version}";
	inherit (cstruct) version src unpackCmd installPhase meta;

	buildInputs = cstruct.buildInputs ++ [ ppx_tools_versioned ];
	propagatedBuildInputs = [ cstruct ];

	buildPhase = "jbuilder build -p ppx_cstruct";
}
