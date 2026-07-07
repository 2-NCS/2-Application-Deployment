# EX01 체크리스트 (제출 전 자가 점검)

## ① 배포 환경 구성 (NCS 1)
- [ ] build.gradle 에 JDK 21 · Spring Boot 3.5 · 실행 가능 JAR(bootJar 이름 고정) 설정을 확인했습니다
- [ ] application.properties(dev, 포트 8080)와 application-prod.properties(prod, 포트 9090)로 환경을 분리했습니다
- [ ] 릴리스 보관용 배포 디렉토리(releases) 구성을 확인했습니다
- [ ] 배포환경_명세서 에 JDK·Gradle·포트·프로파일·빌드도구를 기록했습니다

## ② 소스 검증 (NCS 2)
- [ ] `gradlew test` 가 통과함을 확인했습니다(HealthControllerTest)
- [ ] 환경설정(포트·프로파일·버전) 값이 명세와 일치하는지 점검했습니다
- [ ] `/api/health` 응답의 status·version·env·profile 필드를 확인했습니다

## ③ 빌드 (NCS 3)
- [ ] `gradlew clean bootJar` 로 build/libs/app.jar 를 생성했습니다
- [ ] 산출물 경로와 빌드 로그(성공/실패)를 확인했습니다
- [ ] 빌드 실패 시 원인(테스트 실패·컴파일 오류 등)을 분석했습니다
- [ ] 빌드_결과서 에 명령·결과·산출물 경로를 기록했습니다

## ④ 배포 · 롤백 (NCS 4)
- [ ] `java -jar` + prod 프로파일로 애플리케이션을 실행했습니다(포트 9090)
- [ ] `/api/health` 와 `/actuator/health` 로 정상 동작을 확인했습니다
- [ ] rollback.sh 로 이전 버전을 복원하고 `/api/version` 으로 확인했습니다
- [ ] 배포_절차서·롤백_절차서 를 작성했습니다

## NCS 능력단위요소 매핑
| 요소 | 이 과제에서 |
|:--|:--|
| ① 배포 환경 구성 | build.gradle 빌드 설정 / dev·prod 프로파일 분리 / releases 배포 디렉토리 |
| ② 소스 검증 | gradlew test 통과 / 포트·프로파일·버전 점검 / 헬스 엔드포인트 확인 |
| ③ 빌드 | clean bootJar 로 app.jar 생성 / 산출물·빌드로그 확인 / 실패 원인 분석 |
| ④ 배포 | prod 프로파일 실행 / /api/health·/actuator/health 확인 / rollback.sh 복원 |
