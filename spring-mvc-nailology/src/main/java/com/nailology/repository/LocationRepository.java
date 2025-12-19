package com.nailology.repository;

import com.nailology.entity.Location;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class LocationRepository {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    public List<Location> findAllActive() {
        Query<Location> query = getCurrentSession()
            .createQuery("FROM Location WHERE status = 'ACTIVE' ORDER BY displayOrder", Location.class);
        return query.getResultList();
    }

    public Optional<Location> findById(Long id) {
        Location location = getCurrentSession().get(Location.class, id);
        return Optional.ofNullable(location);
    }
    
}
