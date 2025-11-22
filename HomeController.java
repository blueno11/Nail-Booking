package com.nailology.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("title", "Nailology - Tiệm Nails & Cà Phê Cao Cấp");
        model.addAttribute("description", "Trải nghiệm mới với nails & coffee culture - Chăm sóc bản thân, thư giãn tâm hồn");
        return "index";
    }
}

