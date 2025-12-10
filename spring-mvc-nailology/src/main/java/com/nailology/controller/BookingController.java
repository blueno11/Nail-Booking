package com.nailology.controller;

import com.nailology.entity.Customer;
import com.nailology.entity.Booking;
import com.nailology.model.BookingForm;
import com.nailology.service.BookingService;
import com.nailology.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.text.SimpleDateFormat;
import com.nailology.entity.ServiceEntity;

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
        model.addAttribute("staffs", bookingService.getAllStaffs());
        model.addAttribute("locations", bookingService.getAllLocations());
        model.addAttribute("bookingForm", new BookingForm());
        
        // Nếu có customerId, lấy thông tin khách hàng
        if (customerId != null) {
            Customer customer = customerService.getCustomerById(customerId);
            if (customer != null) {
                model.addAttribute("customer", customer);
                model.addAttribute("selectedCustomerId", customerId);
            }
        }
        
        return "booking/form";
    }

    @PostMapping("/submit")
    public String submitBooking(
            @RequestParam(value = "selectedServiceIds", required = false) int[] selectedServiceIds,
            @RequestParam(value = "customerId", required = false) Long customerId,
            @ModelAttribute("bookingForm") BookingForm bookingForm,
            Model model) {

        // Convert array to list
        if (selectedServiceIds != null) {
            java.util.List<Integer> serviceIds = new java.util.ArrayList<>();
            for (int id : selectedServiceIds) {
                serviceIds.add(id);
            }
            bookingForm.setSelectedServiceIds(serviceIds);
        }

        // Link with customer and update last visit
        if (customerId != null && customerId > 0) {
            Customer customer = customerService.getCustomerById(customerId);
            if (customer != null) {
                customerService.updateLastVisitDate(customerId);
            }
        }

        // Persist booking
        bookingService.saveBooking(bookingForm, customerId);
        return "redirect:/booking/list?success=true";
    }

    // List all bookings
    @GetMapping("/list")
    public String listBookings(Model model) {
        model.addAttribute("bookings", bookingService.getAllBookings());
        return "booking/list";
    }

    // View booking detail
    @GetMapping("/{id}")
    public String viewBooking(@PathVariable("id") Long id, Model model) {
        Booking booking = bookingService.getBookingById(id);
        if (booking == null) {
            return "redirect:/booking/list?error=notfound";
        }
        model.addAttribute("booking", booking);
        return "booking/detail";
    }

    // Edit booking form
    @GetMapping("/{id}/edit")
    public String editBooking(@PathVariable("id") Long id, Model model) {
        Booking booking = bookingService.getBookingById(id);
        if (booking == null) return "redirect:/booking/list?error=notfound";

        BookingForm form = new BookingForm();
        SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm");
        form.setDate(sdfDate.format(booking.getBookingDateTime()));
        form.setTime(sdfTime.format(booking.getBookingDateTime()));
        if (booking.getStaff() != null) form.setStaffId(booking.getStaff().getId());
        if (booking.getLocation() != null) form.setLocationId(booking.getLocation().getId());
        // services
        if (booking.getServices() != null) {
            java.util.List<Integer> sids = new java.util.ArrayList<>();
            for (ServiceEntity s : booking.getServices()) sids.add(s.getId().intValue());
            form.setSelectedServiceIds(sids);
        }

        model.addAttribute("bookingForm", form);
        model.addAttribute("staffs", bookingService.getAllStaffs());
        model.addAttribute("locations", bookingService.getAllLocations());
        model.addAttribute("services", bookingService.getAllServices());
        model.addAttribute("bookingId", id);
        return "booking/form";
    }

    @PostMapping("/{id}/update")
    public String updateBooking(@PathVariable("id") Long id,
                                @RequestParam(value = "selectedServiceIds", required = false) int[] selectedServiceIds,
                                @ModelAttribute("bookingForm") BookingForm bookingForm) {
        if (selectedServiceIds != null) {
            java.util.List<Integer> serviceIds = new java.util.ArrayList<>();
            for (int sid : selectedServiceIds) serviceIds.add(sid);
            bookingForm.setSelectedServiceIds(serviceIds);
        }
        bookingService.updateBooking(id, bookingForm);
        return "redirect:/booking/" + id + "?updated=true";
    }

    @PostMapping("/{id}/cancel")
    public String cancelBooking(@PathVariable("id") Long id) {
        bookingService.cancelBooking(id);
        return "redirect:/booking/list?cancelled=true";
    }

    /**
     * Chuyển hướng đến trang chọn khách hàng trước khi đặt lịch
     */
    @GetMapping("/select-customer")
    public String selectCustomerForBooking() {
        return "redirect:/customer/select-for-booking";
    }
}

