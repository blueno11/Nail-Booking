package com.nailology.repository;

import com.nailology.model.Announcement;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AnnouncementRepository extends JpaRepository<Announcement, Long> {

    Optional<Announcement> findTopByActiveTrueOrderByPriorityDesc();
}

