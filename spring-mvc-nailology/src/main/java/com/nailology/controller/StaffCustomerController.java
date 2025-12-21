package com.nailology.controller;

import com.nailology.entity.Booking;
import com.nailology.entity.Customer;
import com.nailology.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Controller quản lý khách hàng - dành cho Staff
 * URL: /staff/customer/*
 */
@Controller
@RequestMapping("/staff/customer")
public class StaffCustomerController {

    @Autowired
    private CustomerService customerService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    // ===== DANH SÁCH KHÁCH HÀNG =====
    @GetMapping
    public String listCustomers(
            @RequestParam(value = "search", required = false) String search,
            @RequestParam(value = "status", required = false, defaultValue = "ACTIVE") String status,
            @RequestParam(value = "marketing", required = false) Boolean marketing,
            Model model,
            HttpSession session) {
        
        List<Customer> customers;
        
        if (search != null && !search.isEmpty()) {
            customers = customerService.searchCustomers(search);
            model.addAttribute("search", search);
        } else if (Boolean.TRUE.equals(marketing)) {
            customers = customerService.getMarketingCustomers();
            model.addAttribute("filterMarketing", true);
        } else if ("ALL".equals(status)) {
            customers = customerService.getAllCustomers();
        } else if ("BLACKLIST".equals(status)) {
            customers = customerService.getCustomersByStatus("BLACKLIST");
        } else {
            customers = customerService.getAllActiveCustomers();
        }
        
        model.addAttribute("customers", customers);
        model.addAttribute("status", status);
        model.addAttribute("activeCount", customerService.getActiveCustomerCount());
        model.addAttribute("staffName", session.getAttribute("staffName"));
        
        return "staff/customer/list";
    }

    // ===== XEM CHI TIẾT KHÁCH HÀNG =====
    @GetMapping("/{id}")
    public String viewCustomer(@PathVariable Long id, Model model, HttpSession session) {
        Customer customer = customerService.getCustomerById(id);
        
        if (customer == null) {
            return "redirect:/staff/customer?error=not_found";
        }
        
        List<Booking> serviceHistory = customerService.getCustomerServiceHistory(id);
        
        model.addAttribute("customer", customer);
        model.addAttribute("serviceHistory", serviceHistory);
        model.addAttribute("visitCount", serviceHistory.size());
        model.addAttribute("staffName", session.getAttribute("staffName"));
        
        return "staff/customer/detail";
    }

    // ===== FORM THÊM KHÁCH HÀNG MỚI =====
    @GetMapping("/create")
    public String createCustomerForm(Model model, HttpSession session) {
        model.addAttribute("customer", new Customer());
        model.addAttribute("isNew", true);
        model.addAttribute("staffName", session.getAttribute("staffName"));
        return "staff/customer/form";
    }

    // ===== FORM CHỈNH SỬA KHÁCH HÀNG =====
    @GetMapping("/{id}/edit")
    public String editCustomerForm(@PathVariable Long id, Model model, HttpSession session) {
        Customer customer = customerService.getCustomerById(id);
        
        if (customer == null) {
            return "redirect:/staff/customer?error=not_found";
        }
        
        model.addAttribute("customer", customer);
        model.addAttribute("isNew", false);
        model.addAttribute("staffName", session.getAttribute("staffName"));
        return "staff/customer/form";
    }

    // ===== LƯU KHÁCH HÀNG =====
    @PostMapping("/save")
    public String saveCustomer(
            @ModelAttribute Customer customer,
            @RequestParam(value = "acceptMarketing", required = false, defaultValue = "false") String acceptMarketing,
            Model model) {
        
        if (customer.getFullName() == null || customer.getFullName().trim().isEmpty()) {
            model.addAttribute("error", "Tên khách hàng không được để trống");
            model.addAttribute("customer", customer);
            return "staff/customer/form";
        }
        
        if (customer.getPhoneNumber() == null || customer.getPhoneNumber().trim().isEmpty()) {
            model.addAttribute("error", "Số điện thoại không được để trống");
            model.addAttribute("customer", customer);
            return "staff/customer/form";
        }
        
        Customer existingByPhone = customerService.getCustomerByPhone(customer.getPhoneNumber());
        if (existingByPhone != null && (customer.getId() == null || !existingByPhone.getId().equals(customer.getId()))) {
            model.addAttribute("error", "Số điện thoại này đã được đăng ký");
            model.addAttribute("customer", customer);
            return "staff/customer/form";
        }
        
        customer.setAcceptMarketing("true".equals(acceptMarketing));
        Long customerId = customerService.saveOrUpdateCustomer(customer);
        
        return "redirect:/staff/customer/" + customerId + "?success=true";
    }

    // ===== CẬP NHẬT TRẠNG THÁI =====
    @PostMapping("/{id}/update-status")
    public String updateStatus(@PathVariable Long id, @RequestParam String status) {
        if ("ACTIVE".equals(status) || "INACTIVE".equals(status) || "BLACKLIST".equals(status)) {
            customerService.updateCustomerStatus(id, status);
        }
        return "redirect:/staff/customer/" + id;
    }

    // ===== CẬP NHẬT MARKETING =====
    @PostMapping("/{id}/update-marketing")
    public String updateMarketing(@PathVariable Long id, @RequestParam boolean accept) {
        customerService.updateMarketingPreference(id, accept);
        return "redirect:/staff/customer/" + id;
    }

    // ===== LỊCH SỬ DỊCH VỤ =====
    @GetMapping("/{id}/history")
    public String viewServiceHistory(@PathVariable Long id, Model model, HttpSession session) {
        Customer customer = customerService.getCustomerById(id);
        
        if (customer == null) {
            return "redirect:/staff/customer?error=not_found";
        }
        
        List<Booking> serviceHistory = customerService.getCustomerServiceHistory(id);
        
        model.addAttribute("customer", customer);
        model.addAttribute("serviceHistory", serviceHistory);
        model.addAttribute("staffName", session.getAttribute("staffName"));
        
        return "staff/customer/history";
    }

    // ===== THỐNG KÊ =====
    @GetMapping("/top-spenders")
    public String topSpenders(Model model, HttpSession session) {
        List<Customer> topCustomers = customerService.getTopSpendingCustomers(20);
        model.addAttribute("customers", topCustomers);
        model.addAttribute("pageTitle", "Khách hàng chi tiêu cao nhất");
        model.addAttribute("staffName", session.getAttribute("staffName"));
        return "staff/customer/top-spenders";
    }

    @GetMapping("/new")
    public String newCustomers(
            @RequestParam(value = "days", defaultValue = "30") int days,
            Model model,
            HttpSession session) {
        
        List<Customer> newCustomers = customerService.getNewCustomersInDays(days);
        model.addAttribute("customers", newCustomers);
        model.addAttribute("days", days);
        model.addAttribute("pageTitle", "Khách hàng mới trong " + days + " ngày");
        model.addAttribute("staffName", session.getAttribute("staffName"));
        return "staff/customer/new-customers";
    }

    // ===== XÓA KHÁCH HÀNG =====
    @PostMapping("/{id}/delete")
    public String deleteCustomer(@PathVariable Long id) {
        customerService.deleteCustomer(id);
        return "redirect:/staff/customer?success=deleted";
    }
}
