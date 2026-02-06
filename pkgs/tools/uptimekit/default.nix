{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  python3,
  pkg-config,
}:

buildNpmPackage rec {
  pname = "uptimekit";
  version = "1.2.28";

  src = fetchFromGitHub {
    owner = "abhixdd";
    repo = "UptimeKit-CLI";
    rev = "v${version}";
    hash = "sha256-gCgH/Bw0SrebdjUcB9ttN0KBHFu1Z41iSolfWtPZjN0=";
  };

  npmDepsHash = "sha256-iqjM0OGhQnt2naQhWDzcZenKaW3R2+TFAuanNjS+iAc=";

  # Required for building native modules (better-sqlite3)
  nativeBuildInputs = [
    python3
    pkg-config
  ];

  # Build the project (transpiles with babel)
  npmBuildScript = "build";

  meta = with lib; {
    description = "A cross-platform CLI tool for monitoring website/server health with a terminal dashboard";
    homepage = "https://github.com/abhixdd/UptimeKit-CLI";
    license = licenses.mit;
    platforms = platforms.all;
    mainProgram = "uptimekit";
  };
}
