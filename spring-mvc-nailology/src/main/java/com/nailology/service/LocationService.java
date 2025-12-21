package com.nailology.service;

import com.nailology.entity.Location;
import com.nailology.repository.LocationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class LocationService {

    @Autowired
    private LocationRepository locationRepository;

    @Transactional(readOnly = true)
    public List<Location> getAll() {
        return locationRepository.findAll();
    }

    @Transactional(readOnly = true)
    public List<Location> getAllActive() {
        return locationRepository.findAllActive();
    }

    @Transactional(readOnly = true)
    public Location getById(Long id) {
        return locationRepository.findById(id).orElse(null);
    }

    public void save(Location location) {
        locationRepository.save(location);
    }

    public void delete(Long id) {
        locationRepository.delete(id);
    }
}
