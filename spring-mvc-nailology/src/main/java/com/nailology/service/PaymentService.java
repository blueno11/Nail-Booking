package com.nailology.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nailology.entity.Booking;
import com.nailology.entity.Payment;
import com.nailology.entity.Payment.PaymentStatus;
import com.nailology.model.PaymentForm;
import com.nailology.repository.BookingRepository;
import com.nailology.repository.PaymentRepository;

@Service
@Transactional
public class PaymentService {

	@Autowired
	private PaymentRepository paymentRepository;

	@Autowired
	private BookingRepository bookingRepository;

	/**
	 * Tạo payment mới từ booking
	 */
	@Transactional
	public Payment createPayment(PaymentForm form) {
		// Validate booking
		Booking booking = null;
		if (form.getBookingId() != null) {
			booking = bookingRepository.findById(form.getBookingId())
					.orElseThrow(() -> new RuntimeException("Không tìm thấy booking"));
		} else if (form.getBookingCode() != null && !form.getBookingCode().isEmpty()) {
			booking = bookingRepository.findByBookingCode(form.getBookingCode())
					.orElseThrow(() -> new RuntimeException("Không tìm thấy booking với mã: " + form.getBookingCode()));
		} else {
			throw new RuntimeException("Vui lòng cung cấp booking ID hoặc booking code");
		}

		// Kiểm tra đã thanh toán chưa
		Optional<Payment> existingPayment = paymentRepository.findCompletedPaymentByBookingId(booking.getId());
		if (existingPayment.isPresent()) {
			throw new RuntimeException("Booking này đã được thanh toán");
		}

		// Kiểm tra trạng thái booking
		if (booking.getStatus() == Booking.BookingStatus.CANCELLED) {
			throw new RuntimeException("Không thể thanh toán cho booking đã hủy");
		}

		// Tạo payment
		Payment payment = new Payment();
		payment.setBooking(booking);
		payment.setAmount(form.getAmount() != null ? form.getAmount() : booking.getTotalPrice());
		payment.setPaymentMethod(form.getPaymentMethod());
		payment.setNote(form.getNote());

		// Lấy thông tin khách hàng từ booking nếu không có trong form
		payment.setCustomerName(form.getCustomerName() != null ? form.getCustomerName() : booking.getCustomerName());
		payment.setCustomerEmail(form.getCustomerEmail() != null ? form.getCustomerEmail() : booking.getEmail());
		payment.setCustomerPhone(form.getCustomerPhone() != null ? form.getCustomerPhone() : booking.getPhone());

		payment.setStatus(PaymentStatus.PENDING);

		return paymentRepository.save(payment);
	}

	/**
	 * Xác nhận thanh toán thành công
	 */
	@Transactional
	public Payment confirmPayment(Long paymentId, String transactionId) {
		Payment payment = paymentRepository.findById(paymentId)
				.orElseThrow(() -> new RuntimeException("Không tìm thấy payment"));

		if (payment.getStatus() == PaymentStatus.COMPLETED) {
			throw new RuntimeException("Payment đã được xác nhận trước đó");
		}

		payment.setStatus(PaymentStatus.COMPLETED);
		payment.setPaidAt(LocalDateTime.now());
		payment.setTransactionId(transactionId);

		// Cập nhật trạng thái booking
		Booking booking = payment.getBooking();
		if (booking.getStatus() == Booking.BookingStatus.PENDING) {
			booking.setStatus(Booking.BookingStatus.CONFIRMED);
			bookingRepository.save(booking);
		}

		return paymentRepository.save(payment);
	}

	/**
	 * Xác nhận thanh toán bằng payment code
	 */
	@Transactional
	public Payment confirmPaymentByCode(String paymentCode, String transactionId) {
		Payment payment = paymentRepository.findByPaymentCode(paymentCode)
				.orElseThrow(() -> new RuntimeException("Không tìm thấy payment với mã: " + paymentCode));

		return confirmPayment(payment.getId(), transactionId);
	}

	/**
	 * Đánh dấu thanh toán thất bại
	 */
	@Transactional
	public Payment failPayment(Long paymentId) {
		Payment payment = paymentRepository.findById(paymentId)
				.orElseThrow(() -> new RuntimeException("Không tìm thấy payment"));

		payment.setStatus(PaymentStatus.FAILED);
		return paymentRepository.save(payment);
	}

	/**
	 * Hoàn tiền
	 */
	@Transactional
	public Payment refundPayment(Long paymentId, String note) {
		Payment payment = paymentRepository.findById(paymentId)
				.orElseThrow(() -> new RuntimeException("Không tìm thấy payment"));

		if (payment.getStatus() != PaymentStatus.COMPLETED) {
			throw new RuntimeException("Chỉ có thể hoàn tiền cho payment đã hoàn thành");
		}

		payment.setStatus(PaymentStatus.REFUNDED);
		if (note != null && !note.isEmpty()) {
			payment.setNote((payment.getNote() != null ? payment.getNote() + " | " : "") + "Refund: " + note);
		}

		return paymentRepository.save(payment);
	}

	/**
	 * Tìm payment theo booking ID
	 */
	@Transactional(readOnly = true)
	public List<Payment> findByBookingId(Long bookingId) {
		return paymentRepository.findByBookingId(bookingId);
	}

	/**
	 * Tìm payment theo payment code
	 */
	@Transactional(readOnly = true)
	public Optional<Payment> findByPaymentCode(String paymentCode) {
		return paymentRepository.findByPaymentCode(paymentCode);
	}

	/**
	 * Tìm payment theo email
	 */
	@Transactional(readOnly = true)
	public List<Payment> findByEmail(String email) {
		return paymentRepository.findByCustomerEmail(email);
	}

	/**
	 * Tìm payment theo số điện thoại
	 */
	@Transactional(readOnly = true)
	public List<Payment> findByPhone(String phone) {
		return paymentRepository.findByCustomerPhone(phone);
	}

	/**
	 * Lấy tất cả payment
	 */
	@Transactional(readOnly = true)
	public List<Payment> getAllPayments() {
		return paymentRepository.findAll();
	}

	/**
	 * Lấy payment theo trạng thái
	 */
	@Transactional(readOnly = true)
	public List<Payment> getPaymentsByStatus(PaymentStatus status) {
		return paymentRepository.findByStatus(status);
	}

	/**
	 * Lấy payment theo ID
	 */
	@Transactional(readOnly = true)
	public Payment getPaymentById(Long id) {
		return paymentRepository.findById(id).orElse(null);
	}

	/**
	 * Kiểm tra booking đã được thanh toán chưa
	 */
	@Transactional(readOnly = true)
	public boolean isBookingPaid(Long bookingId) {
		return paymentRepository.findCompletedPaymentByBookingId(bookingId).isPresent();
	}

	/**
	 * Lấy tổng doanh thu trong khoảng thời gian
	 */
	@Transactional(readOnly = true)
	public Double getTotalRevenue(LocalDateTime startDate, LocalDateTime endDate) {
		return paymentRepository.sumCompletedPaymentsByDateRange(startDate, endDate);
	}

	/**
	 * Đếm số payment theo trạng thái
	 */
	@Transactional(readOnly = true)
	public Long countByStatus(PaymentStatus status) {
		return paymentRepository.countByStatus(status);
	}
}