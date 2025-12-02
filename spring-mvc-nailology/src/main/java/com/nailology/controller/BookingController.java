package com.nailology.controller;

import com.nailology.model.BookingForm;
import com.nailology.service.BookingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/booking")
public class BookingController {

    @Autowired
    private BookingService bookingService;

    @GetMapping
    public String bookingPage(Model model) {
        model.addAttribute("services", bookingService.getAllServices());
        return "booking";
    }

    @PostMapping("/submit")
    public String submitBooking(
            @RequestParam(value = "selectedServiceIds", required = false) int[] selectedServiceIds,
            BookingForm bookingForm,
            Model model) {
        // Convert array to list
        if (selectedServiceIds != null) {
            java.util.List<Integer> serviceIds = new java.util.ArrayList<>();
            for (int id : selectedServiceIds) {
                serviceIds.add(id);
            }
            bookingForm.setSelectedServiceIds(serviceIds);
        }
        
        // Process booking
        bookingService.saveBooking(bookingForm);
        model.addAttribute("success", true);
        return "redirect:/booking?success=true";
    }
}

