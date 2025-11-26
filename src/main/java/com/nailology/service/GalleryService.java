package com.nailology.service;

import com.nailology.model.GalleryItem;
import com.nailology.repository.GalleryItemRepository;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class GalleryService {

    private final GalleryItemRepository galleryItemRepository;

    public GalleryService(GalleryItemRepository galleryItemRepository) {
        this.galleryItemRepository = galleryItemRepository;
    }

    public List<GalleryItem> getFeaturedGalleryItems() {
        return galleryItemRepository.findTop9ByOrderByDisplayOrderAsc();
    }
}

