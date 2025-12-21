package com.nailology.repository;

import com.nailology.entity.Booking;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.time.LocalTime;
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

    /**
     * Tìm các booking theo chi nhánh và ngày (để check slot đã đặt)
     */
    public List<Booking> findByLocationAndDate(Long locationId, LocalDate date) {
        String hql = "FROM Booking WHERE location.id = :locationId AND bookingDate = :date " +
                     "AND status NOT IN ('CANCELLED') ORDER BY bookingTime";
        Query<Booking> query = getCurrentSession().createQuery(hql, Booking.class);
        query.setParameter("locationId", locationId);
        query.setParameter("date", date);
        return query.getResultList();
    }

    /**
     * Kiểm tra xem slot có bị trùng không
     */
    public boolean isSlotBooked(Long locationId, LocalDate date, LocalTime time) {
        String hql = "SELECT COUNT(b) FROM Booking b WHERE b.location.id = :locationId " +
                     "AND b.bookingDate = :date AND b.bookingTime = :time " +
                     "AND b.status NOT IN ('CANCELLED')";
        Query<Long> query = getCurrentSession().createQuery(hql, Long.class);
        query.setParameter("locationId", locationId);
        query.setParameter("date", date);
        query.setParameter("time", time);
        return query.uniqueResult() > 0;
    }

    public void delete(Booking booking) {
        getCurrentSession().delete(booking);
    }

    public List<Booking> findByLocationIdsAndFilters(List<Long> locationIds, String status, String date) {
        StringBuilder hql = new StringBuilder("FROM Booking b WHERE b.location.id IN :locationIds");
        if (status != null && !status.isEmpty()) {
            hql.append(" AND b.status = :status");
        }
        if (date != null && !date.isEmpty()) {
            hql.append(" AND b.bookingDate = :date");
        }
        hql.append(" ORDER BY b.bookingDate DESC, b.bookingTime DESC");

        Query<Booking> query = getCurrentSession().createQuery(hql.toString(), Booking.class);
        query.setParameter("locationIds", locationIds);
        if (status != null && !status.isEmpty()) {
            query.setParameter("status", com.nailology.entity.Booking.BookingStatus.valueOf(status));
        }
        if (date != null && !date.isEmpty()) {
            query.setParameter("date", LocalDate.parse(date));
        }
        return query.getResultList();
    }

    public List<Booking> findByAssignedStaffId(Long staffId) {
        String hql = "FROM Booking WHERE assignedStaff.id = :staffId AND status IN ('CONFIRMED', 'PENDING') ORDER BY bookingDate, bookingTime";
        Query<Booking> query = getCurrentSession().createQuery(hql, Booking.class);
        query.setParameter("staffId", staffId);
        return query.getResultList();
    }
}
