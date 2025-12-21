package com.nailology.controller;

import com.nailology.entity.Location;
import com.nailology.service.LocationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/locations")
public class AdminLocationController {

    @Autowired
    private LocationService locationService;

    @GetMapping({"", "/"})
    @Transactional(readOnly = true)
    public String list(Model model) {
        model.addAttribute("locationList", locationService.getAll());
        return "admin/locations/list";
    }

    @GetMapping("/edit")
    @Transactional(readOnly = true)
    public String edit(@RequestParam(required = false) Long id, Model model) {
        Location location = (id == null || id == 0) ? new Location() : locationService.getById(id);
        model.addAttribute("location", location);
        return "admin/locations/form";
    }

    @PostMapping("/save")
    public String save(Location location) {
        locationService.save(location);
        return "redirect:/admin/locations";
    }

    @GetMapping("/delete")
    @Transactional
    public String delete(@RequestParam Long id) {
        locationService.delete(id);
        return "redirect:/admin/locations";
    }
}
