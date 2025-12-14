package com.nailology.repository;

import com.nailology.entity.ServiceEntity;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class ServiceRepository {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    public List<ServiceEntity> findAll() {
        Query<ServiceEntity> query = getCurrentSession()
            .createQuery("FROM ServiceEntity ORDER BY displayOrder", ServiceEntity.class);
        return query.getResultList();
    }

    public Optional<ServiceEntity> findById(Long id) {
        ServiceEntity service = getCurrentSession().get(ServiceEntity.class, id);
        return Optional.ofNullable(service);
    }

    public List<ServiceEntity> findByIds(List<Long> ids) {
        if (ids == null || ids.isEmpty()) {
            return List.of();
        }
        Query<ServiceEntity> query = getCurrentSession()
            .createQuery("FROM ServiceEntity WHERE id IN :ids", ServiceEntity.class);
        query.setParameter("ids", ids);
        return query.getResultList();
    }
}
