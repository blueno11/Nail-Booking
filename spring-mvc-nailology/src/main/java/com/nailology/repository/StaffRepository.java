package com.nailology.repository;

import com.nailology.entity.Staff;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;

import javax.transaction.Transactional;

@Repository
public class StaffRepository {

    @Autowired
    private SessionFactory sessionFactory;

    private Session currentSession() {
        return sessionFactory.getCurrentSession();
    }

    public List<Staff> findAll() {
        return currentSession().createQuery("FROM Staff", Staff.class).list();
    }

    public List<Staff> findActiveByLocation(Long locationId) {
        return currentSession().createQuery(
                "SELECT s FROM Staff s JOIN s.locations l WHERE l.id = :locId AND s.status = 'ACTIVE' ORDER BY s.displayOrder",
                Staff.class)
                .setParameter("locId", locationId)
                .list();
    }

    public List<Staff> findActive() {
        return currentSession().createQuery("FROM Staff WHERE status = 'ACTIVE' ORDER BY displayOrder", Staff.class).list();
    }

    public Staff findById(Long id) {
        return currentSession().get(Staff.class, id);
    }

    public Staff findByEmail(String email) {
        List<Staff> results = currentSession()
            .createQuery("FROM Staff WHERE email = :email", Staff.class)
            .setParameter("email", email)
            .list();
        return results.isEmpty() ? null : results.get(0);
    }

    public void save(Staff staff) {
        currentSession().saveOrUpdate(staff);
    }

    @Transactional
    public void delete(Long id) {
        Staff staff = findById(id);
        if (staff != null) {
            currentSession().delete(staff);
        }
    }
}