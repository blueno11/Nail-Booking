package com.nailology.service;

import com.nailology.entity.StaffAvailability;
import com.nailology.repository.StaffAvailabilityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;  // ← Thêm import

import java.util.List;

@Service
@Transactional  // ← Thêm dòng này
public class StaffAvailabilityService {

    @Autowired
    private StaffAvailabilityRepository repository;

    public List<StaffAvailability> getByStaffId(Long staffId) {
        return repository.findByStaffId(staffId);
    }

    public StaffAvailability save(StaffAvailability availability) {
        repository.save(availability);
        return availability;
    }

    public void delete(Long id) {
        repository.delete(id);
    }
}