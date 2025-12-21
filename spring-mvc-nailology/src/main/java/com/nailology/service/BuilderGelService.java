package com.nailology.service;

import com.nailology.entity.Location;
import com.nailology.entity.ServiceEntity;
import com.nailology.repository.LocationRepository;
import com.nailology.repository.ServiceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@Service
@Transactional
public class BuilderGelService {

    @Autowired
    private ServiceRepository serviceRepository;

    @Autowired
    private LocationRepository locationRepository;

    /**
     * Lấy tất cả locations active
     */
    public List<Location> getAllActiveLocations() {
        return locationRepository.findAllActive();
    }

    /**
     * Lấy tất cả builder gel services
     */
    public List<ServiceEntity> getAllBuilderGelServices() {
        return serviceRepository.findAllBuilderGels();
    }

    /**
     * Lấy builder gel services theo location
     */
    public List<ServiceEntity> getBuilderGelServicesByLocation(Long locationId) {
        if (locationId == null) {
            return getAllBuilderGelServices();
        }
        return serviceRepository.findBuilderGelsByLocation(locationId);
    }

    /**
     * Group services theo category
     */
    public Map<String, List<ServiceEntity>> groupServicesByCategory(List<ServiceEntity> services) {
        return services.stream()
                .collect(Collectors.groupingBy(
                        service -> service.getCategoryLabel() != null ? 
                                   service.getCategoryLabel() : service.getCategory(),
                        LinkedHashMap::new,
                        Collectors.toList()
                ));
    }

    /**
     * Lấy builder gel services được group theo category cho location cụ thể
     */
    public Map<String, List<ServiceEntity>> getBuilderGelServicesByLocationGrouped(Long locationId) {
        List<ServiceEntity> services = getBuilderGelServicesByLocation(locationId);
        return groupServicesByCategory(services);
    }

    /**
     * Tìm location theo ID
     */
    public Location getLocationById(Long locationId) {
        return locationRepository.findById(locationId).orElse(null);
    }
}