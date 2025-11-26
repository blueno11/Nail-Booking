package com.nailology.service;

import com.nailology.model.Announcement;
import com.nailology.repository.AnnouncementRepository;
import java.util.Optional;
import org.springframework.stereotype.Service;

@Service
public class AnnouncementService {

    private final AnnouncementRepository announcementRepository;

    public AnnouncementService(AnnouncementRepository announcementRepository) {
        this.announcementRepository = announcementRepository;
    }

    public Optional<Announcement> getActiveAnnouncement() {
        return announcementRepository.findTopByActiveTrueOrderByPriorityDesc();
    }
}

