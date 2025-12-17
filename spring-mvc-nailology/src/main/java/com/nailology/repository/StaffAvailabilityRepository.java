package com.nailology.repository;

import com.nailology.entity.StaffAvailability;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;

import javax.transaction.Transactional;

@Repository
public class StaffAvailabilityRepository {

    @Autowired
    private SessionFactory sessionFactory;

    private Session currentSession() {
        return sessionFactory.getCurrentSession();
    }

    public List<StaffAvailability> findByStaffId(Long staffId) {
        return currentSession().createQuery("FROM StaffAvailability WHERE staff.id = :staffId ORDER BY dayOfWeek", StaffAvailability.class)
                .setParameter("staffId", staffId)
                .list();
    }

    public StaffAvailability findById(Long id) {
        return currentSession().get(StaffAvailability.class, id);
    }

    public void save(StaffAvailability availability) {
        currentSession().saveOrUpdate(availability);
    }

    @Transactional
    public void delete(Long id) {
        StaffAvailability avail = findById(id);
        if (avail != null) {
            currentSession().delete(avail);
        }
    }
}