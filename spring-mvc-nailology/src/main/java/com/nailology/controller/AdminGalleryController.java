package com.nailology.controller;

import com.nailology.entity.GalleryItem;
import com.nailology.service.GalleryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/gallery")
public class AdminGalleryController {

    @Autowired
    private GalleryService galleryService;

    @GetMapping({"", "/"})
    @Transactional(readOnly = true)
    public String list(Model model) {
        model.addAttribute("galleryList", galleryService.getAll());
        return "admin/gallery/list";
    }

    @GetMapping("/edit")
    @Transactional(readOnly = true)
    public String edit(@RequestParam(required = false) Long id, Model model) {
        GalleryItem item = (id == null || id == 0) ? new GalleryItem() : galleryService.getById(id);
        model.addAttribute("gallery", item);
        return "admin/gallery/form";
    }

    @PostMapping("/save")
    public String save(GalleryItem item) {
        galleryService.save(item);
        return "redirect:/admin/gallery";
    }

    @GetMapping("/delete")
    @Transactional
    public String delete(@RequestParam Long id) {
        galleryService.delete(id);
        return "redirect:/admin/gallery";
    }
}
