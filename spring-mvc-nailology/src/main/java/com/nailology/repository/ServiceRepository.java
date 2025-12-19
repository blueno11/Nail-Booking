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
   
    public List<ServiceEntity> findAllBuilderGels() {
       Query<ServiceEntity> query = getCurrentSession()
           .createQuery("FROM ServiceEntity WHERE isBuilderGel = true ORDER BY displayOrder", 
                       ServiceEntity.class);
       return query.getResultList();
   }
   
   /**
    * Lấy builder gel services theo location
    */
   public List<ServiceEntity> findBuilderGelsByLocation(Long locationId) {
       String hql = "SELECT DISTINCT s FROM ServiceEntity s " +
                    "JOIN s.locations l " +
                    "WHERE s.isBuilderGel = true AND l.id = :locationId " +
                    "ORDER BY s.displayOrder";
       
       Query<ServiceEntity> query = getCurrentSession()
           .createQuery(hql, ServiceEntity.class);
       query.setParameter("locationId", locationId);
       
       return query.getResultList();
   }
   
   /**
    * Lấy tất cả builder gel services với locations (eager fetch để tránh N+1)
    */
   public List<ServiceEntity> findAllBuilderGelsWithLocations() {
       String hql = "SELECT DISTINCT s FROM ServiceEntity s " +
                    "LEFT JOIN FETCH s.locations " +
                    "WHERE s.isBuilderGel = true " +
                    "ORDER BY s.displayOrder";
       
       Query<ServiceEntity> query = getCurrentSession()
           .createQuery(hql, ServiceEntity.class);
       
       return query.getResultList();
   }
}
