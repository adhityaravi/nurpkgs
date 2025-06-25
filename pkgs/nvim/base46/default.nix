{ lib, vimUtils, fetchFromGitHub }:

vimUtils.buildVimPlugin {
  pname = "nvchad-base46";
  version = "2.5";

  src = fetchFromGitHub {
    owner = "NvChad";
    repo = "base46";
    rev = "v2.5";
    sha256 = "10wjdg6pqviry6w366089vvi24mhqys4k5m83hz4v4kimwgys3rz";
  };

  doCheck = false;

  postInstall = ''
    rm -rf $out/{.github,assets,tests}
    rm -f $out/{.gitignore,.editorconfig}
    rm -f $out/{README.md,LICENSE}
  '';

  meta = with lib; {
    description = "NvChad's Base46 theme system for consistent colorschemes";
    homepage = "https://github.com/NvChad/base46";
    license = licenses.gpl3;
    platforms = platforms.all;
  };
}