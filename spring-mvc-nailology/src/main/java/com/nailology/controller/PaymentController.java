package com.nailology.controller;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.nailology.entity.Booking;
import com.nailology.entity.Payment;
import com.nailology.entity.Payment.PaymentMethod;
import com.nailology.entity.Payment.PaymentStatus;
import com.nailology.model.PaymentForm;
import com.nailology.service.BookingService;
import com.nailology.service.PaymentService;

@Controller
@RequestMapping("/payment")
public class PaymentController {

	@Autowired
	private PaymentService paymentService;

	@Autowired
	private BookingService bookingService;

	/**
	 * Trang tạo payment cho booking
	 */
	@GetMapping("/create")
	public String createPaymentPage(@RequestParam(value = "bookingId", required = false) Long bookingId,
			@RequestParam(value = "bookingCode", required = false) String bookingCode, Model model,
			RedirectAttributes redirectAttributes) {
		try {
			Booking booking = null;

			// Tìm booking theo ID hoặc code
			if (bookingId != null) {
				booking = bookingService.findById(bookingId);
			} else if (bookingCode != null && !bookingCode.isEmpty()) {
				booking = bookingService.findByBookingCode(bookingCode).orElse(null);
			}

			if (booking == null) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy booking");
				return "redirect:/booking/manage";
			}

			// Kiểm tra đã thanh toán chưa
			if (paymentService.isBookingPaid(booking.getId())) {
				redirectAttributes.addFlashAttribute("error", "Booking này đã được thanh toán");
				return "redirect:/booking/view/" + booking.getBookingCode();
			}

			model.addAttribute("booking", booking);
			model.addAttribute("paymentForm", new PaymentForm());
			model.addAttribute("paymentMethods", PaymentMethod.values());

			return "payment-create";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Lỗi: " + e.getMessage());
			return "redirect:/booking/manage";
		}
	}

	/**
	 * Xử lý tạo payment
	 */
	@PostMapping("/create")
	public String createPayment(@ModelAttribute PaymentForm paymentForm, RedirectAttributes redirectAttributes) {
		try {
			System.out.println("=== CREATE PAYMENT ===");
			System.out.println("BookingId: " + paymentForm.getBookingId());
			System.out.println("BookingCode: " + paymentForm.getBookingCode());
			System.out.println("Amount: " + paymentForm.getAmount());
			System.out.println("Method: " + paymentForm.getPaymentMethod());

			Payment payment = paymentService.createPayment(paymentForm);

			// Nếu là thanh toán tiền mặt, tự động xác nhận
			if (payment.getPaymentMethod() == PaymentMethod.CASH) {
				payment = paymentService.confirmPayment(payment.getId(), "CASH-" + System.currentTimeMillis());
				redirectAttributes.addFlashAttribute("success", "Thanh toán thành công!");
			} else {
				redirectAttributes.addFlashAttribute("success",
						"Tạo payment thành công! Vui lòng hoàn tất thanh toán.");
			}

			return "redirect:/payment/view/" + payment.getPaymentCode();
		} catch (Exception e) {
			System.out.println("ERROR: " + e.getMessage());
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("error", "Lỗi: " + e.getMessage());
			return "redirect:/payment/create?bookingId=" + paymentForm.getBookingId();
		}
	}

	/**
	 * Xem chi tiết payment
	 */
	@GetMapping("/view/{paymentCode}")
	public String viewPayment(@PathVariable String paymentCode, Model model, RedirectAttributes redirectAttributes) {
		try {
			Payment payment = paymentService.findByPaymentCode(paymentCode)
					.orElseThrow(() -> new RuntimeException("Không tìm thấy payment"));

			model.addAttribute("payment", payment);
			model.addAttribute("booking", payment.getBooking());

			return "payment-detail";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Lỗi: " + e.getMessage());
			return "redirect:/booking/manage";
		}
	}

	/**
	 * Xác nhận thanh toán
	 */
	@PostMapping("/confirm/{paymentCode}")
	public String confirmPayment(@PathVariable String paymentCode,
			@RequestParam(value = "transactionId", required = false) String transactionId,
			RedirectAttributes redirectAttributes) {
		try {
			if (transactionId == null || transactionId.isEmpty()) {
				transactionId = "TXN-" + System.currentTimeMillis();
			}

			Payment payment = paymentService.confirmPaymentByCode(paymentCode, transactionId);
			redirectAttributes.addFlashAttribute("success", "Xác nhận thanh toán thành công!");

			return "redirect:/payment/view/" + payment.getPaymentCode();
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Lỗi: " + e.getMessage());
			return "redirect:/payment/view/" + paymentCode;
		}
	}

	/**
	 * Hoàn tiền
	 */
	@PostMapping("/refund/{id}")
	public String refundPayment(@PathVariable Long id, @RequestParam(value = "note", required = false) String note,
			RedirectAttributes redirectAttributes) {
		try {
			Payment payment = paymentService.refundPayment(id, note);
			redirectAttributes.addFlashAttribute("success", "Hoàn tiền thành công!");

			return "redirect:/payment/view/" + payment.getPaymentCode();
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Lỗi: " + e.getMessage());
			return "redirect:/payment/view/" + id;
		}
	}

	/**
	 * Trang quản lý payments
	 */
	@GetMapping("/manage")
	public String managePayments(@RequestParam(value = "status", required = false) String status, Model model) {
		try {
			List<Payment> payments;

			if (status != null && !status.isEmpty()) {
				PaymentStatus paymentStatus = PaymentStatus.valueOf(status.toUpperCase());
				payments = paymentService.getPaymentsByStatus(paymentStatus);
				model.addAttribute("selectedStatus", status);
			} else {
				payments = paymentService.getAllPayments();
			}

			model.addAttribute("payments", payments);
			model.addAttribute("paymentStatuses", PaymentStatus.values());

			// Thống kê
			Long pendingCount = paymentService.countByStatus(PaymentStatus.PENDING);
			Long completedCount = paymentService.countByStatus(PaymentStatus.COMPLETED);

			model.addAttribute("pendingCount", pendingCount);
			model.addAttribute("completedCount", completedCount);

			return "payment-list";
		} catch (Exception e) {
			model.addAttribute("error", "Lỗi: " + e.getMessage());
			return "payment-list";
		}
	}

	/**
	 * Tìm kiếm payment
	 */
	@PostMapping("/search")
	public String searchPayments(@RequestParam(required = false) String email,
			@RequestParam(required = false) String phone, @RequestParam(required = false) String paymentCode,
			Model model, RedirectAttributes redirectAttributes) {
		try {
			List<Payment> payments;

			if (paymentCode != null && !paymentCode.trim().isEmpty()) {
				Payment payment = paymentService.findByPaymentCode(paymentCode.trim()).orElse(null);
				if (payment != null) {
					return "redirect:/payment/view/" + payment.getPaymentCode();
				}
				payments = List.of();
			} else if (email != null && !email.trim().isEmpty()) {
				payments = paymentService.findByEmail(email.trim());
			} else if (phone != null && !phone.trim().isEmpty()) {
				payments = paymentService.findByPhone(phone.trim());
			} else {
				redirectAttributes.addFlashAttribute("error", "Vui lòng nhập thông tin tìm kiếm");
				return "redirect:/payment/manage";
			}

			model.addAttribute("payments", payments);
			model.addAttribute("searchPerformed", true);

			return "payment-list";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Lỗi tìm kiếm: " + e.getMessage());
			return "redirect:/payment/manage";
		}
	}

	/**
	 * Trang báo cáo doanh thu
	 */
	@GetMapping("/report")
	public String reportPage(@RequestParam(value = "startDate", required = false) String startDate,
			@RequestParam(value = "endDate", required = false) String endDate, Model model) {
		try {
			LocalDateTime start = startDate != null && !startDate.isEmpty() ? LocalDateTime.parse(startDate)
					: LocalDateTime.now().minusMonths(1);

			LocalDateTime end = endDate != null && !endDate.isEmpty() ? LocalDateTime.parse(endDate)
					: LocalDateTime.now();

			Double totalRevenue = paymentService.getTotalRevenue(start, end);

			model.addAttribute("totalRevenue", totalRevenue != null ? totalRevenue : 0.0);
			model.addAttribute("startDate", start);
			model.addAttribute("endDate", end);

			return "payment-report";
		} catch (Exception e) {
			model.addAttribute("error", "Lỗi: " + e.getMessage());
			return "payment-report";
		}
	}
}