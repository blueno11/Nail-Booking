# Quản lý Khách hàng - Tài liệu Hướng dẫn

## 📋 Tổng Quan

Module Quản lý Khách hàng cung cấp các tính năng quản lý toàn diện hồ sơ khách hàng, lịch sử dịch vụ, tuỳ chọn marketing, và liên kết booking với khách hàng. Đây là một chức năng quan trọng dành cho nhân viên (staff) của salon.

## 🎯 Chức Năng Chính

### 1. Quản lý Hồ sơ Khách hàng

#### 1.1 Xem Danh sách Khách hàng
- **URL**: `/customer`
- **Tính năng**:
  - Hiển thị danh sách tất cả khách hàng hoạt động
  - Tìm kiếm theo tên hoặc số điện thoại
  - Lọc theo trạng thái (hoạt động, không hoạt động, danh sách đen)
  - Hiển thị thống kê: tổng lần truy cập, tổng chi tiêu
  - Hiển thị trạng thái marketing

#### 1.2 Xem Chi tiết Khách hàng
- **URL**: `/customer/{id}`
- **Tính năng**:
  - Xem thông tin cá nhân đầy đủ
  - Xem thống kê: lần truy cập, tổng chi tiêu, lần truy cập cuối
  - Xem lịch sử dịch vụ gần đây (5 booking mới nhất)
  - Quản lý tuỳ chọn marketing
  - Chỉnh sửa thông tin khách hàng

#### 1.3 Thêm Khách hàng Mới
- **URL**: `/customer/create`
- **Tính năng**:
  - Form nhập thông tin khách hàng
  - Các trường: Tên, SĐT, Email, Địa chỉ, Ngày sinh
  - Tuỳ chọn nhận marketing
  - Ghi chú về khách hàng

#### 1.4 Chỉnh sửa Khách hàng
- **URL**: `/customer/{id}/edit`
- **Tính năng**:
  - Cập nhật thông tin khách hàng
  - Thay đổi tuỳ chọn marketing
  - Cập nhật ghi chú

### 2. Lịch sử Dịch vụ

#### 2.1 Xem Toàn bộ Lịch sử Dịch vụ
- **URL**: `/customer/{id}/service-history`
- **Tính năng**:
  - Danh sách đầy đủ tất cả booking của khách hàng
  - Sắp xếp theo thứ tự mới nhất
  - Hiển thị: Ngày đặt, trạng thái, tổng tiền, nhân viên phụ trách
  - Thống kê: Tổng lần truy cập, tổng chi tiêu

### 3. Tuỳ chọn Marketing

#### 3.1 Cập nhật Tuỳ chọn Marketing
- **URL**: `/customer/{id}/update-marketing` (POST)
- **Tính năng**:
  - Bật/Tắt nhận thông tin khuyến mãi
  - Có thể thay đổi từ trang chi tiết khách hàng

#### 3.2 Danh sách Khách hàng Nhận Marketing
- **URL**: `/customer/marketing/list`
- **Tính năng**:
  - Liệt kê tất cả khách hàng đồng ý nhận marketing
  - Dùng cho các chiến dịch marketing
  - Hiển thị: Tên, SĐT, Email, Tổng chi tiêu

### 4. Liên kết Booking với Khách hàng

#### 4.1 Chọn/Tạo Khách hàng cho Booking
- **URL**: `/customer/select-for-booking`
- **Tính năng**:
  - Tìm kiếm khách hàng hiện có
  - Tạo khách hàng mới ngay từ form đặt lịch
  - Liên kết trực tiếp với booking

#### 4.2 Cập nhật Booking
- **URL**: `/booking`
- **Tính năng**:
  - Hỗ trợ tham số `customerId` để liên kết khách hàng
  - Tự động cập nhật ngày truy cập cuối của khách hàng

### 5. Thống kê & Báo cáo

