package com.nailology.repository;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.nailology.entity.Payment;
import com.nailology.entity.Payment.PaymentMethod;
import com.nailology.entity.Payment.PaymentStatus;

@Repository
public class PaymentRepository {

	@Autowired
	private SessionFactory sessionFactory;

	private Session getCurrentSession() {
		return sessionFactory.getCurrentSession();
	}

	/**
	 * Lưu hoặc cập nhật payment
	 */
	public Payment save(Payment payment) {
		getCurrentSession().saveOrUpdate(payment);
		return payment;
	}

	/**
	 * Tìm payment theo ID
	 */
	public Optional<Payment> findById(Long id) {
		Payment payment = getCurrentSession().get(Payment.class, id);
		return Optional.ofNullable(payment);
	}

	/**
	 * Tìm payment theo mã thanh toán
	 */
	public Optional<Payment> findByPaymentCode(String paymentCode) {
		String hql = "FROM Payment WHERE paymentCode = :code";
		Query<Payment> query = getCurrentSession().createQuery(hql, Payment.class);
		query.setParameter("code", paymentCode);
		return query.uniqueResultOptional();
	}

	/**
	 * Tìm tất cả payments theo booking ID
	 */
	public List<Payment> findByBookingId(Long bookingId) {
		String hql = "FROM Payment WHERE booking.id = :bookingId ORDER BY createdAt DESC";
		Query<Payment> query = getCurrentSession().createQuery(hql, Payment.class);
		query.setParameter("bookingId", bookingId);
		return query.getResultList();
	}

	/**
	 * Tìm payment theo email khách hàng
	 */
	public List<Payment> findByCustomerEmail(String email) {
		String hql = "FROM Payment WHERE customerEmail = :email ORDER BY createdAt DESC";
		Query<Payment> query = getCurrentSession().createQuery(hql, Payment.class);
		query.setParameter("email", email);
		return query.getResultList();
	}

	/**
	 * Tìm payment theo số điện thoại
	 */
	public List<Payment> findByCustomerPhone(String phone) {
		String hql = "FROM Payment WHERE customerPhone = :phone ORDER BY createdAt DESC";
		Query<Payment> query = getCurrentSession().createQuery(hql, Payment.class);
		query.setParameter("phone", phone);
		return query.getResultList();
	}

	/**
	 * Tìm payment theo trạng thái
	 */
	public List<Payment> findByStatus(PaymentStatus status) {
		String hql = "FROM Payment WHERE status = :status ORDER BY createdAt DESC";
		Query<Payment> query = getCurrentSession().createQuery(hql, Payment.class);
		query.setParameter("status", status);
		return query.getResultList();
	}

	/**
	 * Tìm payment theo phương thức thanh toán
	 */
	public List<Payment> findByPaymentMethod(PaymentMethod method) {
		String hql = "FROM Payment WHERE paymentMethod = :method ORDER BY createdAt DESC";
		Query<Payment> query = getCurrentSession().createQuery(hql, Payment.class);
		query.setParameter("method", method);
		return query.getResultList();
	}

	/**
	 * Tìm payment trong khoảng thời gian
	 */
	public List<Payment> findByDateRange(LocalDateTime startDate, LocalDateTime endDate) {
		String hql = "FROM Payment WHERE createdAt BETWEEN :startDate AND :endDate ORDER BY createdAt DESC";
		Query<Payment> query = getCurrentSession().createQuery(hql, Payment.class);
		query.setParameter("startDate", startDate);
		query.setParameter("endDate", endDate);
		return query.getResultList();
	}

	/**
	 * Tìm payment đã hoàn thành theo booking ID
	 */
	public Optional<Payment> findCompletedPaymentByBookingId(Long bookingId) {
		String hql = "FROM Payment WHERE booking.id = :bookingId AND status = :status";
		Query<Payment> query = getCurrentSession().createQuery(hql, Payment.class);
		query.setParameter("bookingId", bookingId);
		query.setParameter("status", PaymentStatus.COMPLETED);
		return query.uniqueResultOptional();
	}

	/**
	 * Lấy tất cả payments
	 */
	public List<Payment> findAll() {
		String hql = "FROM Payment ORDER BY createdAt DESC";
		Query<Payment> query = getCurrentSession().createQuery(hql, Payment.class);
		return query.getResultList();
	}

	/**
	 * Đếm số payment theo trạng thái
	 */
	public Long countByStatus(PaymentStatus status) {
		String hql = "SELECT COUNT(p) FROM Payment p WHERE p.status = :status";
		Query<Long> query = getCurrentSession().createQuery(hql, Long.class);
		query.setParameter("status", status);
		return query.uniqueResult();
	}

	/**
	 * Tính tổng số tiền đã thanh toán trong khoảng thời gian
	 */
	public Double sumCompletedPaymentsByDateRange(LocalDateTime startDate, LocalDateTime endDate) {
		String hql = "SELECT COALESCE(SUM(p.amount), 0) FROM Payment p "
				+ "WHERE p.status = :status AND p.paidAt BETWEEN :startDate AND :endDate";
		Query<BigDecimal> query = getCurrentSession().createQuery(hql, BigDecimal.class);
		query.setParameter("status", PaymentStatus.COMPLETED);
		query.setParameter("startDate", startDate);
		query.setParameter("endDate", endDate);
		BigDecimal result = query.uniqueResult();
		return result != null ? result.doubleValue() : 0.0;
	}

