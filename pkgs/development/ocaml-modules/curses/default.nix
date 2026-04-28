{
  lib,
  ocaml,
  buildDunePackage,
  fetchFromGitHub,
  ncurses,
  dune-configurator,
  pkg-config,
}:

buildDunePackage (finalAttrs: {
  pname = "curses";
  version = if lib.versionAtLeast ocaml.version "4.12" then "1.0.12" else "1.0.11";

  src = fetchFromGitHub {
    owner = "mbacarella";
    repo = "curses";
    tag = finalAttrs.version;
    hash =
      {
        "1.0.12" = "sha256-g7YveFRuS+uTq8Ps8+cU93CRFOXW+fjJfs4rafTVmIg=";
        "1.0.11" = "sha256-tjBOv7RARDzBShToNLL9LEaU/Syo95MfwZunFsyN4/Q=";
      }
      ."${finalAttrs.version}";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ dune-configurator ];

  propagatedBuildInputs = [ ncurses ];

  meta = {
    description = "OCaml Bindings to curses/ncurses";
    homepage = "https://github.com/mbacarella/curses";
    license = lib.licenses.lgpl21Plus;
    changelog = "https://github.com/mbacarella/curses/raw/${finalAttrs.version}/CHANGES.md";
    maintainers = [ lib.maintainers.vbgl ];
  };
})
