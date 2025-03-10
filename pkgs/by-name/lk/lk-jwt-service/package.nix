{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "lk-jwt-service";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "element-hq";
    repo = "lk-jwt-service";
    tag = "v${version}";
    hash = "sha256-dnlcJaGJqhFLrVvyU9hVwrE/r+wxknbnINSIfUDKC7I=";
  };

  vendorHash = "sha256-AGkwjzdTjfDA8K6ko24QSSxbTQeFGpu9sv5m8ZCmNJI=";

  meta = with lib; {
    description = "Minimal service to issue LiveKit JWTs for MatrixRTC";
    homepage = "https://github.com/element-hq/lk-jwt-service";
    license = licenses.agpl3Plus;
    maintainers = with maintainers; [ kilimnik ];
    mainProgram = "lk-jwt-service";
  };
}
