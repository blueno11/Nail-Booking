package com.nailology.repository;

import com.nailology.model.GalleryItem;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface GalleryItemRepository extends JpaRepository<GalleryItem, Long> {

    List<GalleryItem> findTop9ByOrderByDisplayOrderAsc();
}

