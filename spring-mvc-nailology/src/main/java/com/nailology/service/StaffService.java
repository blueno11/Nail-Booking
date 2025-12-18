package com.nailology.service;

import com.nailology.entity.Staff;
import com.nailology.repository.StaffRepository;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class StaffService {

    @Autowired
    private StaffRepository staffRepository;

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

    // === FIX CUỐI CÙNG: SỬA NHÂN VIÊN THÀNH CÔNG + UPDATE DB ===
    public Staff save(Staff staff) {
        if (staff.getId() == null) {
            staffRepository.save(staff);
            return staff;
        }

        Staff existing = staffRepository.findById(staff.getId());
        if (existing != null) {
            existing.setName(staff.getName());
            existing.setPhone(staff.getPhone());
            existing.setEmail(staff.getEmail());
            existing.setStatus(staff.getStatus());
            existing.setDisplayOrder(staff.getDisplayOrder());

            staffRepository.save(existing); // ← Bắt buộc save(existing) để generate UPDATE

            return existing;
        }

        return staff;
    }

    public void delete(Long id) {
        staffRepository.delete(id);
    }
}