package com.nailology.controller;

import com.nailology.service.BookingAvailabilityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/booking")
public class BookingApiController {

    @Autowired
    private BookingAvailabilityService availabilityService;

    /**
     * API lấy khung giờ khả dụng
     * GET /api/booking/slots?locationId=1&date=2024-12-25&duration=60
     */
    @GetMapping("/slots")
    public ResponseEntity<List<Map<String, Object>>> getAvailableSlots(
            @RequestParam Long locationId,
            @RequestParam String date,
            @RequestParam(defaultValue = "60") int duration) {
        try {
            LocalDate bookingDate = LocalDate.parse(date);
            List<Map<String, Object>> slots = availabilityService.getAvailableSlots(locationId, bookingDate, duration);
            return ResponseEntity.ok(slots);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }

    /**
     * API kiểm tra slot có khả dụng không
     * GET /api/booking/check?locationId=1&date=2024-12-25&time=10:00&duration=60
     */
    @GetMapping("/check")
    public ResponseEntity<Map<String, Object>> checkSlotAvailability(
            @RequestParam Long locationId,
            @RequestParam String date,
            @RequestParam String time,
            @RequestParam(defaultValue = "60") int duration) {
        try {
            LocalDate bookingDate = LocalDate.parse(date);
            java.time.LocalTime bookingTime = java.time.LocalTime.parse(time);
            boolean available = availabilityService.isSlotAvailable(locationId, bookingDate, bookingTime, duration);
            return ResponseEntity.ok(Map.of("available", available));
        } catch (Exception e) {
            return ResponseEntity.ok(Map.of("available", false, "error", e.getMessage()));
        }
    }
}
