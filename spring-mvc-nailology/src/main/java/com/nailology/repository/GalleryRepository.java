package com.nailology.repository;

import com.nailology.entity.GalleryItem;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class GalleryRepository {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    public List<GalleryItem> findAll() {
        Query<GalleryItem> query = getCurrentSession()
            .createQuery("FROM GalleryItem ORDER BY displayOrder", GalleryItem.class);
        return query.getResultList();
    }

    public List<GalleryItem> findByType(String type) {
        Query<GalleryItem> query = getCurrentSession()
            .createQuery("FROM GalleryItem WHERE type = :type ORDER BY displayOrder", GalleryItem.class);
        query.setParameter("type", type);
        return query.getResultList();
    }

    public Optional<GalleryItem> findById(Long id) {
        GalleryItem item = getCurrentSession().get(GalleryItem.class, id);
        return Optional.ofNullable(item);
    }

    public void save(GalleryItem item) {
        getCurrentSession().saveOrUpdate(item);
    }

    public void delete(Long id) {
        GalleryItem item = getCurrentSession().get(GalleryItem.class, id);
        if (item != null) {
            getCurrentSession().delete(item);
        }
    }
}
