with (import <nixpkgs> { overlays = [ (import ./cerberus-overlay.nix)]; });
with python39Packages;

let
  molecule = (callPackage "${builtins.getEnv "PWD"}/molecule.nix") {};

  libselinux = pkgs.python39Packages.libselinux.overrideAttrs (old: rec {
    python3 = pkgs.python39; 
  });

  molecule-docker = (callPackage "${builtins.getEnv "PWD"}/molecule-docker.nix") {
    molecule = molecule;
    libselinux = libselinux;
  };

  pythonForAWX = pkgs.python39.withPackages (ps: with pkgs.python39Packages; [
    molecule molecule-docker ansible pip
  ]);
in
  pkgs.mkShell {
    variables = ''
      export ANSIBLE_PYTHON_INTERPRETER=${pythonForAWX.interpreter}
    '';
    packages = [pythonForAWX];
}
