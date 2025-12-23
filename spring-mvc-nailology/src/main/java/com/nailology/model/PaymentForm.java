package com.nailology.model;

import java.math.BigDecimal;

import com.nailology.entity.Payment.PaymentMethod;

public class PaymentForm {

	private Long bookingId;
	private String bookingCode;
	private BigDecimal amount;
	private PaymentMethod paymentMethod;
	private String note;
	private String customerName;
	private String customerEmail;
	private String customerPhone;

	// Constructors
	public PaymentForm() {
	}

	public PaymentForm(Long bookingId, BigDecimal amount, PaymentMethod paymentMethod) {
		this.bookingId = bookingId;
		this.amount = amount;
		this.paymentMethod = paymentMethod;
	}

	// Getters and Setters
	public Long getBookingId() {
		return bookingId;
	}

	public void setBookingId(Long bookingId) {
		this.bookingId = bookingId;
	}

	public String getBookingCode() {
		return bookingCode;
	}

	public void setBookingCode(String bookingCode) {
		this.bookingCode = bookingCode;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public PaymentMethod getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(PaymentMethod paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getCustomerEmail() {
		return customerEmail;
	}

	public void setCustomerEmail(String customerEmail) {
		this.customerEmail = customerEmail;
	}

	public String getCustomerPhone() {
		return customerPhone;
	}

	public void setCustomerPhone(String customerPhone) {
		this.customerPhone = customerPhone;
	}

	@Override
	public String toString() {
		return "PaymentForm{" + "bookingId=" + bookingId + ", bookingCode='" + bookingCode + '\'' + ", amount=" + amount
				+ ", paymentMethod=" + paymentMethod + ", note='" + note + '\'' + '}';
	}
}