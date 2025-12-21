package com.nailology.controller;

import com.nailology.entity.Booking;
import com.nailology.entity.Booking.BookingStatus;
import com.nailology.entity.Notification;
import com.nailology.entity.Staff;
import com.nailology.service.BookingService;
import com.nailology.service.NotificationService;
import com.nailology.service.StaffService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.List;

@Controller
@RequestMapping("/staff/booking")
public class StaffBookingController {

    @Autowired
    private BookingService bookingService;

    @Autowired
    private StaffService staffService;

    @Autowired
    private NotificationService notificationService;

    @GetMapping
    public String listBookings(
            @RequestParam(required = false) String status,
            @RequestParam(required = false) String date,
            Model model, HttpSession session) {
        Long staffId = (Long) session.getAttribute("staffId");
        List<Booking> bookings = bookingService.findBookingsByStaffLocations(staffId, status, date);
        
        long pendingCount = bookings.stream().filter(b -> b.getStatus() == BookingStatus.PENDING).count();
        long confirmedCount = bookings.stream().filter(b -> b.getStatus() == BookingStatus.CONFIRMED).count();

        model.addAttribute("bookings", bookings);
        model.addAttribute("pendingCount", pendingCount);
        model.addAttribute("confirmedCount", confirmedCount);
        model.addAttribute("selectedStatus", status);
        model.addAttribute("selectedDate", date);
        model.addAttribute("staffName", session.getAttribute("staffName"));
        return "staff/booking/list";
    }

    @GetMapping("/{id}")
    public String viewBooking(@PathVariable Long id, Model model, HttpSession session) {
        Booking booking = bookingService.findById(id);
        if (booking == null) {
            return "redirect:/staff/booking?error=not_found";
        }
        List<Staff> staffAtLocation = staffService.getActiveStaffByLocation(booking.getLocation().getId());
        model.addAttribute("booking", booking);
        model.addAttribute("staffList", staffAtLocation);
        model.addAttribute("staffName", session.getAttribute("staffName"));
        return "staff/booking/detail";
    }


    @PostMapping("/{id}/confirm")
    public String confirmBooking(@PathVariable Long id,
            @RequestParam(required = false) Long assignedStaffId,
            HttpSession session, RedirectAttributes redirectAttributes) {
        Long staffId = (Long) session.getAttribute("staffId");
        Booking booking = bookingService.confirmBooking(id, staffId);
        if (assignedStaffId != null) {
            Staff assignedStaff = staffService.getById(assignedStaffId);
            if (assignedStaff != null) {
                bookingService.assignStaff(id, assignedStaff);
            }
        }
        redirectAttributes.addFlashAttribute("success", "Đã xác nhận lịch hẹn #" + booking.getBookingCode());
        return "redirect:/staff/booking/" + id;
    }

    @PostMapping("/{id}/assign")
    public String assignStaff(@PathVariable Long id, @RequestParam Long assignedStaffId,
            RedirectAttributes redirectAttributes) {
        Staff assignedStaff = staffService.getById(assignedStaffId);
        if (assignedStaff != null) {
            bookingService.assignStaff(id, assignedStaff);
            redirectAttributes.addFlashAttribute("success", "Đã gán nhân viên " + assignedStaff.getName());
        }
        return "redirect:/staff/booking/" + id;
    }

    @PostMapping("/{id}/complete")
    public String completeBooking(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        Booking booking = bookingService.completeBooking(id);
        redirectAttributes.addFlashAttribute("success", "Đã hoàn thành lịch hẹn #" + booking.getBookingCode());
        return "redirect:/staff/booking/" + id;
    }

    @PostMapping("/{id}/cancel")
    public String cancelBooking(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        Booking booking = bookingService.cancelBookingById(id);
        redirectAttributes.addFlashAttribute("success", "Đã hủy lịch hẹn #" + booking.getBookingCode());
        return "redirect:/staff/booking";
    }

    @GetMapping("/my")
    public String myBookings(Model model, HttpSession session) {
        Long staffId = (Long) session.getAttribute("staffId");
        List<Booking> bookings = bookingService.findByAssignedStaff(staffId);
        model.addAttribute("bookings", bookings);
        model.addAttribute("staffName", session.getAttribute("staffName"));
        return "staff/booking/my-bookings";
    }

    @GetMapping("/notifications")
    public String notifications(Model model, HttpSession session) {
        Long staffId = (Long) session.getAttribute("staffId");
        List<Notification> notifications = notificationService.getNotificationsForStaff(staffId, false);
        long unreadCount = notificationService.countUnreadNotifications(staffId);
        model.addAttribute("notifications", notifications);
        model.addAttribute("unreadCount", unreadCount);
        model.addAttribute("staffName", session.getAttribute("staffName"));
        return "staff/notifications";
    }

    @PostMapping("/notifications/{id}/read")
    public String markNotificationRead(@PathVariable Long id) {
        notificationService.markAsRead(id);
        return "redirect:/staff/booking/notifications";
    }

    @PostMapping("/notifications/read-all")
    public String markAllRead(HttpSession session) {
        Long staffId = (Long) session.getAttribute("staffId");
        notificationService.markAllAsRead(staffId);
        return "redirect:/staff/booking/notifications";
    }
}
