# 🚀 Hướng dẫn Nhanh - Quản lý Khách hàng

## ⚡ Quick Start (5 phút)

### 1️⃣ Truy cập Danh sách Khách hàng
```
http://localhost:8080/customer
```
- Xem tất cả khách hàng hoạt động
- Tìm kiếm, lọc theo trạng thái
- Hiển thị: Tên, SĐT, Email, Lần truy cập, Chi tiêu, Trạng thái

### 2️⃣ Thêm Khách hàng Mới
```
http://localhost:8080/customer/create
```
Điền thông tin:
- **Tên khách hàng** * (bắt buộc)
- **Số điện thoại** * (bắt buộc, unique)
- Email
- Địa chỉ
- Ngày sinh
- ☑ Nhận marketing (mặc định: có)
- Ghi chú

Click **"💾 Lưu"** → Thành công! ✅

### 3️⃣ Xem Chi tiết Khách hàng
```
http://localhost:8080/customer/{id}
```
Thông tin:
- Hồ sơ cá nhân đầy đủ
- Thống kê: Lần truy cập, Tổng chi tiêu, Lần truy cập cuối
- 5 booking gần đây nhất
- Nút: Chỉnh sửa, Lịch sử dịch vụ, Quay lại

### 4️⃣ Đặt Booking với Khách hàng
```
Tùy chọn 1: KH mới
http://localhost:8080/booking
  → Click "Chọn Khách hàng"
  → Tab "Thêm khách hàng mới"
  → Nhập thông tin
  → Chọn dịch vụ & Submit

Tùy chọn 2: KH hiện có
http://localhost:8080/booking
  → Click "Chọn Khách hàng"
  → Tab "Khách hàng hiện có"
  → Tìm kiếm hoặc scroll
  → Click "Chọn"
  → Chọn dịch vụ & Submit
```

### 5️⃣ Quản lý Marketing
```
Từ trang chi tiết KH:
http://localhost:8080/customer/{id}
  → Cuộn xuống "⚙️ Quản lý"
  → Click "✓ Huỷ Marketing" hoặc "✗ Kích hoạt Marketing"
  → Cập nhật ngay lập tức

Xem danh sách KH nhận marketing:
http://localhost:8080/customer/marketing/list
  → Liệt kê tất cả KH đồng ý
  → Dùng cho campaigns
```

### 6️⃣ Xem Lịch sử Dịch vụ
```
Từ trang chi tiết KH:
http://localhost:8080/customer/{id}
  → Click "📋 Lịch sử dịch vụ"
  → Hoặc: http://localhost:8080/customer/{id}/service-history

Hiển thị:
- Tất cả booking của KH
- Ngày đặt, trạng thái, tổng tiền, nhân viên
- Sắp xếp mới nhất trước
```

### 7️⃣ Thống kê
```
Top 10 KH chi tiêu cao:
http://localhost:8080/customer/top-spenders
  → 🥇🥈🥉 Xếp hạng
  → Tên, SĐT, Email, Lần truy cập, Chi tiêu

KH mới trong 30 ngày:
http://localhost:8080/customer/new-customers
http://localhost:8080/customer/new-customers?days=7
  → Ngày đăng ký, trạng thái
  → Có thể thay đổi tham số days
```

---

## 📋 Thông tin Cần Thiết

### Trường Bắt buộc
| Trường | Quy tắc | Ví dụ |
|--------|--------|------|
| Tên KH | Không trống | Nguyễn Văn A |
| SĐT | Không trống, Unique | 0912345678 |
| Email | Valid format (tuỳ chọn) | a@example.com |

### Trạng thái
- 🟢 **ACTIVE**: Khách hàng hoạt động
- 🟠 **INACTIVE**: Không hoạt động
- 🔴 **BLACKLIST**: Không phục vụ

### Marketing
- ✅ **Có**: KH đồng ý nhận thông tin
- ❌ **Không**: KH từ chối
- (Mặc định: Có)

---

## 🔍 Tìm Kiếm & Lọc

### Tìm Kiếm
```
GET /customer?search=keyword

Tìm theo:
- Tên khách hàng (hoặc một phần)
- Số điện thoại (hoặc một phần)

Ví dụ:
/customer?search=Nguyễn
/customer?search=0912
```

### Lọc
```
GET /customer?status=ACTIVE|ALL

Status:
- ACTIVE (mặc định): Chỉ KH hoạt động
- ALL: Tất cả KH
```

### Kết hợp
```
/customer?search=Nguyễn&status=ACTIVE
→ Tìm "Nguyễn" trong KH hoạt động
```

---

## 🎨 Các Nút Thường Dùng

| Nút | Nơi | Chức năng |
|-----|-----|----------|
| + Thêm Khách hàng | /customer | Thêm KH mới |
| Tìm kiếm | /customer | Tìm KH |
| Xem | /customer | Xem chi tiết |
| Sửa | /customer hoặc /customer/{id} | Chỉnh sửa |
| Xoá | /customer/{id} | Xoá KH |
| Lịch sử dịch vụ | /customer/{id} | Xem toàn bộ booking |
| ✓/✗ Marketing | /customer/{id} | Bật/Tắt marketing |
| Chọn Khách hàng | /booking | Liên kết booking |
| 📋 Lịch sử | /customer/{id} | Booking của KH |
| 🏆 Top Chi tiêu | /customer | Top 10 spenders |
| 👤 Khách hàng mới | /customer | KH mới 30 ngày |

