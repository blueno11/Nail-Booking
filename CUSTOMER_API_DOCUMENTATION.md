# Customer Management API Documentation

## 📡 API Endpoints

### 1. Customer Management

#### Danh sách Khách hàng
```
GET /customer
GET /customer?search=keyword
GET /customer?status=ACTIVE|ALL

Response: 
{
    "customers": [
        {
            "id": 1,
            "fullName": "Nguyễn Văn A",
            "phoneNumber": "0912345678",
            "email": "a@example.com",
            "address": "123 Đường ABC",
            "dateOfBirth": "1990-01-15",
            "isAcceptMarketing": true,
            "createdDate": "2025-12-01T10:30:00",
            "lastVisitDate": "2025-12-05T14:20:00",
            "totalSpent": 2500000.0,
            "notes": "Sở thích màu sơn nude",
            "status": "ACTIVE",
            "visitCount": 5
        }
    ]
}
```

#### Chi tiết Khách hàng
```
GET /customer/{id}

Response:
{
    "id": 1,
    "fullName": "Nguyễn Văn A",
    "phoneNumber": "0912345678",
    "email": "a@example.com",
    "address": "123 Đường ABC",
    "dateOfBirth": "1990-01-15",
    "isAcceptMarketing": true,
    "createdDate": "2025-12-01T10:30:00",
    "lastVisitDate": "2025-12-05T14:20:00",
    "totalSpent": 2500000.0,
    "notes": "Sở thích màu sơn nude",
    "status": "ACTIVE",
    "bookings": [
        {
            "id": 1,
            "bookingDateTime": "2025-12-05T10:00:00",
            "status": "COMPLETED",
            "totalAmount": 500000.0
        }
    ]
}
```

#### Thêm Khách hàng
```
POST /customer/save

Request Body:
{
    "fullName": "Nguyễn Văn B",
    "phoneNumber": "0987654321",
    "email": "b@example.com",
    "address": "456 Đường XYZ",
    "dateOfBirth": "1995-05-20",
    "acceptMarketing": true,
    "notes": "Ghi chú"
}

Response: Redirect to /customer/{newId}
```

#### Cập nhật Khách hàng
```
POST /customer/save

Request Body (with id):
{
    "id": 1,
    "fullName": "Nguyễn Văn A - Updated",
    "phoneNumber": "0912345678",
    "email": "a@example.com",
    ...
}

Response: Redirect to /customer/{id}
```

#### Cập nhật Tuỳ chọn Marketing
```
POST /customer/{id}/update-marketing?accept=true|false

Response: Redirect to /customer/{id}
```

#### Cập nhật Trạng thái
```
POST /customer/{id}/update-status?status=ACTIVE|INACTIVE|BLACKLIST

Response: Redirect to /customer/{id}
```

#### Xoá Khách hàng
```
POST /customer/{id}/delete

Response: Redirect to /customer?success=deleted
```

### 2. Service History

#### Lịch sử Dịch vụ
```
GET /customer/{id}/service-history

Response:
{
    "customer": {...},
    "serviceHistory": [
        {
            "id": 1,
            "bookingDateTime": "2025-12-05T10:00:00",
            "status": "COMPLETED",
            "totalAmount": 500000.0,
            "staff": {
                "id": 1,
                "fullName": "Thợ Linh"
            }
        },
        ...
    ],
    "visitCount": 5
}
```

### 3. Marketing Management

#### Danh sách Marketing Customers
```
GET /customer/marketing/list

Response:
{
    "customers": [
        {
            "id": 1,
            "fullName": "Nguyễn Văn A",
            "phoneNumber": "0912345678",
            "email": "a@example.com",
            "totalSpent": 2500000.0,
            "isAcceptMarketing": true
        }
    ]
}
```

### 4. Customer Selection for Booking

#### Chọn Khách hàng cho Booking
```
GET /customer/select-for-booking
GET /customer/select-for-booking?search=keyword

Response: HTML Form để chọn hoặc tạo khách hàng mới
```

#### Tạo Khách hàng từ Booking
```
POST /customer/create-from-booking

Request Body:
{
    "fullName": "Nguyễn Văn C",
    "phoneNumber": "0909090909",
    "email": "c@example.com",
    "address": "789 Đường DEF",
    "acceptMarketing": true
}

Response: Redirect to /booking?customerId={newId}
```

### 5. Statistics & Reports

#### Top Spending Customers
```
GET /customer/top-spenders

Response:
{
    "customers": [
        {
            "id": 1,
            "fullName": "Nguyễn Văn A",
            "phoneNumber": "0912345678",
            "email": "a@example.com",
            "visitCount": 15,
            "totalSpent": 5000000.0,
            "rank": 1
        },
        ...
    ]
}
```