#### 5.1 Khách hàng Chi tiêu Cao Nhất
- **URL**: `/customer/top-spenders`
- **Tính năng**:
  - Top 10 khách hàng có tổng chi tiêu cao nhất
  - Hiển thị xếp hạng với emoji (🥇🥈🥉)
  - Thông tin: Tên, SĐT, Email, Lần truy cập, Tổng chi tiêu

#### 5.2 Khách hàng Mới
- **URL**: `/customer/new-customers?days=30`
- **Tính năng**:
  - Danh sách khách hàng đăng ký trong N ngày
  - Mặc định: 30 ngày
  - Hiển thị ngày đăng ký chi tiết

## 📊 Cấu trúc Dữ liệu

### Entity: Customer

```
Customer
├── id (Long) - ID khách hàng
├── fullName (String) - Tên khách hàng *
├── phoneNumber (String) - Số điện thoại * (unique)
├── email (String) - Email
├── address (String) - Địa chỉ
├── dateOfBirth (Date) - Ngày sinh
├── isAcceptMarketing (Boolean) - Đồng ý marketing (mặc định: true)
├── createdDate (Date) - Ngày tạo (tự động)
├── lastVisitDate (Date) - Lần truy cập cuối cùng
├── totalSpent (Double) - Tổng tiền đã chi (mặc định: 0)
├── notes (String) - Ghi chú
├── status (String) - Trạng thái: ACTIVE, INACTIVE, BLACKLIST
└── bookings (List<Booking>) - Danh sách booking của khách hàng
```

### Trạng thái Khách hàng
- **ACTIVE**: Khách hàng đang hoạt động
- **INACTIVE**: Khách hàng không còn hoạt động
- **BLACKLIST**: Khách hàng bị đen danh (không phục vụ)

## 🔧 Services (CustomerService)

### Phương thức Chính

#### Lưu & Cập nhật
```java
Long saveOrUpdateCustomer(Customer customer)
```

#### Tìm kiếm
```java
Customer getCustomerById(Long id)
Customer getCustomerByPhone(String phoneNumber)
Customer getCustomerByEmail(String email)
List<Customer> searchCustomers(String keyword)
```

#### Danh sách
```java
List<Customer> getAllActiveCustomers()
List<Customer> getAllCustomers()
List<Customer> getMarketingCustomers()
List<Customer> getNewCustomersInDays(int days)
List<Customer> getTopSpendingCustomers(int limit)
```

#### Quản lý Lịch sử
```java
List<Booking> getCustomerServiceHistory(Long customerId)
```

#### Cập nhật Thông tin
```java
void updateCustomerStatus(Long customerId, String status)
void updateMarketingPreference(Long customerId, boolean accept)
void updateLastVisitDate(Long customerId)
void updateTotalSpent(Long customerId, Double amount)
```

#### Xoá
```java
void deleteCustomer(Long id)
```

#### Thống kê
```java
long getActiveCustomerCount()
```

## 🎨 Giao diện (Views)

### Danh sách Views

| View | URL | Mục đích |
|------|-----|---------|
| list.jsp | /customer | Danh sách khách hàng |
| form.jsp | /customer/create, /customer/{id}/edit | Thêm/Chỉnh sửa |
| detail.jsp | /customer/{id} | Chi tiết khách hàng |
| service-history.jsp | /customer/{id}/service-history | Lịch sử dịch vụ đầy đủ |
| marketing-list.jsp | /customer/marketing/list | Danh sách marketing |
| select-for-booking.jsp | /customer/select-for-booking | Chọn KH cho booking |
| top-spenders.jsp | /customer/top-spenders | Top khách hàng chi tiêu cao |
| new-customers.jsp | /customer/new-customers | Khách hàng mới |

## 📱 Hướng dẫn Sử dụng

### Quy trình Tạo Booking với Khách hàng Mới

1. **Bước 1**: Nhân viên truy cập `/booking`
2. **Bước 2**: Nhân viên nhấn "Chọn Khách hàng" → `/customer/select-for-booking`
3. **Bước 3**: Nhân viên có 2 lựa chọn:
   - **Chọn khách hàng hiện có**: Tìm kiếm và click "Chọn"
   - **Tạo khách hàng mới**: Nhập thông tin và submit
