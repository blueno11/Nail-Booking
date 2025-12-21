package com.nailology.service;

import com.nailology.entity.Announcement;
import com.nailology.repository.AnnouncementRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class AnnouncementService {

    @Autowired
    private AnnouncementRepository announcementRepository;

    @Transactional(readOnly = true)
    public List<Announcement> getAll() {
        return announcementRepository.findAll();
    }

    @Transactional(readOnly = true)
    public List<Announcement> getActive() {
        return announcementRepository.findActive();
    }

    @Transactional(readOnly = true)
    public Announcement getById(Long id) {
        return announcementRepository.findById(id).orElse(null);
    }

    public void save(Announcement item) {
        announcementRepository.save(item);
    }

    public void delete(Long id) {
        announcementRepository.delete(id);
    }
}
