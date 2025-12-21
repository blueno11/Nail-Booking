package com.nailology.controller;

import com.nailology.entity.ServiceEntity;
import com.nailology.service.LocationService;
import com.nailology.service.ServiceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin/services")
public class AdminServiceController {

    @Autowired
    private ServiceService serviceService;

    @Autowired
    private LocationService locationService;

    @GetMapping({"", "/"})
    @Transactional(readOnly = true)
    public String list(Model model) {
        model.addAttribute("serviceList", serviceService.getAll());
        return "admin/services/list";
    }

    @GetMapping("/edit")
    @Transactional(readOnly = true)
    public String edit(@RequestParam(required = false) Long id, Model model) {
        ServiceEntity service = (id == null || id == 0) ? new ServiceEntity() : serviceService.getById(id);
        model.addAttribute("service", service);
        model.addAttribute("locationList", locationService.getAll());
        return "admin/services/form";
    }

    @PostMapping("/save")
    public String save(ServiceEntity service, @RequestParam(required = false) List<Long> locationIds) {
        serviceService.save(service, locationIds);
        return "redirect:/admin/services";
    }

    @GetMapping("/delete")
    @Transactional
    public String delete(@RequestParam Long id) {
        serviceService.delete(id);
        return "redirect:/admin/services";
    }
}
