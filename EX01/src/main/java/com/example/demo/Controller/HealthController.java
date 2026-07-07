package com.example.demo.Controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.LinkedHashMap;
import java.util.Map;

// 배포 후 정상 동작·버전을 확인하기 위한 엔드포인트다.
@RestController
@RequestMapping("/api")
public class HealthController {

    @Value("${app.version}")
    private String version;

    @Value("${app.env}")
    private String env;

    @Value("${spring.profiles.active:default}")
    private String profile;

    // 배포 검증(헬스체크)용 — 상태·버전·프로파일을 반환한다.
    @GetMapping("/health")
    public Map<String, Object> health() {
        // TODO(배포 확인): status="UP", version, env, profile 을 Map 에 담아 반환하시오.
        return null;
    }

    // 롤백 확인용 — 현재 배포된 버전을 확인한다.
    @GetMapping("/version")
    public Map<String, String> version() {
        // TODO(롤백 확인): version 을 Map 에 담아 반환하시오.
        return null;
    }
}
