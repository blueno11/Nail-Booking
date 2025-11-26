package com.nailology.repository;

import com.nailology.model.Location;
import com.nailology.model.LocationStatus;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LocationRepository extends JpaRepository<Location, Long> {

    List<Location> findByStatusOrderByDisplayOrderAsc(LocationStatus status);
}

