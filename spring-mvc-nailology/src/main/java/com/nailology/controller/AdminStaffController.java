package com.nailology.controller;

import com.nailology.entity.Staff;
import com.nailology.entity.StaffAvailability;
import com.nailology.service.LocationService;
import com.nailology.service.StaffAvailabilityService;
import com.nailology.service.StaffService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin/staff")
public class AdminStaffController {

    @Autowired
    private StaffService staffService;

    @Autowired
    private StaffAvailabilityService availabilityService;

    @Autowired
    private LocationService locationService;

    // === DANH SÁCH NHÂN VIÊN ===
    @GetMapping({"", "/"})
    @Transactional(readOnly = true)
    public String list(Model model) {
        model.addAttribute("staffList", staffService.getAllStaff());
        return "admin/staff/list";
    }

    // === FORM THÊM / SỬA NHÂN VIÊN ===
    @GetMapping("/edit")
    @Transactional(readOnly = true)
    public String edit(@RequestParam(required = false) Long id, Model model) {
        Staff staff = (id == null || id == 0) ? new Staff() : staffService.getById(id);
        model.addAttribute("staff", staff);
        model.addAttribute("locationList", locationService.getAll());
        return "admin/staff/form";
    }

    // === QUẢN LÝ LỊCH RẢNH ===
    @GetMapping("/{staffId}/availability")
    @Transactional(readOnly = true)
    public String availability(@PathVariable Long staffId, Model model) {
        model.addAttribute("staff", staffService.getById(staffId));
        model.addAttribute("availList", availabilityService.getByStaffId(staffId));
        return "admin/staff/availability";
    }

    // === LƯU NHÂN VIÊN ===
    @PostMapping("/save")
    public String save(Staff staff, @RequestParam(required = false) List<Long> locationIds) {
        staffService.save(staff, locationIds);
        return "redirect:/admin/staff";
    }

    // === XÓA NHÂN VIÊN ===
    @GetMapping("/delete")
    @Transactional
    public String delete(@RequestParam Long id) {
        staffService.delete(id);
        return "redirect:/admin/staff";
    }

    // === LƯU CA LÀM VIỆC ===
    @PostMapping("/availability/save")
    public String saveAvailability(StaffAvailability availability, @RequestParam Long staffId) {
        availability.setStaff(staffService.getById(staffId));
        availabilityService.save(availability);
        return "redirect:/admin/staff/" + staffId + "/availability";
    }

    // === XÓA CA LÀM VIỆC ===
    @GetMapping("/availability/delete")
    @Transactional
    public String deleteAvailability(@RequestParam Long id, @RequestParam Long staffId) {
        availabilityService.delete(id);
        return "redirect:/admin/staff/" + staffId + "/availability";
    }
}