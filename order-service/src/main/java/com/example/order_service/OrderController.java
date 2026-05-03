package com.example.order_service;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class OrderController {

    @GetMapping("/orders")
    public String getOrders() {
        return "Orders API working!";
    }

    @GetMapping("/health")
    public String health() {
        return "OK";
    }

}