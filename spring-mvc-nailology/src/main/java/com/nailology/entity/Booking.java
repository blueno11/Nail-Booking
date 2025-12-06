package com.nailology.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "booking")
public class Booking {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(name = "booking_date_time", nullable = false)
	@Temporal(TemporalType.TIMESTAMP) // Lưu trữ cả ngày và giờ
	private Date bookingDateTime;

	@Column(name = "total_amount")
	private Double totalAmount;

	// Ví dụ về các trạng thái: PENDING, CONFIRMED, COMPLETED, CANCELLED
	@Column(name = "status", length = 20, nullable = false)
	private String status = "PENDING";

	// --- Mối quan hệ N-1: Liên kết với Customer (Khách hàng) ---
	// Đây là mối liên kết cho phép theo dõi lịch sử dịch vụ
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "customer_id", nullable = true)
	private Customer customer; // nullable=true cho phép đặt lịch với tư cách khách vãng lai

	// --- Mối quan hệ N-1: Liên kết với Staff (Thợ) ---
	// Giả định một thợ chính chịu trách nhiệm cho Booking này
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "staff_id", nullable = true)
	private Staff staff;

	// --- Mối quan hệ N-N: Liên kết với ServiceEntity (Các Dịch vụ được đặt) ---
	// Sử dụng @ManyToMany đơn giản, tạo bảng trung gian 'booking_service'
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "booking_service", joinColumns = @JoinColumn(name = "booking_id"), inverseJoinColumns = @JoinColumn(name = "service_id"))
	private List<ServiceEntity> services;

	// --- Constructors ---
	public Booking() {
		this.bookingDateTime = new Date(); // Khởi tạo thời gian đặt mặc định
	}

	// --- Getters and Setters ---

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Date getBookingDateTime() {
		return bookingDateTime;
	}

	public void setBookingDateTime(Date bookingDateTime) {
		this.bookingDateTime = bookingDateTime;
	}

	public Double getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(Double totalAmount) {
		this.totalAmount = totalAmount;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public Staff getStaff() {
		return staff;
	}

	public void setStaff(Staff staff) {
		this.staff = staff;
	}

	public List<ServiceEntity> getServices() {
		return services;
	}

	public void setServices(List<ServiceEntity> services) {
		this.services = services;
	}
}