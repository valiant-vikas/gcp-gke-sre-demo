package com.example.demo;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

@RestController
public class ProfileController {

    @GetMapping("/profiles")
    public String getProfiles() {
        return "Profiles API working!";
    }

    @GetMapping("/health")
    public String health() {
        return "OK";
    }

    @GetMapping("/version")
    public String version() {
        return "v1";
    }

    @GetMapping("/")
    public String root() {
        return "profile-service is running";
    }
}