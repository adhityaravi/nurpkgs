{
  lib,
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  pname = "goose-nvim";
  version = "1.0.3";

  src = fetchFromGitHub {
    owner = "azorng";
    repo = "goose.nvim";
    rev = "v1.0.3";
    sha256 = "sha256-jVWggPmdINFNVHJSCpbTZq8wKwGjldu6PNSkb7naiQE=";
  };

  doCheck = false; # tests require neovim runtime

  postInstall = ''
    rm -rf $out/{tests}
    rm -f $out/{.gitignore,.luarc.json,run_tests.sh,README.md,LICENSE}
  '';

  meta = with lib; {
    description = "Seamless neovim integration with goose AI";
    homepage = "https://github.com/azorng/goose.nvim";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
