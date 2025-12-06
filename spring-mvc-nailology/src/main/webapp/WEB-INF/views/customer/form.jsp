<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>${isNew ? 'Thêm Khách Hàng' : 'Chỉnh Sửa Khách Hàng'} - Nailology</title>
    <meta charset="UTF-8">
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
            --success: #28a745;
            --danger: #dc3545;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(135deg, #f5f1ed 0%, #faf8f6 100%);
            font-family: 'Lora', serif;
            color: var(--dark);
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        .form-header {
            margin-bottom: 40px;
            padding-bottom: 30px;
            border-bottom: 2px solid var(--primary);
        }

        .form-header h1 {
            font-family: 'Playfair Display', serif;
            font-size: 38px;
            font-weight: 600;
            color: var(--dark);
            margin-bottom: 5px;
        }

        .form-header p {
            color: #999;
            font-size: 14px;
        }

        .form-card {
            background: white;
            border-radius: 12px;
            padding: 30px;
            margin-bottom: 25px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
            border-left: 5px solid var(--primary);
        }

        .form-card-title {
            font-family: 'Playfair Display', serif;
            font-size: 18px;
            font-weight: 600;
            color: var(--dark);
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--border);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group:last-child {
            margin-bottom: 0;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--dark);
            font-size: 14px;
        }

        .required::after {
            content: " *";
            color: var(--danger);
        }

        input[type="text"],
        input[type="email"],
        input[type="tel"],
        input[type="date"],
        textarea,
        select {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid var(--border);
            border-radius: 8px;
            font-family: 'Lora', serif;
            font-size: 14px;
            transition: border-color 0.3s, box-shadow 0.3s;
            box-sizing: border-box;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="tel"]:focus,
        input[type="date"]:focus,
        textarea:focus,
        select:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(196, 160, 128, 0.1);
        }

        textarea {
            resize: vertical;
            min-height: 120px;
            font-family: 'Lora', serif;
        }

        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .checkbox-group input[type="checkbox"] {
            width: auto;
            cursor: pointer;
            accent-color: var(--primary);
        }

        .checkbox-group label {
            margin-bottom: 0;
            cursor: pointer;
        }

        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-family: 'Lora', serif;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            flex: 1;
            text-align: center;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary) 0%, #a9886b 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(196, 160, 128, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(196, 160, 128, 0.4);
        }

        .btn-secondary {
            background: white;
            color: var(--primary);
            border: 2px solid var(--primary);
        }

        .btn-secondary:hover {
            background: var(--primary);
            color: white;
        }

        .message {
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 14px;
        }

        .error {
            background: rgba(220, 53, 69, 0.1);
            color: var(--danger);
            border-left: 4px solid var(--danger);
        }

        @media (max-width: 768px) {
            .form-header h1 {
                font-size: 28px;
            }

            .button-group {
                flex-direction: column;
            }

            .btn {
                flex: none;
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="../layout/header.jsp" />

    <div class="container">
        <!-- Header -->
        <div class="form-header">
            <h1>${isNew ? '➕ Thêm Khách Hàng' : '✎ Chỉnh Sửa Khách Hàng'}</h1>
            <p>${isNew ? 'Tạo hồ sơ khách hàng mới' : 'Cập nhật thông tin khách hàng'}</p>
        </div>

        <!-- Error Messages -->
        <c:if test="${not empty error}">
            <div class="message error">
                <span>✗</span> ${error}
            </div>
        </c:if>

        <!-- Form -->
        <form method="post" action="${pageContext.request.contextPath}/customer/save">
            <c:if test="${not isNew}">
                <input type="hidden" name="id" value="${customer.id}">
            </c:if>

            <!-- Basic Information Card -->
            <div class="form-card">
                <div class="form-card-title">👤 Thông Tin Cơ Bản</div>

                <div class="form-group">
                    <label class="required">Tên Khách Hàng</label>
                    <input type="text" name="fullName" value="${customer.fullName}" required placeholder="Nhập tên khách hàng">
                </div>

                <div class="form-group">
                    <label class="required">Số Điện Thoại</label>
                    <input type="tel" name="phoneNumber" value="${customer.phoneNumber}" required placeholder="Nhập số điện thoại">
                </div>

                <div class="form-group">
                    <label>📧 Email</label>
                    <input type="email" name="email" value="${customer.email}" placeholder="Nhập email">
                </div>

                <div class="form-group">
                    <label>📍 Địa Chỉ</label>
                    <input type="text" name="address" value="${customer.address}" placeholder="Nhập địa chỉ">
                </div>

                <div class="form-group">
                    <label>🎂 Ngày Sinh</label>
                    <input type="date" name="dateOfBirth" 
                           value="<c:if test='${not empty customer.dateOfBirth}'><fmt:formatDate value='${customer.dateOfBirth}' pattern='yyyy-MM-dd'/></c:if>">
                </div>
            </div>

            <!-- Preferences Card -->
            <div class="form-card">
                <div class="form-card-title">⚙️ Tùy Chọn</div>

                <div class="form-group checkbox-group">
                    <input type="checkbox" id="acceptMarketing" name="acceptMarketing" value="true"
                           ${customer.acceptMarketing ? 'checked' : ''}>
                    <label for="acceptMarketing">Chấp nhận nhận thông tin khuyến mãi</label>
                </div>
            </div>

            <!-- Notes Card -->
            <div class="form-card">
                <div class="form-card-title">📝 Ghi Chú</div>

                <div class="form-group">
                    <label>Ghi Chú (sở thích, dị ứng, yêu cầu đặc biệt...)</label>
                    <textarea name="notes" placeholder="Nhập ghi chú">${customer.notes}</textarea>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="button-group">
                <button type="submit" class="btn btn-primary">💾 Lưu Khách Hàng</button>
                <a href="${pageContext.request.contextPath}/customer" class="btn btn-secondary">← Quay Lại</a>
            </div>
        </form>
    </div>

    <jsp:include page="../layout/footer.jsp" />
</body>
</html>