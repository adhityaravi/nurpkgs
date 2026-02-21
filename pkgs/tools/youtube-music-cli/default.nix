{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  mpv,
  yt-dlp,
  makeWrapper,
  jq,
}:

buildNpmPackage rec {
  pname = "youtube-music-cli";
  version = "0.0.27";

  src = fetchFromGitHub {
    owner = "involvex";
    repo = "youtube-music-cli";
    rev = "7fb7929a91696cffbeff1b225d725bff6730a601";
    hash = "sha256-SwXESZ5SSlFjnpWktczwRCiF+kfqpWiS3qgBf1PwtVE=";
  };

  # Upstream uses bun.lock; provide a generated package-lock.json for buildNpmPackage
  # Remove prebuild script that requires bun for linting/formatting
  postPatch = ''
    cp ${./package-lock.json} package-lock.json
    ${lib.getExe jq} 'del(.scripts.prebuild)' package.json > package.json.tmp
    mv package.json.tmp package.json
  '';

  npmDepsHash = "sha256-xdzZAXc+2PDLwmoJvuF3t46JXN27zArh84WTnmYWaaQ=";

  npmFlags = [ "--legacy-peer-deps" ];
  forceGitDeps = true;

  nativeBuildInputs = [ makeWrapper ];

  npmBuildScript = "build";

  # Wrap the binary to include runtime dependencies (mpv and yt-dlp) in PATH
  postInstall = ''
    wrapProgram $out/bin/youtube-music-cli \
      --prefix PATH : ${lib.makeBinPath [ mpv yt-dlp ]}
    wrapProgram $out/bin/ymc \
      --prefix PATH : ${lib.makeBinPath [ mpv yt-dlp ]}
  '';

  meta = with lib; {
    description = "A powerful TUI music player for YouTube Music";
    homepage = "https://github.com/involvex/youtube-music-cli";
    license = licenses.mit;
    platforms = platforms.all;
    mainProgram = "ymc";
  };
}
