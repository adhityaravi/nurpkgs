{
  lib,
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  pname = "skifree-nvim";
  version = "unstable-2025-11-24";

  src = fetchFromGitHub {
    owner = "piersolenski";
    repo = "skifree.nvim";
    rev = "565ba7d5dfa29a67027434906c40f5bb06d0b8ae";
    sha256 = "sha256-wtueoOtk70DZghZDqU2iyAqQCD3M5hfBv8kffDZ4R9s=";
  };

  doCheck = false;

  postInstall = ''
    rm -rf $out/{.github}
    rm -f $out/{.gitignore,.luacheckrc,Makefile,README.md,LICENSE,CLAUDE.md}
  '';

  meta = with lib; {
    description = "SkiFree for Neovim - classic Windows 3.1 game in your editor";
    homepage = "https://github.com/piersolenski/skifree.nvim";
    license = licenses.asl20;
    platforms = platforms.all;
  };
}
