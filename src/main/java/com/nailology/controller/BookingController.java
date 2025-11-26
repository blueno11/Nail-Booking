package com.nailology.controller;

import com.nailology.model.ServiceCategory;
import com.nailology.service.ServiceOfferingService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BookingController {

    private final ServiceOfferingService serviceOfferingService;

    public BookingController(ServiceOfferingService serviceOfferingService) {
        this.serviceOfferingService = serviceOfferingService;
    }

    @GetMapping("/booking")
    public String booking(Model model) {
        model.addAttribute("title", "Đặt Lịch Hẹn - Nailology");
        model.addAttribute("handServices", serviceOfferingService.getByCategory(ServiceCategory.HANDS));
        model.addAttribute("nailArtServices", serviceOfferingService.getByCategory(ServiceCategory.NAIL_ART));
        model.addAttribute("feetServices", serviceOfferingService.getByCategory(ServiceCategory.FEET));
        return "booking";
    }
}

