package com.example.orderservice;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
public class OrderController {

    private static final Logger logger = LoggerFactory.getLogger(OrderController.class);

    @GetMapping("/")
    public String root() {
        return "order-service is running";
    }

    @GetMapping("/health")
    public String health() {
        logger.info("event=health_check service=order-service status=UP");
        return "OK";
    }

    @GetMapping("/orders")
    public List<Map<String, Object>> getOrders() throws InterruptedException {
        long start = System.currentTimeMillis();

        // Simulate downstream processing latency
        Thread.sleep(150);

        List<Map<String, Object>> orders = List.of(
                Map.of("orderId", 101, "profileId", 1, "amount", 250.75),
                Map.of("orderId", 102, "profileId", 1, "amount", 99.99)
        );

        long elapsed = System.currentTimeMillis() - start;

        logger.info("event=get_orders service=order-service status=SUCCESS records={} elapsedMs={}",
                orders.size(), elapsed);

        return orders;
    }

    @GetMapping("/simulate-error")
    public String simulateError() {
        logger.error("event=simulate_error service=order-service status=FAILED error=manual_test_error");
        throw new RuntimeException("Manual test exception from order-service");
    }
}