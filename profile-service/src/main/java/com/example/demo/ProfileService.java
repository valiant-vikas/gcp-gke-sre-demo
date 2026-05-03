package com.example.demo;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
public class ProfileService {

    @Value("${order.service.url}")
    private String orderServiceUrl;

    @GetMapping("/profile-orders")
    public String getProfileOrders() {
        RestTemplate restTemplate = new RestTemplate();
        String response = restTemplate.getForObject(orderServiceUrl, String.class);
        return "Profile + " + response;
    }
}
