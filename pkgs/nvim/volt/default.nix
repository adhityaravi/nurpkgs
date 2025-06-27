{ lib, vimUtils, fetchFromGitHub }:

vimUtils.buildVimPlugin {
  pname = "nvchad-volt";
  version = "2024-12-27";

  src = fetchFromGitHub {
    owner = "NvChad";
    repo = "volt";
    rev = "7b8c5e790120d9f08c8487dcb80692db6d2087a1";
    sha256 = "szq/QBI2Y6DKeqBuJ8qA4LlGYnarLT6D/fvwepIgSVc=";
  };

  doCheck = false;

  postInstall = ''
    rm -rf $out/{.github,assets,tests}
    rm -f $out/{.gitignore,.editorconfig,.stylua.toml}
    rm -f $out/{README.md,LICENSE}
  '';

  meta = with lib; {
    description = "Plugin for creating reactive UI in neovim";
    homepage = "https://github.com/NvChad/volt";
    license = licenses.gpl3;
    platforms = platforms.all;
  };
}