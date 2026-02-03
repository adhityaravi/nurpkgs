{
  lib,
  python3Packages,
  fetchPypi,
}:
python3Packages.buildPythonApplication rec {
  pname = "sqlit-tui";
  version = "1.3.1";
  pyproject = true;

  src = fetchPypi {
    pname = "sqlit_tui";
    inherit version;
    hash = "sha256-YDh2eRLeVUGYS1NJBqmVqxFjuiU6uWlFtR5aDjcSNUE=";
  };

  build-system = with python3Packages; [
    hatchling
    hatch-vcs
  ];

  dependencies = with python3Packages; [
    textual
    python3Packages."textual-fastdatatable"
    pyperclip
    keyring
    docker
    sqlparse
  ];

  doCheck = false;

  meta = with lib; {
    description = "A terminal UI for SQL databases - the lazygit of SQL";
    homepage = "https://github.com/Maxteabag/sqlit";
    license = licenses.mit;
    platforms = platforms.all;
    mainProgram = "sqlit";
  };
}
