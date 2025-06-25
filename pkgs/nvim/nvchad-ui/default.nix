{ lib, vimUtils, fetchFromGitHub }:

vimUtils.buildVimPlugin {
  pname = "nvchad-ui";
  version = "2.5";

  src = fetchFromGitHub {
    owner = "NvChad";
    repo = "ui";
    rev = "v2.5";
    sha256 = "0pj4j26azm3yqcj437lx9b18qhvj3p0dd5k80r0b7p05bxi753jw";
  };

  doCheck = false;

  postInstall = ''
    rm -rf $out/{.github,assets,tests}
    rm -f $out/{.gitignore,.editorconfig}
    rm -f $out/{README.md,LICENSE}
  '';

  meta = with lib; {
    description = "NvChad's UI components including statusline, tabufline, and dashboard";
    homepage = "https://github.com/NvChad/ui";
    license = licenses.gpl3;
    platforms = platforms.all;
  };
}