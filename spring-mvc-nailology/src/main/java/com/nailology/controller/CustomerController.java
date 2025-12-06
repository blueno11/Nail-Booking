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

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/customer")
public class CustomerController {

    @Autowired
    private CustomerService customerService;

    /**
     * Initialize date format converter for binding form dates
     */
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    // ===== DANH SÁCH KHÁCH HÀNG =====
    /**
     * Hiển thị danh sách tất cả khách hàng
     */
    @GetMapping
    public String listCustomers(
            @RequestParam(value = "search", required = false) String search,
            @RequestParam(value = "status", required = false, defaultValue = "ACTIVE") String status,
            Model model) {
        
        List<Customer> customers;
        
        if (search != null && !search.isEmpty()) {
            customers = customerService.searchCustomers(search);
            model.addAttribute("search", search);
        } else if ("ALL".equals(status)) {
            customers = customerService.getAllCustomers();
        } else {
            customers = customerService.getAllActiveCustomers();
        }
        
        model.addAttribute("customers", customers);
        model.addAttribute("status", status);
        model.addAttribute("activeCount", customerService.getActiveCustomerCount());
        
        return "customer/list";
    }

    // ===== XEM CHI TIẾT KHÁCH HÀNG =====
    /**
     * Hiển thị chi tiết khách hàng và lịch sử dịch vụ
     */
    @GetMapping("/{id}")
    public String viewCustomer(@PathVariable Long id, Model model) {
        Customer customer = customerService.getCustomerById(id);
        
        if (customer == null) {
            return "redirect:/customer?error=not_found";
        }
        
        List<Booking> serviceHistory = customerService.getCustomerServiceHistory(id);
        
        model.addAttribute("customer", customer);
        model.addAttribute("serviceHistory", serviceHistory);
        model.addAttribute("visitCount", serviceHistory.size());
        
        return "customer/detail";
    }

    // ===== FORM THÊM KHÁCH HÀNG MỚI =====
    /**
     * Hiển thị form thêm khách hàng mới
     */
    @GetMapping("/create")
    public String createCustomerForm(Model model) {
        model.addAttribute("customer", new Customer());
        model.addAttribute("isNew", true);
        return "customer/form";
    }

    // ===== FORM CHỈNH SỬA KHÁCH HÀNG =====
    /**
     * Hiển thị form chỉnh sửa khách hàng
     */
    @GetMapping("/{id}/edit")
    public String editCustomerForm(@PathVariable Long id, Model model) {
        Customer customer = customerService.getCustomerById(id);
        
        if (customer == null) {
            return "redirect:/customer?error=not_found";
        }
        
        model.addAttribute("customer", customer);
        model.addAttribute("isNew", false);
        return "customer/form";
    }

    // ===== LƯU KHÁCH HÀNG =====
    /**
     * Lưu hoặc cập nhật khách hàng
     */
    @PostMapping("/save")
    public String saveCustomer(
            @ModelAttribute Customer customer,
            @RequestParam(value = "acceptMarketing", required = false, defaultValue = "false") String acceptMarketing,
            Model model) {
        
        // Xác thực dữ liệu
        if (customer.getFullName() == null || customer.getFullName().trim().isEmpty()) {
            model.addAttribute("error", "Tên khách hàng không được để trống");
            model.addAttribute("customer", customer);
            return customer.getId() == null ? "customer/form" : "redirect:/customer/" + customer.getId() + "/edit";
        }
        
        if (customer.getPhoneNumber() == null || customer.getPhoneNumber().trim().isEmpty()) {
            model.addAttribute("error", "Số điện thoại không được để trống");
            model.addAttribute("customer", customer);
            return customer.getId() == null ? "customer/form" : "redirect:/customer/" + customer.getId() + "/edit";
        }
        
        // Kiểm tra số điện thoại đã tồn tại
        Customer existingByPhone = customerService.getCustomerByPhone(customer.getPhoneNumber());
        if (existingByPhone != null && (customer.getId() == null || !existingByPhone.getId().equals(customer.getId()))) {
            model.addAttribute("error", "Số điện thoại này đã được đăng ký");
            model.addAttribute("customer", customer);
            return customer.getId() == null ? "customer/form" : "redirect:/customer/" + customer.getId() + "/edit";
        }
        
        customer.setAcceptMarketing("true".equals(acceptMarketing));
        
        Long customerId = customerService.saveOrUpdateCustomer(customer);
        
        return "redirect:/customer/" + customerId + "?success=true";
    }

