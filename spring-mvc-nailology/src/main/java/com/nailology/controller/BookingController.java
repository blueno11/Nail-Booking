package com.nailology.controller;

import com.nailology.entity.Customer;
import com.nailology.model.BookingForm;
import com.nailology.service.BookingService;
import com.nailology.service.CustomerService;
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

    @Autowired
    private CustomerService customerService;

    @GetMapping
    public String bookingPage(
            @RequestParam(value = "customerId", required = false) Long customerId,
            Model model) {
        model.addAttribute("services", bookingService.getAllServices());
        
        // Nếu có customerId, lấy thông tin khách hàng
        if (customerId != null) {
            Customer customer = customerService.getCustomerById(customerId);
            if (customer != null) {
                model.addAttribute("customer", customer);
                model.addAttribute("selectedCustomerId", customerId);
            }
        }
        
        return "booking";
    }

    @PostMapping("/submit")
    public String submitBooking(
            @RequestParam(value = "selectedServiceIds", required = false) int[] selectedServiceIds,
            @RequestParam(value = "customerId", required = false) Long customerId,
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
        
        // Liên kết với khách hàng nếu có
        if (customerId != null && customerId > 0) {
            Customer customer = customerService.getCustomerById(customerId);
            if (customer != null) {
                // Cập nhật ngày truy cập cuối
                customerService.updateLastVisitDate(customerId);
            }
        }
        
        // Process booking
        bookingService.saveBooking(bookingForm);
        model.addAttribute("success", true);
        return "redirect:/booking?success=true";
    }

    /**
     * Chuyển hướng đến trang chọn khách hàng trước khi đặt lịch
     */
    @GetMapping("/select-customer")
    public String selectCustomerForBooking() {
        return "redirect:/customer/select-for-booking";
    }
}

