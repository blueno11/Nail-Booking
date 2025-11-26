package com.nailology.service;

import com.nailology.model.ServiceCategory;
import com.nailology.model.ServiceOffering;
import com.nailology.repository.ServiceOfferingRepository;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class ServiceOfferingService {

    private final ServiceOfferingRepository repository;

    public ServiceOfferingService(ServiceOfferingRepository repository) {
        this.repository = repository;
    }

    public List<ServiceOffering> getFeaturedServices() {
        return repository.findByHomepageFeaturedTrueOrderByDisplayOrderAsc();
    }

    public List<ServiceOffering> getByCategory(ServiceCategory category) {
        return repository.findByCategoryOrderByDisplayOrderAsc(category);
    }
}

