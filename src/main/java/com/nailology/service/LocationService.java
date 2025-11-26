package com.nailology.service;

import com.nailology.model.Location;
import com.nailology.model.LocationStatus;
import com.nailology.repository.LocationRepository;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class LocationService {

    private final LocationRepository locationRepository;

    public LocationService(LocationRepository locationRepository) {
        this.locationRepository = locationRepository;
    }

    public List<Location> getActiveLocations() {
        return locationRepository.findByStatusOrderByDisplayOrderAsc(LocationStatus.ACTIVE);
    }
}

