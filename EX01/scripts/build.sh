#!/usr/bin/env bash
# [빌드] 소스 검증(테스트) 후 실행 가능한 JAR 을 생성한다.
set -e

echo "==> 1) 소스 검증(테스트) + 클린 빌드"
# TODO(소스검증+빌드): gradlew 로 clean → test → bootJar 를 실행하시오.
./gradlew clean test bootJar

JAR="build/libs/app.jar"
if [ -f "$JAR" ]; then
  echo "==> 2) 빌드 성공: $JAR"
  ls -lh "$JAR"
else
  echo "!! 빌드 실패: $JAR 가 생성되지 않았습니다." >&2
  exit 1
fi

  # TODO(릴리스 보관): 롤백에 대비해 build/libs/app.jar 를 releases/app-<version>.jar 로 복사하시오.
#  - version 은 build.gradle 의 version 값을 사용
#ls build/libs/app.jar
#mkdir -p releases
#cp build/libs/app.jar releases/app-1.0.0.jar

