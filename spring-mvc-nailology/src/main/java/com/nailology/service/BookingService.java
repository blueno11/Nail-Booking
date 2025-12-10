package com.nailology.service;

import com.nailology.entity.Booking;
import com.nailology.entity.Customer;
import com.nailology.entity.Location;
import com.nailology.entity.ServiceEntity;
import com.nailology.entity.Staff;
import com.nailology.model.BookingForm;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
@Transactional
public class BookingService {

    @Autowired
    private SessionFactory sessionFactory;

    public List<ServiceEntity> getAllServices() {
        Session session = sessionFactory.getCurrentSession();
        Query<ServiceEntity> q = session.createQuery("FROM ServiceEntity ORDER BY name", ServiceEntity.class);
        return q.getResultList();
    }

    public List<Staff> getAllStaffs() {
        Session session = sessionFactory.getCurrentSession();
        Query<Staff> q = session.createQuery("FROM Staff ORDER BY name", Staff.class);
        return q.getResultList();
    }

    public List<Location> getAllLocations() {
        Session session = sessionFactory.getCurrentSession();
        Query<Location> q = session.createQuery("FROM Location WHERE status = 'ACTIVE' ORDER BY name", Location.class);
        return q.getResultList();
    }

    public List<Booking> getAllBookings() {
        Session session = sessionFactory.getCurrentSession();
        Query<Booking> q = session.createQuery("FROM Booking ORDER BY bookingDateTime DESC", Booking.class);
        return q.getResultList();
    }

    public Booking getBookingById(Long id) {
        Session session = sessionFactory.getCurrentSession();
        return session.get(Booking.class, id);
    }

    public void saveBooking(BookingForm bookingForm, Long customerId) {
        Session session = sessionFactory.getCurrentSession();
        Booking booking = new Booking();

        // Parse date + time
        try {
            String date = bookingForm.getDate() != null ? bookingForm.getDate() : "";
            String time = bookingForm.getTime() != null ? bookingForm.getTime() : "00:00";
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            Date dt = sdf.parse(date + " " + time);
            booking.setBookingDateTime(dt);
        } catch (ParseException e) {
            // fallback to now
            booking.setBookingDateTime(new Date());
        }

        // Map services and calculate total
        List<ServiceEntity> services = new ArrayList<>();
        double total = 0.0;
        if (bookingForm.getSelectedServiceIds() != null) {
            for (Integer sid : bookingForm.getSelectedServiceIds()) {
                ServiceEntity se = session.get(ServiceEntity.class, sid.longValue());
                if (se != null) {
                    services.add(se);
                    BigDecimal p = se.getStartingPrice();
                    if (p != null) total += p.doubleValue();
                }
            }
        }
        booking.setServices(services);
        booking.setTotalAmount(total);

        // Staff
        if (bookingForm.getStaffId() != null) {
            Staff staff = session.get(Staff.class, bookingForm.getStaffId());
            booking.setStaff(staff);
        }

        // Location
        if (bookingForm.getLocationId() != null) {
            Location loc = session.get(Location.class, bookingForm.getLocationId());
            booking.setLocation(loc);
        }

        // Customer link if provided
        if (customerId != null) {
            Customer customer = session.get(Customer.class, customerId);
            if (customer != null) booking.setCustomer(customer);
        }

        // Save
        session.persist(booking);
        session.flush();
    }

    public void updateBooking(Long bookingId, BookingForm bookingForm) {
        Session session = sessionFactory.getCurrentSession();
        Booking booking = session.get(Booking.class, bookingId);
        if (booking == null) return;

        // update similar to save
        try {
            String date = bookingForm.getDate() != null ? bookingForm.getDate() : "";
            String time = bookingForm.getTime() != null ? bookingForm.getTime() : "00:00";
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            Date dt = sdf.parse(date + " " + time);
            booking.setBookingDateTime(dt);
        } catch (ParseException e) {
            // ignore
        }

        List<ServiceEntity> services = new ArrayList<>();
        double total = 0.0;
        if (bookingForm.getSelectedServiceIds() != null) {
            for (Integer sid : bookingForm.getSelectedServiceIds()) {
                ServiceEntity se = session.get(ServiceEntity.class, sid.longValue());
                if (se != null) {
                    services.add(se);
                    BigDecimal p = se.getStartingPrice();
                    if (p != null) total += p.doubleValue();
                }
            }
        }
        booking.setServices(services);
        booking.setTotalAmount(total);

        if (bookingForm.getStaffId() != null) {
            Staff staff = session.get(Staff.class, bookingForm.getStaffId());
            booking.setStaff(staff);
        }

        if (bookingForm.getLocationId() != null) {
            Location loc = session.get(Location.class, bookingForm.getLocationId());
            booking.setLocation(loc);
        }

        session.merge(booking);
    }

    public void cancelBooking(Long bookingId) {
        Session session = sessionFactory.getCurrentSession();
        Booking booking = session.get(Booking.class, bookingId);
        if (booking != null) {
            booking.setStatus("CANCELLED");
            session.merge(booking);
        }
    }
}

