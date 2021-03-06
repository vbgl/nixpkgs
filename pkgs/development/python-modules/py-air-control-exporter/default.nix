{ buildPythonPackage, fetchPypi, flask, isPy27, lib, nixosTests
, prometheus_client, py-air-control, pytestCheckHook, pytest-cov, pytest-runner
, setuptools-scm }:

buildPythonPackage rec {
  pname = "py-air-control-exporter";
  version = "0.3.0";
  disabled = isPy27;

  src = fetchPypi {
    inherit pname version;
    sha256 = "ece2e446273542e5c0352c9d6e80d8279132c6ada3649c59e87a711448801a3b";
  };

  nativeBuildInputs = [ setuptools-scm ];
  checkInputs = [ pytestCheckHook pytest-cov pytest-runner ];
  propagatedBuildInputs = [ flask prometheus_client py-air-control ];

  passthru.tests = { inherit (nixosTests.prometheus-exporters) py-air-control; };

  meta = with lib; {
    description = "Exports Air Quality Metrics to Prometheus.";
    homepage = "https://github.com/urbas/py-air-control-exporter";
    license = licenses.mit;
    maintainers = with maintainers; [ urbas ];
  };
}