#### New Customers
```
GET /customer/new-customers?days=30

Response:
{
    "customers": [
        {
            "id": 5,
            "fullName": "Nguyễn Văn D",
            "phoneNumber": "0911111111",
            "email": "d@example.com",
            "createdDate": "2025-12-01T09:00:00",
            "status": "ACTIVE"
        }
    ],
    "days": 30
}
```

## 📊 Data Models

### Customer Object
```json
{
    "id": "Long",
    "fullName": "String (required)",
    "phoneNumber": "String (required, unique)",
    "email": "String",
    "address": "String",
    "dateOfBirth": "Date",
    "isAcceptMarketing": "Boolean (default: true)",
    "createdDate": "DateTime (auto)",
    "lastVisitDate": "DateTime",
    "totalSpent": "Double (default: 0)",
    "notes": "String",
    "status": "String (ACTIVE|INACTIVE|BLACKLIST)",
    "visitCount": "Integer (calculated)"
}
```

### Booking Object (in context of Customer)
```json
{
    "id": "Long",
    "bookingDateTime": "DateTime",
    "status": "String (PENDING|CONFIRMED|COMPLETED|CANCELLED)",
    "totalAmount": "Double",
    "customerId": "Long",
    "staffId": "Long"
}
```

## 🔍 Query Parameters

### Search Parameters
```
GET /customer?search=keyword
- Tìm kiếm theo fullName hoặc phoneNumber

GET /customer?status=ACTIVE|ALL
- Lọc theo trạng thái (mặc định: ACTIVE)

GET /customer?search=nguyen&status=ACTIVE
- Kết hợp tìm kiếm và lọc

GET /customer/new-customers?days=30
- Lấy khách hàng mới trong N ngày (mặc định: 30)
```

## ✅ Validation Rules

### Required Fields
- `fullName`: Không được để trống
- `phoneNumber`: Không được để trống

### Unique Constraints
- `phoneNumber`: Phải unique trong database

### Format Rules
- `email`: Phải đúng định dạng email (nếu có)
- `dateOfBirth`: Định dạng YYYY-MM-DD

### Status Values
- `ACTIVE`: Khách hàng hoạt động
- `INACTIVE`: Khách hàng không hoạt động
- `BLACKLIST`: Khách hàng bị từ chối phục vụ

## 🔒 Error Handling

### HTTP Status Codes
```
200 OK - Thành công
302 Found - Redirect (thành công)
400 Bad Request - Validation error
404 Not Found - Khách hàng không tìm thấy
409 Conflict - Conflict (ví dụ: phone number đã tồn tại)
500 Internal Server Error - Lỗi server
```

### Error Response
```json
{
    "error": "Error message",
    "timestamp": "2025-12-05T10:30:00",
    "status": 400
}
```

## 📋 Common Use Cases

### 1. Tạo Booking cho Khách hàng Mới
```
1. GET /customer/select-for-booking
2. POST /customer/create-from-booking (tạo KH mới)
3. GET /booking?customerId={id} (nhập booking)
4. POST /booking/submit (lưu booking)
```

### 2. Cập nhật Hồ sơ Khách hàng
```
1. GET /customer/{id}/edit
2. POST /customer/save
```

### 3. Xem Lịch sử Dịch vụ
```
1. GET /customer/{id}
2. GET /customer/{id}/service-history
```

### 4. Quản lý Marketing
```
1. GET /customer/marketing/list
2. POST /customer/{id}/update-marketing?accept=true|false
```

## 🔄 Integration with Booking

### Tự động Cập nhật khi Booking
- `lastVisitDate`: Cập nhật thành thời gian hiện tại
- `totalSpent`: Cộng thêm tổng tiền của booking
- `visitCount`: Tăng lên 1

## 📈 Performance Considerations

### Indexes
```sql
CREATE INDEX idx_phone_number ON customer(phone_number);
CREATE INDEX idx_email ON customer(email);
CREATE INDEX idx_status ON customer(status);
CREATE INDEX idx_created_date ON customer(created_date);
```

### Query Optimization
- Sử dụng `LAZY` loading cho relationship `bookings`
- Pagination cho danh sách khách hàng lớn
- Cache cho top spenders

## 📚 Reference

- [Customer Management Guide](./CUSTOMER_MANAGEMENT_GUIDE.md)
- [Spring MVC Documentation](https://spring.io/projects/spring-framework)
- [Hibernate Documentation](https://hibernate.org/)

---

**API Version**: 1.0.0  
**Last Updated**: 2025-12-05
