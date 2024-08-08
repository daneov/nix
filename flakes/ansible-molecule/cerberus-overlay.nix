  final: prev: {
    python39 = prev.python39.override {
      packageOverrides = pyfinal: pyprev: {
        cerberus = pyprev.cerberus.overrideAttrs( oldAttrs: rec {
          pname = "Cerberus";
          version = "1.3.2";

          src = pyfinal.fetchPypi {
            inherit pname version;
            sha256 = "MC5mlPIG3YXLY/E/1QJbMattOMmcUMbXafj6Cw8plYk=";
          };
        });
      };
    };
  }
