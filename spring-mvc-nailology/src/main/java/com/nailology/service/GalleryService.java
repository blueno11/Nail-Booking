package com.nailology.service;

import com.nailology.entity.GalleryItem;
import com.nailology.repository.GalleryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class GalleryService {

    @Autowired
    private GalleryRepository galleryRepository;

    @Transactional(readOnly = true)
    public List<GalleryItem> getAll() {
        return galleryRepository.findAll();
    }

    @Transactional(readOnly = true)
    public List<GalleryItem> getByType(String type) {
        return galleryRepository.findByType(type);
    }

    @Transactional(readOnly = true)
    public GalleryItem getById(Long id) {
        return galleryRepository.findById(id).orElse(null);
    }

    public void save(GalleryItem item) {
        galleryRepository.save(item);
    }

    public void delete(Long id) {
        galleryRepository.delete(id);
    }
}
