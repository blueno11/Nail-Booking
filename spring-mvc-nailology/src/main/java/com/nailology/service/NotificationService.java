package com.nailology.service;

import com.nailology.entity.Booking;
import com.nailology.entity.Notification;
import com.nailology.entity.Staff;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
@Transactional
public class NotificationService {

    @Autowired
    private SessionFactory sessionFactory;

    @Autowired
    private StaffService staffService;

    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    /**
     * Tạo thông báo cho tất cả nhân viên tại chi nhánh khi có booking mới
     */
    public void notifyNewBooking(Booking booking) {
        if (booking.getLocation() == null) return;

        List<Staff> staffAtLocation = staffService.getActiveStaffByLocation(booking.getLocation().getId());
        
        String title = "Lịch hẹn mới #" + booking.getBookingCode();
        String message = String.format(
            "Khách: %s\nDịch vụ: %s\nNgày: %s lúc %s\nSĐT: %s",
            booking.getCustomerName(),
            booking.getServiceNames(),
            booking.getBookingDate(),
            booking.getBookingTime(),
            booking.getPhone()
        );

        for (Staff staff : staffAtLocation) {
            Notification notification = new Notification(staff, title, message, "NEW_BOOKING");
            notification.setReferenceId(booking.getId());
            notification.setReferenceType("BOOKING");
            getCurrentSession().save(notification);
        }
    }

    /**
     * Thông báo khi booking bị hủy
     */
    public void notifyBookingCancelled(Booking booking) {
        if (booking.getLocation() == null) return;

        List<Staff> staffAtLocation = staffService.getActiveStaffByLocation(booking.getLocation().getId());
        
        // Nếu có nhân viên được gán, chỉ thông báo cho người đó
        if (booking.getAssignedStaff() != null) {
            staffAtLocation.clear();
            staffAtLocation.add(booking.getAssignedStaff());
        }

        String title = "Lịch hẹn đã hủy #" + booking.getBookingCode();
        String message = String.format(
            "Khách %s đã hủy lịch hẹn ngày %s lúc %s",
            booking.getCustomerName(),
            booking.getBookingDate(),
            booking.getBookingTime()
        );

        for (Staff staff : staffAtLocation) {
            Notification notification = new Notification(staff, title, message, "BOOKING_CANCELLED");
            notification.setReferenceId(booking.getId());
            notification.setReferenceType("BOOKING");
            getCurrentSession().save(notification);
        }
    }

    /**
     * Thông báo khi được gán booking
     */
    public void notifyBookingAssigned(Booking booking, Staff assignedStaff) {
        String title = "Bạn được gán lịch hẹn #" + booking.getBookingCode();
        String message = String.format(
            "Khách: %s\nDịch vụ: %s\nNgày: %s lúc %s",
            booking.getCustomerName(),
            booking.getServiceNames(),
            booking.getBookingDate(),
            booking.getBookingTime()
        );

        Notification notification = new Notification(assignedStaff, title, message, "BOOKING_ASSIGNED");
        notification.setReferenceId(booking.getId());
        notification.setReferenceType("BOOKING");
        getCurrentSession().save(notification);
    }

    /**
     * Lấy thông báo của nhân viên
     */
    @Transactional(readOnly = true)
    public List<Notification> getNotificationsForStaff(Long staffId, boolean unreadOnly) {
        String hql = "FROM Notification WHERE staff.id = :staffId";
        if (unreadOnly) {
            hql += " AND isRead = false";
        }
        hql += " ORDER BY createdAt DESC";

        Query<Notification> query = getCurrentSession().createQuery(hql, Notification.class);
        query.setParameter("staffId", staffId);
        query.setMaxResults(50);
        return query.getResultList();
    }

    /**
     * Đếm số thông báo chưa đọc
     */
    @Transactional(readOnly = true)
    public long countUnreadNotifications(Long staffId) {
        Query<Long> query = getCurrentSession().createQuery(
            "SELECT COUNT(n) FROM Notification n WHERE n.staff.id = :staffId AND n.isRead = false",
            Long.class
        );
        query.setParameter("staffId", staffId);
        return query.uniqueResult();
    }

    /**
     * Đánh dấu đã đọc
     */
    public void markAsRead(Long notificationId) {
        Notification notification = getCurrentSession().get(Notification.class, notificationId);
        if (notification != null) {
            notification.setIsRead(true);
            notification.setReadAt(LocalDateTime.now());
            getCurrentSession().update(notification);
        }
    }

    /**
     * Đánh dấu tất cả đã đọc
     */
    public void markAllAsRead(Long staffId) {
        getCurrentSession().createQuery(
            "UPDATE Notification SET isRead = true, readAt = :now WHERE staff.id = :staffId AND isRead = false"
        )
        .setParameter("now", LocalDateTime.now())
        .setParameter("staffId", staffId)
        .executeUpdate();
    }
}