    // ===== QUẢN LÝ TUỲ CHỌN MARKETING =====
    /**
     * Cập nhật tuỳ chọn nhận marketing
     */
    @PostMapping("/{id}/update-marketing")
    public String updateMarketing(
            @PathVariable Long id,
            @RequestParam boolean accept) {
        
        customerService.updateMarketingPreference(id, accept);
        return "redirect:/customer/" + id;
    }

    /**
     * Lấy danh sách khách hàng đồng ý nhận marketing
     */
    @GetMapping("/marketing/list")
    public String listMarketingCustomers(Model model) {
        List<Customer> marketingCustomers = customerService.getMarketingCustomers();
        model.addAttribute("customers", marketingCustomers);
        model.addAttribute("pageTitle", "Danh sách khách hàng nhận marketing");
        return "customer/marketing-list";
    }

    // ===== QUẢN LÝ TRẠNG THÁI KHÁCH HÀNG =====
    /**
     * Cập nhật trạng thái khách hàng
     */
    @PostMapping("/{id}/update-status")
    public String updateStatus(
            @PathVariable Long id,
            @RequestParam String status) {
        
        if ("ACTIVE".equals(status) || "INACTIVE".equals(status) || "BLACKLIST".equals(status)) {
            customerService.updateCustomerStatus(id, status);
        }
        
        return "redirect:/customer/" + id;
    }

    // ===== LỰC SỬ DỊCH VỤ =====
    /**
     * Xem lịch sử dịch vụ chi tiết
     */
    @GetMapping("/{id}/service-history")
    public String viewServiceHistory(@PathVariable Long id, Model model) {
        Customer customer = customerService.getCustomerById(id);
        
        if (customer == null) {
            return "redirect:/customer?error=not_found";
        }
        
        List<Booking> serviceHistory = customerService.getCustomerServiceHistory(id);
        
        model.addAttribute("customer", customer);
        model.addAttribute("serviceHistory", serviceHistory);
        model.addAttribute("visitCount", serviceHistory.size());
        
        return "customer/service-history";
    }

    // ===== LIÊN KẾT BOOKING VỚI KHÁCH HÀNG =====
    /**
     * Form chọn/tạo khách hàng cho booking
     */
    @GetMapping("/select-for-booking")
    public String selectCustomerForBooking(
            @RequestParam(value = "search", required = false) String search,
            @RequestParam(value = "createNew", required = false) boolean createNew,
            Model model) {
        
        List<Customer> customers;
        
        if (search != null && !search.isEmpty()) {
            customers = customerService.searchCustomers(search);
        } else {
            customers = customerService.getAllActiveCustomers();
        }
        
        model.addAttribute("customers", customers);
        model.addAttribute("search", search);
        model.addAttribute("createNew", createNew);
        model.addAttribute("customer", new Customer());
        
        return "customer/select-for-booking";
    }

    /**
     * Thêm khách hàng từ booking
     */
    @PostMapping("/create-from-booking")
    public String createFromBooking(
            @ModelAttribute Customer customer,
            @RequestParam(value = "acceptMarketing", required = false, defaultValue = "false") String acceptMarketing) {
        
        customer.setAcceptMarketing("true".equals(acceptMarketing));
        Long customerId = customerService.saveOrUpdateCustomer(customer);
        
        return "redirect:/booking?customerId=" + customerId;
    }

    // ===== THỐNG KÊ KHÁCH HÀNG =====
    /**
     * Danh sách khách hàng chi tiêu cao nhất
     */
    @GetMapping("/top-spenders")
    public String topSpenders(Model model) {
        List<Customer> topCustomers = customerService.getTopSpendingCustomers(10);
        model.addAttribute("customers", topCustomers);
        model.addAttribute("pageTitle", "Khách hàng chi tiêu cao nhất");
        return "customer/top-spenders";
    }

    /**
     * Danh sách khách hàng mới
     */
    @GetMapping("/new-customers")
    public String newCustomers(
            @RequestParam(value = "days", defaultValue = "30") int days,
            Model model) {
        
        List<Customer> newCustomers = customerService.getNewCustomersInDays(days);
        model.addAttribute("customers", newCustomers);
        model.addAttribute("days", days);
        model.addAttribute("pageTitle", "Khách hàng mới trong " + days + " ngày");
        return "customer/new-customers";
    }

    // ===== XOÁ KHÁCH HÀNG =====
    /**
     * Xoá khách hàng
     */
    @PostMapping("/{id}/delete")
    public String deleteCustomer(@PathVariable Long id) {
        customerService.deleteCustomer(id);
        return "redirect:/customer?success=deleted";
    }
}