	/**
	 * Tính tổng doanh thu theo phương thức thanh toán
	 */
	public Double sumByPaymentMethod(PaymentMethod method, LocalDateTime startDate, LocalDateTime endDate) {
		String hql = "SELECT COALESCE(SUM(p.amount), 0) FROM Payment p "
				+ "WHERE p.status = :status AND p.paymentMethod = :method "
				+ "AND p.paidAt BETWEEN :startDate AND :endDate";
		Query<BigDecimal> query = getCurrentSession().createQuery(hql, BigDecimal.class);
		query.setParameter("status", PaymentStatus.COMPLETED);
		query.setParameter("method", method);
		query.setParameter("startDate", startDate);
		query.setParameter("endDate", endDate);
		BigDecimal result = query.uniqueResult();
		return result != null ? result.doubleValue() : 0.0;
	}

	/**
	 * Tìm payments với nhiều điều kiện lọc
	 */
	public List<Payment> findWithFilters(PaymentStatus status, PaymentMethod method, LocalDateTime startDate,
			LocalDateTime endDate) {
		StringBuilder hql = new StringBuilder("FROM Payment p WHERE 1=1");

		if (status != null) {
			hql.append(" AND p.status = :status");
		}
		if (method != null) {
			hql.append(" AND p.paymentMethod = :method");
		}
		if (startDate != null && endDate != null) {
			hql.append(" AND p.createdAt BETWEEN :startDate AND :endDate");
		}
		hql.append(" ORDER BY p.createdAt DESC");

		Query<Payment> query = getCurrentSession().createQuery(hql.toString(), Payment.class);

		if (status != null) {
			query.setParameter("status", status);
		}
		if (method != null) {
			query.setParameter("method", method);
		}
		if (startDate != null && endDate != null) {
			query.setParameter("startDate", startDate);
			query.setParameter("endDate", endDate);
		}

		return query.getResultList();
	}

	/**
	 * Kiểm tra xem booking đã có payment completed chưa
	 */
	public boolean hasCompletedPayment(Long bookingId) {
		String hql = "SELECT COUNT(p) FROM Payment p WHERE p.booking.id = :bookingId AND p.status = :status";
		Query<Long> query = getCurrentSession().createQuery(hql, Long.class);
		query.setParameter("bookingId", bookingId);
		query.setParameter("status", PaymentStatus.COMPLETED);
		return query.uniqueResult() > 0;
	}

	/**
	 * Xóa payment
	 */
	public void delete(Payment payment) {
		getCurrentSession().delete(payment);
	}

	/**
	 * Xóa payment theo ID
	 */
	public void deleteById(Long id) {
		Payment payment = getCurrentSession().get(Payment.class, id);
		if (payment != null) {
			getCurrentSession().delete(payment);
		}
	}

	/**
	 * Lấy danh sách payments gần đây (limit)
	 */
	public List<Payment> findRecentPayments(int limit) {
		String hql = "FROM Payment ORDER BY createdAt DESC";
		Query<Payment> query = getCurrentSession().createQuery(hql, Payment.class);
		query.setMaxResults(limit);
		return query.getResultList();
	}

	/**
	 * Lấy danh sách payments pending gần đây
	 */
	public List<Payment> findPendingPayments(int limit) {
		String hql = "FROM Payment WHERE status = :status ORDER BY createdAt DESC";
		Query<Payment> query = getCurrentSession().createQuery(hql, Payment.class);
		query.setParameter("status", PaymentStatus.PENDING);
		query.setMaxResults(limit);
		return query.getResultList();
	}

	/**
	 * Tìm payment theo transaction ID
	 */
	public Optional<Payment> findByTransactionId(String transactionId) {
		String hql = "FROM Payment WHERE transactionId = :transactionId";
		Query<Payment> query = getCurrentSession().createQuery(hql, Payment.class);
		query.setParameter("transactionId", transactionId);
		return query.uniqueResultOptional();
	}

	/**
	 * Đếm tổng số payments
	 */
	public Long countAll() {
		String hql = "SELECT COUNT(p) FROM Payment p";
		Query<Long> query = getCurrentSession().createQuery(hql, Long.class);
		return query.uniqueResult();
	}

	/**
	 * Lấy tổng doanh thu tất cả thời gian
	 */
	public Double getTotalRevenue() {
		String hql = "SELECT COALESCE(SUM(p.amount), 0) FROM Payment p WHERE p.status = :status";
		Query<BigDecimal> query = getCurrentSession().createQuery(hql, BigDecimal.class);
		query.setParameter("status", PaymentStatus.COMPLETED);
		BigDecimal result = query.uniqueResult();
		return result != null ? result.doubleValue() : 0.0;
	}
}