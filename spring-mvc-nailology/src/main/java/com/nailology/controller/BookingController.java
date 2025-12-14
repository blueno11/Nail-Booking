package com.nailology.controller;

import com.nailology.entity.Customer;
import com.nailology.entity.Booking;
import com.nailology.model.BookingForm;
import com.nailology.service.BookingService;
import com.nailology.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

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
        
        model.addAttribute("locations", bookingService.getAllLocations());
        model.addAttribute("timeSlots", bookingService.getAvailableTimeSlots());
        model.addAttribute("bookingForm", new BookingForm());
        return "booking";
    }

    @PostMapping("/submit")
    public String submitBooking(
            @RequestParam(value = "selectedServiceIds", required = false) int[] selectedServiceIds,
            @RequestParam(value = "customerId", required = false) Long customerId,
            @RequestParam(value = "locationId", required = false) Long locationId,
            BookingForm bookingForm,
            RedirectAttributes redirectAttributes) {
        try {
            System.out.println("=== BOOKING SUBMIT ===");
            System.out.println("Customer: " + bookingForm.getCustomerName());
            System.out.println("Email: " + bookingForm.getEmail());
            System.out.println("LocationId: " + locationId);
            System.out.println("Date: " + bookingForm.getDate());
            System.out.println("Time: " + bookingForm.getTime());
            
            if (selectedServiceIds != null) {
                List<Integer> serviceIds = new ArrayList<>();
                for (int id : selectedServiceIds) {
                    serviceIds.add(id);
                }
                bookingForm.setSelectedServiceIds(serviceIds);
                System.out.println("Services: " + serviceIds);
            }
            
            // Set locationId explicitly
            bookingForm.setLocationId(locationId);
            
            // Liên kết với khách hàng nếu có
            if (customerId != null && customerId > 0) {
                Customer customer = customerService.getCustomerById(customerId);
                if (customer != null) {
                    // Cập nhật ngày truy cập cuối
                    customerService.updateLastVisitDate(customerId);
                }
            }
            
            Booking booking = bookingService.saveBooking(bookingForm);
            System.out.println("Booking saved with code: " + booking.getBookingCode());
            
            redirectAttributes.addFlashAttribute("success", true);
            redirectAttributes.addFlashAttribute("bookingCode", booking.getBookingCode());
            return "redirect:/booking/success";
        } catch (Exception e) {
            System.out.println("ERROR: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Lỗi: " + e.getMessage());
            return "redirect:/booking";
        }
    }

    @GetMapping("/success")
    public String bookingSuccess(Model model) {
        return "booking-success";
    }

    @GetMapping("/manage")
    public String manageBookingPage() {
        return "booking-manage";
    }


    @PostMapping("/search")
    public String searchBookings(
            @RequestParam(required = false) String email,
            @RequestParam(required = false) String phone,
            @RequestParam(required = false) String bookingCode,
            Model model,
            RedirectAttributes redirectAttributes) {
        try {
            List<Booking> bookings = new ArrayList<>();
            
            // Tìm theo mã đặt lịch
            if (bookingCode != null && !bookingCode.trim().isEmpty()) {
                bookingService.findByBookingCode(bookingCode.trim())
                    .ifPresent(bookings::add);
                model.addAttribute("searchType", "code");
                model.addAttribute("bookingCode", bookingCode);
            }
            // Tìm theo email và phone
            else if (email != null && !email.trim().isEmpty()) {
                if (phone != null && !phone.trim().isEmpty()) {
                    bookings = bookingService.findByEmailAndPhone(email.trim(), phone.trim());
                } else {
                    bookings = bookingService.findByEmail(email.trim());
                }
                model.addAttribute("searchType", "email");
                model.addAttribute("email", email);
            }
            
            model.addAttribute("bookings", bookings);
            return "booking-list";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Lỗi tìm kiếm: " + e.getMessage());
            return "redirect:/booking/manage";
        }
    }

    @GetMapping("/view/{code}")
    public String viewBooking(@PathVariable String code, Model model) {
        Booking booking = bookingService.findByBookingCode(code)
            .orElseThrow(() -> new RuntimeException("Booking not found"));
        model.addAttribute("booking", booking);
        model.addAttribute("locations", bookingService.getAllLocations());
        model.addAttribute("timeSlots", bookingService.getAvailableTimeSlots());
        return "booking-detail";
    }

    @PostMapping("/update/{id}")
    public String updateBooking(
            @PathVariable Long id,
            BookingForm bookingForm,
            RedirectAttributes redirectAttributes) {
        try {
            Booking booking = bookingService.updateBooking(id, bookingForm);
            redirectAttributes.addFlashAttribute("success", "Cập nhật lịch hẹn thành công!");
            return "redirect:/booking/view/" + booking.getBookingCode();
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/booking/view/" + id;
        }
    }

    @PostMapping("/cancel/{code}")
    public String cancelBooking(
            @PathVariable String code,
            RedirectAttributes redirectAttributes) {
        try {
            bookingService.cancelBooking(code);
            redirectAttributes.addFlashAttribute("success", "Đã hủy lịch hẹn thành công!");
            return "redirect:/booking/manage";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/booking/view/" + code;
        }
    }

    /**
     * Chuyển hướng đến trang chọn khách hàng trước khi đặt lịch
     */
    @GetMapping("/select-customer")
    public String selectCustomerForBooking() {
        return "redirect:/customer/select-for-booking";
    }
}
