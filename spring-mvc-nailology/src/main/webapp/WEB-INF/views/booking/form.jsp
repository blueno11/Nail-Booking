<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt lịch - Nailology</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Lora:wght@400;500&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #c4a080;
            --dark: #3d3d3d;
            --accent: #d4af9e;
            --light-bg: #f5f1ed;
            --white: #ffffff;
            --border: #e0e0e0;
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { background: linear-gradient(135deg, #f5f1ed 0%, #faf8f6 100%); font-family: 'Lora', serif; color: var(--dark); min-height: 100vh; }
        .container { max-width: 1200px; margin: 0 auto; padding: 40px 20px; }
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px; padding-bottom: 30px; border-bottom: 2px solid var(--primary); }
        .page-header h1 { font-family: 'Playfair Display', serif; font-size: 42px; font-weight: 600; color: var(--dark); }
        .page-header p { color: #999; font-size: 14px; margin-top: 5px; }
        .btn { padding: 12px 24px; border-radius: 8px; border: none; cursor: pointer; font-family: 'Lora', serif; font-size: 14px; font-weight: 500; transition: all 0.3s ease; text-decoration: none; display: inline-block; }
        .btn-primary { background: linear-gradient(135deg, var(--primary) 0%, #a9886b 100%); color: white; box-shadow: 0 4px 15px rgba(196, 160, 128, 0.3); }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(196, 160, 128, 0.4); }
        .btn-secondary { background: white; color: var(--primary); border: 2px solid var(--primary); }
        .btn-secondary:hover { background: var(--primary); color: white; }
        
        .form-container { display: grid; grid-template-columns: 1fr 1fr; gap: 30px; margin-bottom: 40px; }
        .form-card { background: white; padding: 30px; border-radius: 12px; box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05); border-top: 4px solid var(--primary); }
        .form-card-title { font-family: 'Playfair Display', serif; font-size: 22px; font-weight: 600; color: var(--dark); margin-bottom: 24px; display: flex; align-items: center; gap: 10px; }
        
        .form-group { margin-bottom: 16px; }
        .form-group label { display: block; font-weight: 600; color: var(--dark); margin-bottom: 8px; font-size: 14px; }
        .form-group input,
        .form-group select,
        .form-group textarea { width: 100%; padding: 12px; border: 1px solid var(--border); border-radius: 8px; font-family: 'Lora', serif; font-size: 14px; color: var(--dark); transition: all 0.3s ease; }
        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus { outline: none; border-color: var(--primary); box-shadow: 0 0 0 3px rgba(196, 160, 128, 0.1); }
        
        .service-list { display: flex; flex-direction: column; gap: 12px; max-height: 400px; overflow-y: auto; padding: 12px; background: #f9f8f7; border-radius: 8px; border: 1px solid var(--border); }
        .service-item { display: flex; align-items: center; gap: 10px; padding: 10px; border-radius: 6px; transition: all 0.3s ease; }
        .service-item:hover { background: rgba(196, 160, 128, 0.1); }
        .service-item input[type="checkbox"] { width: 18px; height: 18px; cursor: pointer; }
        .service-item label { flex: 1; cursor: pointer; margin: 0; font-weight: normal; font-size: 14px; }
        .service-price { color: var(--primary); font-weight: 600; font-family: 'Playfair Display', serif; }
        
        .form-actions { display: flex; gap: 12px; margin-top: 24px; flex-wrap: wrap; }
        .form-actions .btn { flex: 1; min-width: 150px; text-align: center; }
        
        @media (max-width: 768px) {
            .form-container { grid-template-columns: 1fr; }
            .page-header { flex-direction: column; align-items: flex-start; gap: 16px; }
            .page-header h1 { font-size: 32px; }
        }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp" />

<div class="container">
    <div class="page-header">
        <div>
            <h1>📅 Đặt Lịch</h1>
            <p>Chọn ngày/giờ, chi nhánh, kỹ thuật viên và dịch vụ</p>
        </div>
        <a href="${pageContext.request.contextPath}/booking/list" class="btn btn-secondary">📋 Danh sách lịch</a>
    </div>

    <form method="post" action="${pageContext.request.contextPath}/booking/submit">
        <div class="form-container">
            <!-- Left Card: Customer Info -->
            <div class="form-card">
                <div class="form-card-title">👤 Thông Tin Khách</div>
                
                <div class="form-group">
                    <label>Họ tên khách <span style="color:#dc3545;">*</span></label>
                    <input type="text" name="customerName" value="${bookingForm.customerName}" placeholder="Nhập họ tên" required>
                </div>

                <div class="form-group">
                    <label>Điện thoại <span style="color:#dc3545;">*</span></label>
                    <input type="tel" name="phone" value="${bookingForm.phone}" placeholder="Nhập số điện thoại" required>
                </div>

                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" value="${bookingForm.email}" placeholder="Nhập email (tuỳ chọn)">
                </div>

                <div class="form-group">
                    <label>Chi nhánh <span style="color:#dc3545;">*</span></label>
                    <select name="locationId" required>
                        <option value="">-- Chọn chi nhánh --</option>
                        <c:forEach var="loc" items="${locations}">
                            <option value="${loc.id}" ${bookingForm.locationId == loc.id ? 'selected' : ''}>${loc.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label>Kỹ thuật viên</label>
                    <select name="staffId">
                        <option value="">-- Chọn kỹ thuật viên --</option>
                        <c:forEach var="s" items="${staffs}">
                            <option value="${s.id}" ${bookingForm.staffId == s.id ? 'selected' : ''}>${s.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <!-- Right Card: Date/Time & Services -->
            <div class="form-card">
                <div class="form-card-title">🕐 Ngày Giờ & Dịch Vụ</div>
                
                <div class="form-group">
                    <label>Ngày đặt lịch <span style="color:#dc3545;">*</span></label>
                    <input type="date" name="date" value="${bookingForm.date}" required>
                </div>

                <div class="form-group">
                    <label>Giờ đặt lịch <span style="color:#dc3545;">*</span></label>
                    <input type="time" name="time" value="${bookingForm.time}" required>
                </div>

                <div class="form-group">
                    <label>Dịch vụ <span style="color:#dc3545;">*</span></label>
                    <div class="service-list">
                        <c:forEach var="svc" items="${services}">
                            <div class="service-item">
                                <input type="checkbox" name="selectedServiceIds" value="${svc.id}" id="svc-${svc.id}"
                                       <c:if test="${bookingForm.selectedServiceIds != null && bookingForm.selectedServiceIds.contains(svc.id.intValue())}">checked</c:if> />
                                <label for="svc-${svc.id}">${svc.name}</label>
                                <span class="service-price"><fmt:formatNumber value="${svc.startingPrice}" type="currency" currencySymbol="đ" /></span>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <div class="form-group">
                    <label>Ghi chú</label>
                    <textarea name="message" rows="4" placeholder="Ghi chú thêm (tuỳ chọn)">${bookingForm.message}</textarea>
                </div>
            </div>
        </div>

        <input type="hidden" name="customerId" value="${selectedCustomerId}" />

        <div class="form-actions">
            <button class="btn btn-primary" type="submit">💾 Lưu Đặt Lịch</button>
            <a href="${pageContext.request.contextPath}/customer" class="btn btn-secondary">← Quay Lại</a>
        </div>
    </form>
</div>

<jsp:include page="../layout/footer.jsp" />
</body>
</html>