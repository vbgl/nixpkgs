{ stdenv, fetchFromGitHub, expat, ocaml, findlib, ounit }:

stdenv.mkDerivation rec {
	name = "ocaml${ocaml.version}-expat-${version}";
	version = "1.0.0";

	src = fetchFromGitHub {
		owner = "vbgl";
		repo = "ocaml-expat";
		rev = "2a8f625d0b64469ad320d3f7b4d63ba1bab00b8f";
		sha256 = "14jfz1n8xbyc5vylsa3y9dj9zlcisqvlmwagf78382526ihgwjjg";
	};

	prePatch = ''
		substituteInPlace Makefile --replace "gcc" "\$(CC)"
	'';

	buildInputs = [ ocaml findlib expat ounit ];

	doCheck = true;
	checkTarget = "testall";

	createFindlibDestdir = true;

	meta = {
		description = "OCaml wrapper for the Expat XML parsing library";
		license = stdenv.lib.licenses.mit;
		maintainers = [ stdenv.lib.maintainers.vbgl ];
		inherit (src.meta) homepage;
		inherit (ocaml.meta) platforms;
	};
}
