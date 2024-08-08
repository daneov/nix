{ 
  lib
  , buildPythonPackage
  , fetchPypi
  , setuptools
}:

buildPythonPackage rec {
  pname = "Cerberus";
  version = "1.3.4";
  format = "pyproject";
  src = fetchPypi {
    inherit pname version;
    sha256 = "0bIbOVSySY2aee3xazFwo6wQId+I0ZfcLOWSi6UZI3w=";
  };
  propagatedBuildInputs = [
    setuptools
  ];
  doCheck = true;

  meta = with lib; {
    description = "Lightweight, extensible data validation library for Python";
    homepage = "http://python-cerberus.org/";
    license = licenses.isc;
    maintainers = [ maintainer.eelco ];
    platforms = platforms.all;
  };
}
