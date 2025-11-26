package com.nailology.repository;

import com.nailology.model.ServiceCategory;
import com.nailology.model.ServiceOffering;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ServiceOfferingRepository extends JpaRepository<ServiceOffering, Long> {

    List<ServiceOffering> findByHomepageFeaturedTrueOrderByDisplayOrderAsc();

    List<ServiceOffering> findByCategoryOrderByDisplayOrderAsc(ServiceCategory category);
}

