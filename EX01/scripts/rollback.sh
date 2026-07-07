#!/usr/bin/env bash
# [롤백/원복] 배포 후 문제가 생겼을 때, releases/ 에 보관된 이전 버전으로 되돌린다.
# 사용법: scripts/rollback.sh <이전_버전>   예: scripts/rollback.sh 1.0.0
set -e

PREV_VERSION="${1:?되돌릴 이전 버전을 인자로 주세요. 예) scripts/rollback.sh 1.0.0}"
PREV="releases/app-${PREV_VERSION}.jar"
JAR="build/libs/app.jar"

if [ ! -f "$PREV" ]; then
  echo "!! 이전 릴리스가 없습니다: $PREV" >&2
  echo "   보관된 릴리스 목록:" >&2
  ls -1 releases/ 2>/dev/null >&2 || echo "   (releases 폴더 없음)" >&2
  exit 1
fi

# TODO(롤백/원복): 보관된 이전 버전($PREV)을 배포 대상($JAR)으로 복사하여 되돌리시오.
echo "==> (TODO) 롤백 후 scripts/run.sh 로 재실행하고 /api/version 으로 이전 버전인지 확인하세요."
