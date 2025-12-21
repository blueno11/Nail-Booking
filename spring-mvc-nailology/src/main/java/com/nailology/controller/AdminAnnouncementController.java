package com.nailology.controller;

import com.nailology.entity.Announcement;
import com.nailology.service.AnnouncementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
@RequestMapping("/admin/announcements")
public class AdminAnnouncementController {

    @Autowired
    private AnnouncementService announcementService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    @GetMapping({"", "/"})
    @Transactional(readOnly = true)
    public String list(Model model) {
        model.addAttribute("announcementList", announcementService.getAll());
        return "admin/announcements/list";
    }

    @GetMapping("/edit")
    @Transactional(readOnly = true)
    public String edit(@RequestParam(required = false) Long id, Model model) {
        Announcement item = (id == null || id == 0) ? new Announcement() : announcementService.getById(id);
        model.addAttribute("announcement", item);
        return "admin/announcements/form";
    }

    @PostMapping("/save")
    public String save(Announcement item) {
        announcementService.save(item);
        return "redirect:/admin/announcements";
    }

    @GetMapping("/delete")
    @Transactional
    public String delete(@RequestParam Long id) {
        announcementService.delete(id);
        return "redirect:/admin/announcements";
    }
}
