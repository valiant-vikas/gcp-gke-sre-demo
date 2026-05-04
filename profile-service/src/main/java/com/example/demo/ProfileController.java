package com.example.profileservice;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.*;

@RestController
public class ProfileController {

    private static final Logger logger = LoggerFactory.getLogger(ProfileController.class);

    @Value("${order.service.url}")
    private String orderServiceUrl;

    @GetMapping("/")
    public String root() {
        return "profile-service is running";
    }

    @GetMapping("/health")
    public String health() {
        logger.info("event=health_check service=profile-service status=UP");
        return "OK";
    }

    @GetMapping("/profiles")
    public List<Map<String, Object>> getProfiles() {
        long start = System.currentTimeMillis();

        List<Map<String, Object>> profiles = List.of(
                Map.of("id", 1, "name", "Vikas", "role", "SRE"),
                Map.of("id", 2, "name", "Demo User", "role", "Developer")
        );

        long elapsed = System.currentTimeMillis() - start;

        logger.info("event=get_profiles service=profile-service status=SUCCESS records={} elapsedMs={}",
                profiles.size(), elapsed);

        return profiles;
    }

    @GetMapping("/profile-orders")
    public String getProfileOrders() {
        long start = System.currentTimeMillis();

        try {
            RestTemplate restTemplate = new RestTemplate();
            String response = restTemplate.getForObject(orderServiceUrl, String.class);

            long elapsed = System.currentTimeMillis() - start;

            logger.info("event=profile_orders service=profile-service downstream=order-service status=SUCCESS elapsedMs={} url={}",
                    elapsed, orderServiceUrl);

            return "Profile Service Response + " + response;

        } catch (Exception ex) {
            long elapsed = System.currentTimeMillis() - start;

            logger.error("event=profile_orders service=profile-service downstream=order-service status=FAILED elapsedMs={} error={}",
                    elapsed, ex.getMessage());

            throw ex;
        }
    }

    @GetMapping("/simulate-error")
    public String simulateError() {
        logger.error("event=simulate_error service=profile-service status=FAILED error=manual_test_error");
        throw new RuntimeException("Manual test exception from profile-service");
    }
}