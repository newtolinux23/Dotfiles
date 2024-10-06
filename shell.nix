{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.python312
    pkgs.python312Packages.pip
    pkgs.python312Packages.requests
    pkgs.python312Packages.aiohttp
    pkgs.python312Packages.tqdm
    pkgs.python312Packages.setuptools
    pkgs.python312Packages.wheel
    (pkgs.python312Packages.buildPythonPackage {
      pname = "openai";
      version = "0.28.0";
      src = pkgs.fetchPypi {
        pname = "openai";
        version = "0.28.0";
        sha256 = "1557wlcsw2kflpq3j5xbh6jh87xyfzzwrwfsmsbacjw6qb27hys1";  # Corrected sha256 hash
      };
      nativeBuildInputs = [
        pkgs.python312Packages.setuptools
        pkgs.python312Packages.wheel
        pkgs.python312Packages.pip
      ];
      propagatedBuildInputs = [
        pkgs.python312Packages.aiohttp
        pkgs.python312Packages.tqdm
        pkgs.python312Packages.requests
      ];
      doCheck = false;  # Disable tests to avoid issues with unit testing
    })
  ];

  shellHook = ''
    echo "Python environment with OpenAI v0.28.0 is ready!"
  '';
}
