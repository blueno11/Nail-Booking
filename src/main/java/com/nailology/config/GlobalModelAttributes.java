package com.nailology.config;

import com.nailology.model.Announcement;
import com.nailology.service.AnnouncementService;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class GlobalModelAttributes {

    private final AnnouncementService announcementService;

    public GlobalModelAttributes(AnnouncementService announcementService) {
        this.announcementService = announcementService;
    }

    @ModelAttribute("announcement")
    public Announcement announcement() {
        return announcementService.getActiveAnnouncement().orElse(null);
    }
}

