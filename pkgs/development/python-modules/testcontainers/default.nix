{
  lib,
  buildPythonPackage,
  fetchFromGitHub,

  # build-system
  poetry-core,

  # dependencies
  docker,
  python-dotenv,
  typing-extensions,
  urllib3,
  wrapt,
}:

buildPythonPackage rec {
  pname = "testcontainers";
  version = "4.10.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "testcontainers";
    repo = "testcontainers-python";
    tag = "testcontainers-v${version}";
    hash = "sha256-0Pd0GxG6Qh6qMJQSMRBaoE4dqFdWewNtdHf6te5vCeE=";
  };

  postPatch = ''
    echo "${version}" > VERSION
  '';

  build-system = [ poetry-core ];

  dependencies = [
    docker
    typing-extensions
    python-dotenv
    urllib3
    wrapt
  ];

  # Tests require various container and database services running
  doCheck = false;

  pythonImportsCheck = [
    "testcontainers"
    "testcontainers.core.container"
  ];

  meta = {
    description = "Allows using docker containers for functional and integration testing";
    homepage = "https://github.com/testcontainers/testcontainers-python";
    changelog = "https://github.com/testcontainers/testcontainers-python/releases/tag/testcontainers-v${version}";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ onny ];
  };
}
