package com.nailology.controller;

import com.nailology.service.GalleryService;
import com.nailology.service.LocationService;
import com.nailology.service.ServiceOfferingService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    private final LocationService locationService;
    private final ServiceOfferingService serviceOfferingService;
    private final GalleryService galleryService;

    public HomeController(
            LocationService locationService,
            ServiceOfferingService serviceOfferingService,
            GalleryService galleryService) {
        this.locationService = locationService;
        this.serviceOfferingService = serviceOfferingService;
        this.galleryService = galleryService;
    }

    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("title", "Nailology - Tiệm Nails & Cà Phê Cao Cấp");
        model.addAttribute("description", "Trải nghiệm mới với nails & coffee culture - Chăm sóc bản thân, thư giãn tâm hồn");
        model.addAttribute("locations", locationService.getActiveLocations());
        model.addAttribute("featuredServices", serviceOfferingService.getFeaturedServices());
        model.addAttribute("galleryItems", galleryService.getFeaturedGalleryItems());
        return "index";
    }
}

