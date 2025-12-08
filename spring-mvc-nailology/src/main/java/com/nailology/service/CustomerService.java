package com.nailology.service;

import com.nailology.entity.Booking;
import com.nailology.entity.Customer;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
@Transactional
public class CustomerService {

    @Autowired
    private SessionFactory sessionFactory;

    /**
     * Lưu hoặc cập nhật khách hàng
     */
    public Long saveOrUpdateCustomer(Customer customer) {
        Session session = sessionFactory.getCurrentSession();
        
        if (customer.getId() == null) {
            customer.setCreatedDate(new Date());
            customer.setStatus("ACTIVE");
        }
        
        Customer mergedCustomer = (Customer) session.merge(customer);
        Long customerId = mergedCustomer.getId();
        return customerId;
    }

    /**
     * Lấy khách hàng theo ID
     */
    public Customer getCustomerById(Long id) {
        Session session = sessionFactory.getCurrentSession();
        Customer customer = session.get(Customer.class, id);
        if (customer != null && customer.getBookings() != null) {
            // Initialize lazy-loaded bookings collection within the session
            customer.getBookings().size();
        }
        return customer;
    }

    /**
     * Tìm khách hàng theo số điện thoại
     */
    public Customer getCustomerByPhone(String phoneNumber) {
        Session session = sessionFactory.getCurrentSession();
        Query<Customer> query = session.createQuery(
            "FROM Customer WHERE phoneNumber = :phone", Customer.class);
        query.setParameter("phone", phoneNumber);
        List<Customer> results = query.getResultList();
        return results.isEmpty() ? null : results.get(0);
    }

    /**
     * Tìm khách hàng theo email
     */
    public Customer getCustomerByEmail(String email) {
        Session session = sessionFactory.getCurrentSession();
        Query<Customer> query = session.createQuery(
            "FROM Customer WHERE email = :email", Customer.class);
        query.setParameter("email", email);
        List<Customer> results = query.getResultList();
        return results.isEmpty() ? null : results.get(0);
    }

    /**
     * Lấy tất cả khách hàng (hoạt động)
     */
    public List<Customer> getAllActiveCustomers() {
        Session session = sessionFactory.getCurrentSession();
        Query<Customer> query = session.createQuery(
            "FROM Customer WHERE status = 'ACTIVE' ORDER BY fullName", Customer.class);
        return query.getResultList();
    }

    /**
     * Lấy tất cả khách hàng
     */
    public List<Customer> getAllCustomers() {
        Session session = sessionFactory.getCurrentSession();
        Query<Customer> query = session.createQuery(
            "FROM Customer ORDER BY createdDate DESC", Customer.class);
        return query.getResultList();
    }

    /**
     * Tìm kiếm khách hàng theo tên hoặc số điện thoại
     */
    public List<Customer> searchCustomers(String keyword) {
        Session session = sessionFactory.getCurrentSession();
        Query<Customer> query = session.createQuery(
            "FROM Customer WHERE fullName LIKE :keyword OR phoneNumber LIKE :keyword ORDER BY fullName",
            Customer.class);
        query.setParameter("keyword", "%" + keyword + "%");
        return query.getResultList();
    }

    /**
     * Lấy danh sách khách hàng đồng ý nhận marketing
     */
    public List<Customer> getMarketingCustomers() {
        Session session = sessionFactory.getCurrentSession();
        Query<Customer> query = session.createQuery(
            "FROM Customer WHERE isAcceptMarketing = true AND status = 'ACTIVE' ORDER BY fullName",
            Customer.class);
        return query.getResultList();
    }

    /**
     * Lấy lịch sử dịch vụ của khách hàng
     */
    public List<Booking> getCustomerServiceHistory(Long customerId) {
        Session session = sessionFactory.getCurrentSession();
        Query<Booking> query = session.createQuery(
            "FROM Booking WHERE customer.id = :customerId ORDER BY bookingDateTime DESC",
            Booking.class);
        query.setParameter("customerId", customerId);
        return query.getResultList();
    }

    /**
     * Cập nhật trạng thái khách hàng
     */
    public void updateCustomerStatus(Long customerId, String status) {
        Session session = sessionFactory.getCurrentSession();
        Customer customer = session.get(Customer.class, customerId);
        if (customer != null) {
            customer.setStatus(status);
            session.merge(customer);
        }
    }

    /**
     * Cập nhật tuỳ chọn marketing
     */
    public void updateMarketingPreference(Long customerId, boolean acceptMarketing) {
        Session session = sessionFactory.getCurrentSession();
        Customer customer = session.get(Customer.class, customerId);
        if (customer != null) {
            customer.setAcceptMarketing(acceptMarketing);
            session.merge(customer);
        }
    }

    /**
     * Cập nhật ngày truy cập cuối cùng
     */
    public void updateLastVisitDate(Long customerId) {
        Session session = sessionFactory.getCurrentSession();
        Customer customer = session.get(Customer.class, customerId);
        if (customer != null) {
            customer.setLastVisitDate(new Date());
            session.merge(customer);
        }
    }

    /**
     * Cập nhật tổng số tiền đã chi tiêu
     */
    public void updateTotalSpent(Long customerId, Double amount) {
        Session session = sessionFactory.getCurrentSession();
        Customer customer = session.get(Customer.class, customerId);
        if (customer != null) {
            Double currentTotal = customer.getTotalSpent() != null ? customer.getTotalSpent() : 0.0;
            customer.setTotalSpent(currentTotal + amount);
            session.merge(customer);
        }
    }

    /**
     * Xoá khách hàng
     */
    public void deleteCustomer(Long id) {
        Session session = sessionFactory.getCurrentSession();
        Customer customer = session.get(Customer.class, id);
        if (customer != null) {
            session.remove(customer);
        }
    }

    /**
     * Lấy số lượng khách hàng hoạt động
     */
    public long getActiveCustomerCount() {
        Session session = sessionFactory.getCurrentSession();
        Query<Long> query = session.createQuery(
            "SELECT count(c) FROM Customer c WHERE c.status = 'ACTIVE'", Long.class);
        return query.getSingleResult();
    }

    /**
     * Lấy khách hàng mới trong N ngày qua
     */
    public List<Customer> getNewCustomersInDays(int days) {
        Session session = sessionFactory.getCurrentSession();
        if (days <= 0) {
            days = 30; // default
        }
        long millis = (long) days * 24 * 60 * 60 * 1000;
        Date cutoff = new Date(System.currentTimeMillis() - millis);
        Query<Customer> query = session.createQuery(
            "FROM Customer WHERE createdDate >= :cutoff ORDER BY createdDate DESC", Customer.class);
        query.setParameter("cutoff", cutoff);
        return query.getResultList();
    }

    /**
     * Lấy khách hàng có tổng chi tiêu cao nhất
     */
    public List<Customer> getTopSpendingCustomers(int limit) {
        Session session = sessionFactory.getCurrentSession();
        Query<Customer> query = session.createQuery(
            "FROM Customer WHERE status = 'ACTIVE' ORDER BY totalSpent DESC",
            Customer.class);
        query.setMaxResults(limit);
        return query.getResultList();
    }
}
