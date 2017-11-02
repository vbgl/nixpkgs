{ stdenv, fetchFromGitHub, expat, ocaml, findlib, ounit }:

stdenv.mkDerivation rec {
	name = "ocaml${ocaml.version}-expat-${version}";
	version = "1.0.0";

	src = fetchFromGitHub {
		owner = "vbgl";
		repo = "ocaml-expat";
		rev = "ad5112ea09f47416a0902a48dd4537c8e8a067f3";
		sha256 = "0bzvjbkqi1q3qqdy2fbs11dn3bdl9j8jfkvvymd0m70v8vyjjfl8";
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
