package com.nailology.entity;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "customer")
public class Customer {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(name = "full_name", nullable = false)
	private String fullName;

	@Column(name = "phone_number", unique = true, nullable = false)
	private String phoneNumber;

	@Column(name = "email")
	private String email;

	@Column(name = "address")
	private String address;

	@Column(name = "date_of_birth")
	@Temporal(TemporalType.DATE)
	private Date dateOfBirth;

	@Column(name = "is_accept_marketing")
	private boolean isAcceptMarketing = true;

	@Column(name = "created_date", nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date createdDate;

	@Column(name = "last_visit_date")
	@Temporal(TemporalType.TIMESTAMP)
	private Date lastVisitDate;

	@Column(name = "total_spent")
	private Double totalSpent = 0.0;

	@Column(name = "notes")
	private String notes;

	@Column(name = "status", length = 20)
	private String status = "ACTIVE";

	@OneToMany(mappedBy = "customer", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private List<Booking> bookings;

	// --- Constructors ---
	public Customer() {
		this.createdDate = new Date();
		this.isAcceptMarketing = true;
		this.status = "ACTIVE";
		this.totalSpent = 0.0;
	}

	public Customer(String fullName, String phoneNumber, String email) {
		this();
		this.fullName = fullName;
		this.phoneNumber = phoneNumber;
		this.email = email;
	}

	// --- Getters & Setters ---
	public Long getId() { return id; }
	public void setId(Long id) { this.id = id; }

	public String getFullName() { return fullName; }
	public void setFullName(String fullName) { this.fullName = fullName; }

	public String getPhoneNumber() { return phoneNumber; }
	public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

	public String getEmail() { return email; }
	public void setEmail(String email) { this.email = email; }

	public String getAddress() { return address; }
	public void setAddress(String address) { this.address = address; }

	public Date getDateOfBirth() { return dateOfBirth; }
	public void setDateOfBirth(Date dateOfBirth) { this.dateOfBirth = dateOfBirth; }

	public boolean isAcceptMarketing() { return isAcceptMarketing; }
	public void setAcceptMarketing(boolean acceptMarketing) { isAcceptMarketing = acceptMarketing; }

	public Date getCreatedDate() { return createdDate; }
	public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }

	public Date getLastVisitDate() { return lastVisitDate; }
	public void setLastVisitDate(Date lastVisitDate) { this.lastVisitDate = lastVisitDate; }

	public Double getTotalSpent() { return totalSpent; }
	public void setTotalSpent(Double totalSpent) { this.totalSpent = totalSpent; }

	public String getNotes() { return notes; }
	public void setNotes(String notes) { this.notes = notes; }

	public String getStatus() { return status; }
	public void setStatus(String status) { this.status = status; }

	public List<Booking> getBookings() { return bookings; }
	public void setBookings(List<Booking> bookings) { this.bookings = bookings; }

	// Utility
	public int getVisitCount() {
		return bookings != null ? bookings.size() : 0;
	}
}