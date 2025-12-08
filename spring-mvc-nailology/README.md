# Nailology - Spring MVC Web Application

Ứng dụng web Spring MVC cho tiệm nails & cà phê Nailology.

## Công Nghệ Sử Dụng

- **Java 21**
- **Spring MVC 5.3.23**
- **Hibernate 5.6.14**
- **MySQL 8.0**
- **Maven**
- **JSP/JSTL**

## Yêu Cầu Hệ Thống

- JDK 21+
- Apache Maven 3.6+
- Apache Tomcat 9.0+
- MySQL 8.0+
- Eclipse IDE (khuyến nghị)

## Cài Đặt

### 1. Clone Repository

```bash
git clone https://github.com/yourusername/nailology-web.git
cd nailology-web
```

### 2. Tạo Database

Chạy script SQL trong file `Nailology.txt` để tạo database:

```sql
CREATE DATABASE IF NOT EXISTS nailology
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE nailology;
-- ... (xem file Nailology.txt)
```

### 3. Cấu Hình Database

Cập nhật thông tin kết nối database trong file:
- `src/main/webapp/WEB-INF/applicationContext.xml`
- `src/main/resources/hibernate.cfg.xml`
- `src/main/resources/META-INF/persistence.xml`

Thay đổi:
- `username`: Tên người dùng MySQL
- `password`: Mật khẩu MySQL
- `url`: Địa chỉ database nếu khác localhost

### 4. Build Project

```bash
mvn clean install
```

### 5. Deploy lên Tomcat

1. Copy file `target/nailology.war` vào thư mục `webapps` của Tomcat
2. Hoặc deploy trực tiếp từ Eclipse

## Cấu Trúc Dự Án

```
spring-mvc-nailology/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/nailology/
│   │   │       ├── controller/     # Spring MVC Controllers
│   │   │       ├── entity/         # Hibernate Entities
│   │   │       ├── model/          # Data Models
│   │   │       ├── service/       # Business Logic
│   │   │       └── interceptor/   # Interceptors
│   │   ├── resources/
│   │   │   ├── hibernate.cfg.xml  # Hibernate Configuration
│   │   │   └── META-INF/
│   │   │       └── persistence.xml # JPA Configuration
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   ├── web.xml
│   │       │   ├── dispatcher-servlet.xml
│   │       │   ├── applicationContext.xml
│   │       │   └── views/         # JSP Views
│   │       └── css/               # CSS Files
│   └── test/
├── pom.xml
└── README.md
```

## Entities

- **Location**: Địa điểm tiệm
- **ServiceEntity**: Dịch vụ nails
- **GalleryItem**: Hình ảnh gallery
- **Announcement**: Thông báo
- **ContactMessage**: Tin nhắn liên hệ

## API Endpoints

- `GET /` - Trang chủ
- `GET /booking` - Trang đặt lịch
- `POST /booking/submit` - Submit booking
- `POST /contact/submit` - Submit contact form

## Lưu Ý

- **Không commit** file chứa thông tin nhạy cảm (passwords, API keys)
- **Không commit** file `.classpath`, `.project`, `.settings/` (đã có trong .gitignore)
- **Không commit** thư mục `target/` (build artifacts)

## License

Copyright © 2025 Nailology. All rights reserved.