4. **Bước 4**: Hệ thống chuyển hướng về `/booking?customerId=XX`
5. **Bước 5**: Nhân viên chọn dịch vụ và submit booking
6. **Bước 6**: Booking được liên kết với khách hàng, thông tin khách hàng tự động cập nhật

### Quy trình Cập nhật Hồ sơ Khách hàng

1. Truy cập `/customer` → Danh sách
2. Click "Xem" để xem chi tiết → `/customer/{id}`
3. Click "Chỉnh sửa" → `/customer/{id}/edit`
4. Cập nhật thông tin
5. Nhấn "Lưu" → Quay lại trang chi tiết

### Quy trình Quản lý Marketing

1. Truy cập `/customer` → Danh sách
2. Click "Xem" → `/customer/{id}`
3. Tại mục "Quản lý", click "Kích hoạt/Huỷ Marketing"
4. Hoặc truy cập `/customer/marketing/list` xem danh sách toàn bộ

## 🔍 Tìm kiếm & Lọc

### Tìm kiếm Khách hàng
- Tìm kiếm theo **tên** hoặc **số điện thoại**
- Từ trang `/customer`, nhập từ khoá và click "Tìm kiếm"
- Kết quả hiển thị khách hàng khớp từ khoá

### Lọc theo Trạng thái
- **ACTIVE**: Chỉ hiển thị khách hàng hoạt động
- **ALL**: Hiển thị tất cả khách hàng

## 📈 Báo cáo & Thống kê

### Top 10 Khách hàng Chi tiêu Cao
- URL: `/customer/top-spenders`
- Sắp xếp theo tổng chi tiêu giảm dần
- Hiển thị rank và emoji

### Khách hàng Mới trong N ngày
- URL: `/customer/new-customers?days=30`
- Mặc định: 30 ngày
- Có thể thay đổi tham số `days`

## ⚠️ Validate & Xác thực

### Khi thêm/sửa Khách hàng
- ✓ Tên khách hàng không được để trống
- ✓ Số điện thoại không được để trống
- ✓ Số điện thoại phải unique (không trùng lặp)
- ✓ Email phải đúng định dạng (nếu nhập)

## 🔐 Quyền hạn

- Tất cả nhân viên (staff) có thể xem danh sách khách hàng
- Tất cả nhân viên có thể thêm/sửa khách hàng
- Tất cả nhân viên có thể xem lịch sử dịch vụ
- Tất cả nhân viên có thể cập nhật tuỳ chọn marketing

## 🛠️ Kỹ thuật

### Dependencies
- Spring Framework 5.3.23
- Hibernate 5.6.14
- MySQL 8.0.33
- JSP 2.3.3

### Database Schema
```sql
-- Table: customer
CREATE TABLE customer (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(255),
    address VARCHAR(255),
    date_of_birth DATE,
    is_accept_marketing BOOLEAN DEFAULT TRUE,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_visit_date TIMESTAMP,
    total_spent DOUBLE DEFAULT 0,
    notes TEXT,
    status VARCHAR(20) DEFAULT 'ACTIVE',
    INDEX(phone_number),
    INDEX(email)
);
```

## 📞 Hỗ trợ

### Các vấn đề thường gặp

**Q: Tại sao không tìm thấy khách hàng?**
- A: Kiểm tra xem khách hàng có trạng thái là "ACTIVE" không. Hoặc thử tìm kiếm lại bằng số điện thoại chính xác.

**Q: Làm sao để xoá khách hàng?**
- A: Truy cập chi tiết khách hàng, scroll xuống cuối, click "Xoá". Lưu ý: Xoá khách hàng sẽ xoá toàn bộ lịch sử booking.

**Q: Tổng chi tiêu không cập nhật?**
- A: Tổng chi tiêu cập nhật khi booking hoàn thành. Kiểm tra trạng thái booking.

---

**Phiên bản**: 1.0.0  
**Cập nhật**: 05/12/2025
