package com.nailology.service;

import com.nailology.entity.Location;
import com.nailology.entity.Staff;
import com.nailology.repository.LocationRepository;
import com.nailology.repository.StaffRepository;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
@Transactional
public class StaffService {

    @Autowired
    private StaffRepository staffRepository;

    @Autowired
    private LocationRepository locationRepository;

    public List<Staff> getAllStaff() {
        List<Staff> list = staffRepository.findAll();
        for (Staff staff : list) {
            Hibernate.initialize(staff.getLocations());
        }
        return list;
    }

    public List<Staff> getActiveStaff() {
        return staffRepository.findActive();
    }

    public List<Staff> getActiveStaffByLocation(Long locationId) {
        return staffRepository.findActiveByLocation(locationId);
    }

    public Staff getById(Long id) {
        Staff staff = staffRepository.findById(id);
        if (staff != null) {
            Hibernate.initialize(staff.getLocations());
        }
        return staff;
    }

    public Staff getByEmail(String email) {
        return staffRepository.findByEmail(email);
    }

    public Staff save(Staff staff, List<Long> locationIds) {
        // Xử lý locations
        Set<Location> locations = new HashSet<>();
        if (locationIds != null && !locationIds.isEmpty()) {
            for (Long locId : locationIds) {
                locationRepository.findById(locId).ifPresent(locations::add);
            }
        }

        if (staff.getId() == null) {
            staff.setLocations(locations);
            staffRepository.save(staff);
            return staff;
        }

        Staff existing = staffRepository.findById(staff.getId());
        if (existing != null) {
            existing.setName(staff.getName());
            existing.setPhone(staff.getPhone());
            existing.setEmail(staff.getEmail());
            existing.setStatus(staff.getStatus());
            existing.setRole(staff.getRole());
            existing.setDisplayOrder(staff.getDisplayOrder());
            // Chỉ cập nhật password nếu có nhập mới
            if (staff.getPassword() != null && !staff.getPassword().trim().isEmpty()) {
                existing.setPassword(staff.getPassword());
            }
            existing.getLocations().clear();
            existing.getLocations().addAll(locations);
            staffRepository.save(existing);
            return existing;
        }

        return staff;
    }

    // Backward compatibility
    public Staff save(Staff staff) {
        return save(staff, null);
    }

    public void delete(Long id) {
        staffRepository.delete(id);
    }
}