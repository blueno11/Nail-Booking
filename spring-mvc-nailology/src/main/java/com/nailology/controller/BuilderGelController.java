package com.nailology.controller;

import com.nailology.entity.Location;
import com.nailology.entity.ServiceEntity;
import com.nailology.service.BuilderGelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/builder-gels")
public class BuilderGelController {

    @Autowired
    private BuilderGelService builderGelService;

    /**
     * Hiển thị trang Builder Gels Menu
     * Có thể filter theo location
     */
    @GetMapping
    public String showBuilderGelMenu(
            @RequestParam(value = "locationId", required = false) Long locationId,
            Model model) {

        // Lấy tất cả locations
        List<Location> locations = builderGelService.getAllActiveLocations();
        model.addAttribute("locations", locations);

        // Lấy location được chọn (nếu có)
        Location selectedLocation = null;
        if (locationId != null) {
            selectedLocation = builderGelService.getLocationById(locationId);
        }
        model.addAttribute("selectedLocation", selectedLocation);
        model.addAttribute("selectedLocationId", locationId);

        // Lấy builder gel services (có thể filter theo location)
        Map<String, List<ServiceEntity>> servicesByCategory = 
                builderGelService.getBuilderGelServicesByLocationGrouped(locationId);
        
        model.addAttribute("servicesByCategory", servicesByCategory);

        // Đếm tổng số services
        int totalServices = servicesByCategory.values().stream()
                .mapToInt(List::size)
                .sum();
        model.addAttribute("totalServices", totalServices);

        return "builder-gels/menu";
    }
}