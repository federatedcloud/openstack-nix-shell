#
# This file is just a script to setup the environment using Nix and is not typically used
# in practice; a more well known alternative for environment setup and packaging can be found
# in the Dockerfile. For more information see https://nixos.org/nix/ and
# https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/python.md
#

with import <nixpkgs> {};
with pkgs.python36Packages;
stdenv.mkDerivation {
  name = "impurePythonEnv";
  buildInputs = [
    # these packages are required for virtualenv and pip to work:
    #
    python36Full
    python36Packages.virtualenv
    python36Packages.pip
    python36Packages.pip-tools
    # the following packages are related to the dependencies of your python
    # project.
    # In this particular example the python modules listed in the
    # requirements.tx require the following packages to be installed locally
    # in order to compile any binary extensions they may require.
    #
    gcc6
    libffi
    openssl
    # zlib
  ];
  src = null;
  shellHook = ''
    # set SOURCE_DATE_EPOCH so that we can use python wheels
    SOURCE_DATE_EPOCH=$(date +%s)
    virtualenv venv
    export PATH=$PWD/venv/bin:$PATH
    export PYTHONPATH=$PWD
    pip install python-openstackclient
    pip install python-heatclient
    # source private_vars.sh
    # source $(pipenv --venv)/bin/activate
  '';
}

#
# Now you can run the following command to start the server:
#
# uwsgi --http-socket :8000 -w wsgi -t 3000 --processes 8 --threads 1 -M --async 100 --ugreen --manage-script-name