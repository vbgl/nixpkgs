import ./generic.nix {
  major_version = "5";
  minor_version = "3";
  patch_version = "0-alpha1";
  src = fetchTarball {
    url = "https://caml.inria.fr/pub/distrib/ocaml-5.3/ocaml-5.3.0~alpha1.tar.xz";
    sha256 = "sha256:1riwlr0jm7zgw535qk8766m0n3c0dkj6r4zr0rrxnx7l4vaw9f60";
  };
}
