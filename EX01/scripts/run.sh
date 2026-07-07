#!/usr/bin/env bash
# [배포/실행] 지정한 프로파일로 애플리케이션을 실행한다. 기본은 prod.
set -e

PROFILE="${1:-prod}"
JAR="build/libs/app.jar"

if [ ! -f "$JAR" ]; then
  echo "!! $JAR 가 없습니다. 먼저 scripts/build.sh 를 실행하세요." >&2
  exit 1
fi

echo "==> 프로파일=$PROFILE 로 실행합니다."
# TODO(배포/실행): java -jar 로 $JAR 를 실행하되 --spring.profiles.active=$PROFILE 로 프로파일을 지정하시오.