---

## 📊 Hiệu suất

### Thời gian Phản hồi (Dự tính)
| Thao tác | Thời gian |
|---------|----------|
| Danh sách KH | < 500ms |
| Tìm kiếm | < 1s |
| Chi tiết KH | < 300ms |
| Lưu KH | < 500ms |
| Top spenders | < 1s |

### Pagination (Tuỳ chọn)
- Danh sách: 10-20 KH/trang (tuỳ cấu hình)
- Lịch sử: Tất cả (có thể paginate nếu cần)

---

## ⚠️ Lỗi Thường Gặp & Giải pháp

### ❌ "Số điện thoại này đã được đăng ký"
**Nguyên nhân**: SĐT đã tồn tại  
**Giải pháp**: 
- Kiểm tra KH hiện có
- Sửa SĐT khác
- Hoặc cập nhật KH cũ

### ❌ "Không tìm thấy khách hàng"
**Nguyên nhân**: KH không có trạng thái ACTIVE  
**Giải pháp**:
- Thử lọc "ALL" thay vì "ACTIVE"
- Kiểm tra tên/SĐT đúng
- Tạo KH mới

### ❌ "Tên khách hàng không được để trống"
**Nguyên nhân**: Trường bắt buộc chưa điền  
**Giải pháp**:
- Điền tên KH
- Điền SĐT (cũng bắt buộc)
- Submit lại

### ❌ "Lịch sử dịch vụ trống"
**Nguyên nhân**: KH chưa có booking  
**Giải pháp**:
- Tạo booking mới cho KH
- Hoặc chọn KH khác

---

## 💡 Mẹo & Thủ thuật

### Mẹo 1: Tìm Nhanh
```
Nhấn Ctrl+F trên danh sách
Hoặc dùng search box /customer?search=
```

### Mẹo 2: Bulk Marketing
```
1. /customer/marketing/list
2. Xem danh sách KH nhận marketing
3. Dùng để gửi SMS/Email campaigns
```

### Mẹo 3: Phân tích
```
/customer/top-spenders
→ Xác định VIP customers
→ Tặng thẻ membership, khuyến mãi

/customer/new-customers
→ Khách hàng mới cần chú ý
→ Tặng giảm giá, tặng dịch vụ
```

### Mẹo 4: Ghi chú
```
Dùng field "Ghi chú" để lưu:
- Sở thích màu sơn
- Dị ứng từng loại sơn
- Kiểu móng yêu thích
- Lần tới cần nhắc gì
```

### Mẹo 5: Đặt lịch Nhanh
```
Khách hàng cũ:
1. /customer/select-for-booking
2. Tìm & Click "Chọn"
3. Xong, quay lại /booking tự động

Khách hàng mới:
1. /customer/select-for-booking
2. Tab "Thêm khách hàng mới"
3. Nhập nhanh 3 trường: Tên, SĐT, Marketing
4. Submit → Quay lại booking
```

---

## 📱 Shortcut URLs

```
# Danh sách
/customer → Tất cả KH

# Quản lý
/customer/create → Thêm KH mới
/customer/{id} → Chi tiết KH
/customer/{id}/edit → Chỉnh sửa
/customer/{id}/service-history → Lịch sử

# Marketing
/customer/marketing/list → Danh sách marketing

# Thống kê
/customer/top-spenders → Top 10
/customer/new-customers → KH mới (30 ngày)
/customer/new-customers?days=7 → KH mới (7 ngày)

# Booking
/customer/select-for-booking → Chọn KH cho booking
/booking?customerId={id} → Đặt lịch với KH
```

---

## ✅ Checklist Hàng Ngày

### Buổi Sáng
- [ ] Kiểm tra KH mới
- [ ] Xem top spenders (VIP customers)
- [ ] Chuẩn bị thông tin cho buổi làm việc

### Trong Ngày
- [ ] Cập nhật thông tin KH mới
- [ ] Ghi chú tuỳ chọn KH
- [ ] Đặt lịch với KH hiện có
- [ ] Cập nhật booking

### Cuối Ngày
- [ ] Kiểm tra booking đã xong
- [ ] Cập nhật tổng chi tiêu
- [ ] Ghi chú booking thành công

---

## 🔐 Quyền & Bảo mật

### Quyền Hạn (Tất cả Staff)
- ✅ Xem danh sách KH
- ✅ Xem chi tiết KH
- ✅ Thêm/Sửa KH
- ✅ Xem lịch sử dịch vụ
- ✅ Cập nhật marketing

### Bảo mật
- 🔒 SĐT Unique: Không trùng lặp
- 🔒 Thông tin cá nhân: Được bảo vệ
- 🔒 Lịch sử booking: Liên kết với KH

---

## 📞 Hỗ trợ

Nếu gặp vấn đề:
1. Kiểm tra hướng dẫn ở phần "Lỗi Thường Gặp"
2. Xem tài liệu chi tiết: [CUSTOMER_MANAGEMENT_GUIDE.md](./CUSTOMER_MANAGEMENT_GUIDE.md)
3. Liên hệ admin

---

**Phiên bản**: 1.0.0  
**Ngày cập nhật**: 05/12/2025  
**Trạng thái**: ✅ Production Ready
