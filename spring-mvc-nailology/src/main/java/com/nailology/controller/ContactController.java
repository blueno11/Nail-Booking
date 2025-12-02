package com.nailology.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/contact")
public class ContactController {

    @PostMapping("/submit")
    public String submitContact(
            @RequestParam String name,
            @RequestParam String email,
            @RequestParam String message) {
        // TODO: Process contact form submission
        return "redirect:/?contact=success";
    }
}

