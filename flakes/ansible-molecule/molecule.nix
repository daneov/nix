{
  lib
  , buildPythonPackage
  , ttp
  , ansible-core
  , fetchPypi
  , setuptools
  , ansible-compat
  , click-help-colors
  , cookiecutter
  , enrich
  , packaging
  , rich
  , pluggy
  , requests
  , setuptools-scm
}:

buildPythonPackage rec {
  pname = "molecule";
  version = "4.0.1";
  format = "pyproject";
  src = fetchPypi {
    inherit pname version;
    sha256 = "7hDlRjvJlA+a/ZuFgSxj6s7+qImpnCEnT0BU6+JIw7k=";
  };

  propagatedBuildInputs = [
    ansible-compat
    ansible-core
    click-help-colors
    cookiecutter
    enrich
    packaging
    pluggy
    requests
    rich
    setuptools-scm
    ttp
  ];

  doCheck = false;

  meta = with lib; {
    description = "molecule";
    homepage = "https://github.com/ansible-community/molecule";
    license = licenses.mit;
    maintainers = [ maintainer.eelco ];
    platforms = platforms.all;
  };
}
