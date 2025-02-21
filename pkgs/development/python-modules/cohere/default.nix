{ lib
, buildPythonPackage
, fetchpatch
, fetchPypi
, poetry-core
, pythonOlder
, aiohttp
, backoff
, fastavro
, importlib-metadata
, requests
, urllib3
}:

buildPythonPackage rec {
  pname = "cohere";
  version = "4.49";
  pyproject = true;

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-UJ6BxE+OG06zGyfY6jiOeeBMW+6DCKwaM3pgU90/Woc=";
  };

  nativeBuildInputs = [
    poetry-core
  ];

  propagatedBuildInputs = [
    aiohttp
    backoff
    fastavro
    importlib-metadata
    requests
    urllib3
  ];

  # tests require CO_API_KEY
  doCheck = false;

  pythonImportsCheck = [
    "cohere"
  ];

  meta = with lib; {
    description = "Simplify interfacing with the Cohere API";
    homepage = "https://docs.cohere.com/docs";
    changelog = "https://github.com/cohere-ai/cohere-python/blob/main/CHANGELOG.md#${builtins.replaceStrings ["."] [""] version}";
    license = licenses.mit;
    maintainers = with maintainers; [ natsukium ];
  };
}
