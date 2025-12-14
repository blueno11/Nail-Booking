package com.nailology.repository;

import com.nailology.entity.Booking;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class BookingRepository {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    public Booking save(Booking booking) {
        getCurrentSession().saveOrUpdate(booking);
        return booking;
    }

    public Optional<Booking> findById(Long id) {
        Booking booking = getCurrentSession().get(Booking.class, id);
        return Optional.ofNullable(booking);
    }

    public Optional<Booking> findByBookingCode(String bookingCode) {
        Query<Booking> query = getCurrentSession()
            .createQuery("FROM Booking WHERE bookingCode = :code", Booking.class);
        query.setParameter("code", bookingCode);
        return query.uniqueResultOptional();
    }

    public List<Booking> findByEmail(String email) {
        Query<Booking> query = getCurrentSession()
            .createQuery("FROM Booking WHERE email = :email ORDER BY bookingDate DESC, bookingTime DESC", Booking.class);
        query.setParameter("email", email);
        return query.getResultList();
    }

    public List<Booking> findByEmailAndPhone(String email, String phone) {
        Query<Booking> query = getCurrentSession()
            .createQuery("FROM Booking WHERE email = :email AND phone = :phone ORDER BY bookingDate DESC", Booking.class);
        query.setParameter("email", email);
        query.setParameter("phone", phone);
        return query.getResultList();
    }

    public void delete(Booking booking) {
        getCurrentSession().delete(booking);
    }
}
