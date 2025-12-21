package com.nailology.repository;

import com.nailology.entity.Announcement;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Repository
public class AnnouncementRepository {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    public List<Announcement> findAll() {
        Query<Announcement> query = getCurrentSession()
            .createQuery("FROM Announcement ORDER BY priority DESC, startDate DESC", Announcement.class);
        return query.getResultList();
    }

    public List<Announcement> findActive() {
        String hql = "FROM Announcement WHERE active = true " +
                     "AND (startDate IS NULL OR startDate <= :now) " +
                     "AND (endDate IS NULL OR endDate >= :now) " +
                     "ORDER BY priority DESC";
        Query<Announcement> query = getCurrentSession().createQuery(hql, Announcement.class);
        query.setParameter("now", new Date());
        return query.getResultList();
    }

    public Optional<Announcement> findById(Long id) {
        Announcement item = getCurrentSession().get(Announcement.class, id);
        return Optional.ofNullable(item);
    }

    public void save(Announcement item) {
        getCurrentSession().saveOrUpdate(item);
    }

    public void delete(Long id) {
        Announcement item = getCurrentSession().get(Announcement.class, id);
        if (item != null) {
            getCurrentSession().delete(item);
        }
    }
}
