package com.nailology.controller;

import com.nailology.entity.Staff;
import com.nailology.service.NotificationService;
import com.nailology.service.StaffService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/staff")
public class StaffAuthController {

    @Autowired
    private StaffService staffService;

    @Autowired
    private NotificationService notificationService;

    /**
     * Trang đăng nhập staff
     */
    @GetMapping("/login")
    public String loginPage(
            @RequestParam(required = false) String redirect,
            @RequestParam(required = false) String error,
            Model model,
            HttpSession session) {
        
        // Nếu đã đăng nhập rồi thì redirect
        if (session.getAttribute("staffId") != null) {
            return "redirect:/staff/dashboard";
        }
        
        model.addAttribute("redirect", redirect);
        if ("invalid".equals(error)) {
            model.addAttribute("error", "Email hoặc mật khẩu không đúng");
        } else if ("inactive".equals(error)) {
            model.addAttribute("error", "Tài khoản đã bị vô hiệu hóa");
        }
        
        return "staff/login";
    }

    /**
     * Xử lý đăng nhập
     */
    @PostMapping("/login")
    public String doLogin(
            @RequestParam String email,
            @RequestParam(required = false) String password,
            @RequestParam(required = false) String redirect,
            HttpSession session,
            Model model) {
        
        // Tìm staff theo email
        Staff staff = staffService.getByEmail(email);
        
        if (staff == null) {
            model.addAttribute("error", "Email không tồn tại trong hệ thống");
            return "staff/login";
        }
        
        if (!"ACTIVE".equals(staff.getStatus())) {
            model.addAttribute("error", "Tài khoản đã bị vô hiệu hóa");
            return "staff/login";
        }
        
        // Kiểm tra password (nếu có set password)
        if (staff.getPassword() != null && !staff.getPassword().isEmpty()) {
            if (password == null || !staff.getPassword().equals(password)) {
                model.addAttribute("error", "Mật khẩu không đúng");
                return "staff/login";
            }
        }
        // Nếu chưa set password thì cho đăng nhập luôn (lần đầu)
        
        // Lưu thông tin vào session
        session.setAttribute("staffId", staff.getId());
        session.setAttribute("staffName", staff.getName());
        session.setAttribute("staffEmail", staff.getEmail());
        // Lấy role từ database
        String role = staff.getRole() != null ? staff.getRole() : "STAFF";
        session.setAttribute("staffRole", role);
        
        // Redirect về trang yêu cầu hoặc dashboard
        if (redirect != null && !redirect.isEmpty() && !redirect.contains("login")) {
            return "redirect:" + redirect;
        }
        return "redirect:/staff/dashboard";
    }

    /**
     * Đăng xuất
     */
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/staff/login?logout=true";
    }

    /**
     * Dashboard staff
     */
    @GetMapping("/dashboard")
    public String dashboard(
            @RequestParam(required = false) String error,
            Model model,
            HttpSession session) {
        
        Long staffId = (Long) session.getAttribute("staffId");
        model.addAttribute("staffName", session.getAttribute("staffName"));
        model.addAttribute("staffRole", session.getAttribute("staffRole"));
        
        // Load số thông báo chưa đọc
        if (staffId != null) {
            long unreadCount = notificationService.countUnreadNotifications(staffId);
            model.addAttribute("unreadNotifications", unreadCount);
        }
        
        if ("access_denied".equals(error)) {
            model.addAttribute("error", "Bạn không có quyền truy cập chức năng này");
        }
        
        return "staff/dashboard";
    }
}
