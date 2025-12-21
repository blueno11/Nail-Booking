<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Lịch hẹn - Nailology</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .detail-container { max-width: 800px; margin: 2rem auto; padding: 0 1rem; }
        .detail-card { background: white; border-radius: 0.75rem; box-shadow: 0 4px 15px rgba(0,0,0,0.05); overflow: hidden; }
        .detail-header { background: var(--primary-color); color: white; padding: 1.5rem; display: flex; justify-content: space-between; align-items: center; }
        .booking-code { font-size: 1.5rem; font-weight: 700; }
        .status-badge { padding: 0.5rem 1rem; border-radius: 1rem; font-weight: 600; }
        .status-PENDING { background: #fef3c7; color: #d97706; }
        .status-CONFIRMED { background: #dcfce7; color: #16a34a; }
        .status-COMPLETED { background: #dbeafe; color: #2563eb; }
        .status-CANCELLED { background: #fee2e2; color: #dc2626; }
        .detail-body { padding: 1.5rem; }
        .info-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 1.5rem; margin-bottom: 1.5rem; }
        .info-item label { display: block; font-size: 0.75rem; color: #999; text-transform: uppercase; margin-bottom: 0.25rem; }
        .info-item span { font-size: 1rem; color: var(--primary-dark); font-weight: 500; }
        .action-section { border-top: 1px solid #eee; padding-top: 1.5rem; margin-top: 1.5rem; }
        .action-title { font-size: 1rem; font-weight: 600; margin-bottom: 1rem; color: var(--primary-dark); }
        .action-buttons { display: flex; gap: 0.75rem; flex-wrap: wrap; }
        .btn { padding: 0.625rem 1.25rem; border-radius: 0.375rem; font-weight: 500; cursor: pointer; border: none; text-decoration: none; display: inline-block; }
        .btn-confirm { background: #16a34a; color: white; }
        .btn-complete { background: #2563eb; color: white; }
        .btn-cancel { background: #dc2626; color: white; }
        .btn-secondary { background: #f3f4f6; color: #374151; }
        .assign-form { display: flex; gap: 0.5rem; align-items: center; margin-top: 1rem; }
        .assign-form select { padding: 0.5rem; border: 1px solid #ddd; border-radius: 0.375rem; min-width: 200px; }
        .alert { padding: 1rem; border-radius: 0.5rem; margin-bottom: 1rem; }
        .alert-success { background: #dcfce7; color: #16a34a; }
        .alert-error { background: #fee2e2; color: #dc2626; }
        .notes-section { background: #f9fafb; padding: 1rem; border-radius: 0.5rem; margin-top: 1rem; }
        .notes-section h4 { margin: 0 0 0.5rem 0; font-size: 0.875rem; color: #666; }
    </style>
    <script>
        function getStatusText(status) {
            const map = {'PENDING':'Chờ duyệt','CONFIRMED':'Đã xác nhận','COMPLETED':'Hoàn thành','CANCELLED':'Đã hủy'};
            return map[status] || status;
        }
        document.addEventListener('DOMContentLoaded', function() {
            document.querySelectorAll('.status-badge').forEach(el => {
                el.textContent = getStatusText(el.textContent.trim());
            });
        });
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="detail-container">
    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-error">${error}</div>
    </c:if>

    <div class="detail-card">
        <div class="detail-header">
            <span class="booking-code">#${booking.bookingCode}</span>
            <span class="status-badge status-${booking.status}">${booking.status}</span>
        </div>
        <div class="detail-body">
            <div class="info-grid">
                <div class="info-item">
                    <label>Khách hàng</label>
                    <span>${booking.customerName}</span>
                </div>
                <div class="info-item">
                    <label>Số điện thoại</label>
                    <span>${booking.phone}</span>
                </div>
                <div class="info-item">
                    <label>Email</label>
                    <span>${booking.email != null ? booking.email : '-'}</span>
                </div>
                <div class="info-item">
                    <label>Dịch vụ</label>
                    <span>${booking.serviceNames}</span>
                </div>
                <div class="info-item">
                    <label>Chi nhánh</label>
                    <span>${booking.location.name}</span>
                </div>
                <div class="info-item">
                    <label>Ngày hẹn</label>
                    <span>${booking.bookingDate}</span>
                </div>
                <div class="info-item">
                    <label>Giờ hẹn</label>
                    <span>${booking.bookingTime}</span>
                </div>
                <div class="info-item">
                    <label>Nhân viên phục vụ</label>
                    <span>${booking.assignedStaff != null ? booking.assignedStaff.name : 'Chưa gán'}</span>
                </div>
            </div>

            <c:if test="${not empty booking.message}">
            <div class="notes-section">
                <h4>Ghi chú của khách</h4>
                <p>${booking.message}</p>
            </div>
            </c:if>

            <!-- Actions -->
            <div class="action-section">
                <h3 class="action-title">Thao tác</h3>
                <div class="action-buttons">
                    <c:if test="${booking.status == 'PENDING'}">
                    <form action="${pageContext.request.contextPath}/staff/booking/${booking.id}/confirm" method="post" style="display:inline;">
                        <button type="submit" class="btn btn-confirm">✓ Xác nhận</button>
                    </form>
                    </c:if>
                    
                    <c:if test="${booking.status == 'CONFIRMED'}">
                    <form action="${pageContext.request.contextPath}/staff/booking/${booking.id}/complete" method="post" style="display:inline;">
                        <button type="submit" class="btn btn-complete">✓ Hoàn thành</button>
                    </form>
                    </c:if>
                    
                    <c:if test="${booking.status != 'CANCELLED' && booking.status != 'COMPLETED'}">
                    <form action="${pageContext.request.contextPath}/staff/booking/${booking.id}/cancel" method="post" style="display:inline;" 
                          onsubmit="return confirm('Bạn có chắc muốn hủy lịch hẹn này?');">
                        <button type="submit" class="btn btn-cancel">✗ Hủy</button>
                    </form>
                    </c:if>
                    
                    <a href="${pageContext.request.contextPath}/staff/booking" class="btn btn-secondary">← Quay lại</a>
                </div>

                <!-- Gán nhân viên -->
                <c:if test="${booking.status != 'CANCELLED' && booking.status != 'COMPLETED'}">
                <form class="assign-form" action="${pageContext.request.contextPath}/staff/booking/${booking.id}/assign" method="post">
                    <label>Gán nhân viên:</label>
                    <select name="assignedStaffId" required>
                        <option value="">-- Chọn nhân viên --</option>
                        <c:forEach var="s" items="${staffList}">
                        <option value="${s.id}" ${booking.assignedStaff != null && booking.assignedStaff.id == s.id ? 'selected' : ''}>${s.name}</option>
                        </c:forEach>
                    </select>
                    <button type="submit" class="btn btn-primary">Gán</button>
                </form>
                </c:if>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>
