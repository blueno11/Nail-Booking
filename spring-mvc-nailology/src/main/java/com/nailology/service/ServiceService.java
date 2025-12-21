package com.nailology.service;

import com.nailology.entity.Location;
import com.nailology.entity.ServiceEntity;
import com.nailology.repository.LocationRepository;
import com.nailology.repository.ServiceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
@Transactional
public class ServiceService {

    @Autowired
    private ServiceRepository serviceRepository;

    @Autowired
    private LocationRepository locationRepository;

    @Transactional(readOnly = true)
    public List<ServiceEntity> getAll() {
        return serviceRepository.findAll();
    }

    @Transactional(readOnly = true)
    public ServiceEntity getById(Long id) {
        return serviceRepository.findById(id).orElse(null);
    }

    public void save(ServiceEntity service, List<Long> locationIds) {
        if (locationIds != null && !locationIds.isEmpty()) {
            Set<Location> locations = new HashSet<>();
            for (Long locId : locationIds) {
                locationRepository.findById(locId).ifPresent(locations::add);
            }
            service.setLocations(locations);
        } else {
            service.setLocations(new HashSet<>());
        }
        serviceRepository.save(service);
    }

    public void delete(Long id) {
        serviceRepository.delete(id);
    }
}
