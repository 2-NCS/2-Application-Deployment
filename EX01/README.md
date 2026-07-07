# EX01_답 — 애플리케이션 배포 (배포 실습 : S-Deploy) 〔정답〕

> EX01 의 모범 수행결과(정답)입니다.
> NCS 능력단위: 애플리케이션 배포 (2001020214_23v6) — 능력단위요소 ① 배포 환경 구성 / ② 소스 검증 / ③ 빌드 / ④ 배포
> 기술 스택: Spring Boot 3.5 · JDK 21 · Gradle · Spring Boot Actuator

---

## 정답 구성
- **배포 파이프라인 실습용 앱**이 구성되어 있습니다. 로컬에서 빌드 → 실행 → 헬스체크 → 롤백을 재현합니다.
  - `HealthController` : `GET /api/health`(status/version/env/profile), `GET /api/version`(현재 버전)
  - Actuator : `GET /actuator/health`(배포 후 정상 동작 확인)
  - `application.properties`(dev, 포트 8080) + `application-prod.properties`(prod, 포트 9090)
- **빌드 산출물이 고정 이름으로 생성**됩니다 — `bootJar { archiveFileName = 'app.jar' }` → `build/libs/app.jar`.
- **배포 스크립트 3종**이 들어 있습니다.
  - `scripts/build.sh` : `clean test bootJar` 로 검증·빌드 후 `releases/app-<version>.jar` 로 사본 보관
  - `scripts/run.sh` : `java -jar build/libs/app.jar --spring.profiles.active=prod` 로 실행
  - `scripts/rollback.sh` : `releases/` 에 보관된 이전 버전으로 복원

## 폴더 구조
```
EX01_답/
├─ build.gradle              # 빌드 설정(JDK 21, Spring Boot 3.5, bootJar 이름 고정)
├─ settings.gradle
├─ gradlew / gradlew.bat     # Gradle Wrapper
├─ src/
│  ├─ main/java/com/example/demo/
│  │  ├─ DemoApplication.java
│  │  └─ Controller/HealthController.java
│  ├─ main/resources/
│  │  ├─ application.properties          # dev, 포트 8080
│  │  └─ application-prod.properties      # prod, 포트 9090
│  └─ test/java/com/example/demo/
│     └─ HealthControllerTest.java        # 소스 검증(배포 전)
├─ scripts/
│  ├─ build.sh              # 검증 + 빌드 + 릴리스 보관
│  ├─ run.sh                # 프로파일 지정 실행(기본 prod)
│  └─ rollback.sh           # 이전 버전으로 복원
├─ releases/                # 빌드 시 생성(app-<version>.jar 보관, 롤백 대비)
└─ docs/                    # 작업지시서·설계과제·채점기준·가이드·산출물 양식
```

## 빌드 · 실행 · 배포 방법
1. **빌드(소스 검증 + JAR 생성)**
   ```bash
   ./gradlew clean test bootJar
   # 또는 스크립트로 검증·빌드·릴리스 보관까지 한 번에
   bash scripts/build.sh
   ```
   - 산출물: `build/libs/app.jar`, 릴리스 사본: `releases/app-1.0.0.jar`
2. **실행(운영 프로파일)**
   ```bash
   bash scripts/run.sh prod
   # 내부적으로: java -jar build/libs/app.jar --spring.profiles.active=prod
   ```
   - prod 프로파일은 포트 **9090**, dev(기본)는 포트 **8080** 입니다.
3. **헬스체크(배포 후 정상 확인)**
   ```bash
   curl http://localhost:9090/api/health
   curl http://localhost:9090/actuator/health
   ```
   - `/api/health` 응답에 `status:UP`, `version`, `env`, `profile` 이 포함됩니다.
4. **롤백(문제 발생 시 이전 버전 복원)**
   ```bash
   bash scripts/rollback.sh 1.0.0     # releases/app-1.0.0.jar → build/libs/app.jar
   bash scripts/run.sh prod           # 이전 버전 재실행 후 /api/version 으로 확인
   ```

## 실행 환경 참고
- JDK 21 이 설치되어 있어야 합니다(`java -version` 으로 확인).
- 스크립트는 bash 기준입니다. Windows 에서는 Git Bash 또는 WSL 에서 실행합니다.
- ※ 프로젝트가 한글 경로에 있으면 `gradlew`(명령줄) 실행 시 클래스 로딩/인코딩 오류가 날 수 있습니다. 이때는 IntelliJ 의 Gradle 실행기로 돌리거나 영문 경로로 옮겨 실행합니다. (정답은 영문 경로에서 빌드·실행·헬스체크·롤백 전체를 확인했습니다.)

## 배점 (100점 / 합격선 60)
| 파트 | 배점 |
|:--|--:|
| ① 배포 환경 구성 | 20 |
| ② 소스 검증 | 25 |
| ③ 빌드 | 30 |
| ④ 배포·롤백 | 25 |

## 산출물
- 배포환경_명세서 · 빌드_결과서 · 배포_절차서 · 롤백_절차서 (`docs/산출물_양식/` 의 양식을 채워 제출)

> 문제·채점 상세는 `docs/` 의 작업지시서·설계과제·채점기준_체크리스트를 참고합니다.
