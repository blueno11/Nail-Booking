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

    /**
     * Tìm lịch rảnh của nhân viên theo chi nhánh và ngày trong tuần
     */
    public List<StaffAvailability> findByLocationAndDayOfWeek(Long locationId, int dayOfWeek) {
        String hql = "SELECT sa FROM StaffAvailability sa " +
                     "JOIN sa.staff s " +
                     "JOIN s.locations loc " +
                     "WHERE loc.id = :locationId AND sa.dayOfWeek = :dayOfWeek " +
                     "AND s.status = 'ACTIVE' " +
                     "ORDER BY sa.startTime";
        return currentSession().createQuery(hql, StaffAvailability.class)
                .setParameter("locationId", locationId)
                .setParameter("dayOfWeek", dayOfWeek)
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