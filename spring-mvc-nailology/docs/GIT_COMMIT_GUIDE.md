# Hướng Dẫn Commit Chuyên Nghiệp

## 🎯 Nguyên Tắc Commit

1. **Atomic commits** - Mỗi commit chỉ làm 1 việc
2. **Không commit build artifacts** (target/, *.class)
3. **Không commit sensitive data** (passwords, API keys)
4. **Viết message rõ ràng** theo chuẩn Conventional Commits

---

## 📝 Chuẩn Conventional Commits

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

### Types phổ biến:
| Type | Mô tả |
|------|-------|
| `feat` | Tính năng mới |
| `fix` | Sửa bug |
| `docs` | Thay đổi documentation |
| `style` | Format code (không ảnh hưởng logic) |
| `refactor` | Refactor code |
| `test` | Thêm/sửa tests |
| `chore` | Cập nhật build, config |

---

## 🚀 Các Lệnh Commit Cho Dự Án Này

### Bước 1: Kiểm tra status
```bash
git status
```

### Bước 2: Commit theo từng nhóm chức năng

**Commit 1: Entity và Repository (Backend core)**
```bash
git add src/main/java/com/nailology/entity/Booking.java
git add src/main/java/com/nailology/repository/
git commit -m "feat(booking): add Booking entity and repositories

- Add Booking entity with status enum (PENDING, CONFIRMED, CANCELLED, COMPLETED)
- Add BookingRepository for CRUD operations
- Add LocationRepository and ServiceRepository"
```

**Commit 2: Service layer**
```bash
git add src/main/java/com/nailology/service/BookingService.java
git add src/main/java/com/nailology/model/BookingForm.java
git commit -m "feat(booking): implement BookingService with transaction support

- Add saveBooking, updateBooking, cancelBooking methods
- Add search by email, phone, booking code
- Add @Transactional annotations for proper transaction management"
```

**Commit 3: Controller**
```bash
git add src/main/java/com/nailology/controller/BookingController.java
git commit -m "feat(booking): add BookingController with full CRUD endpoints

- GET /booking - booking form page
- POST /booking/submit - save new booking
- POST /booking/search - search bookings
- POST /booking/update/{id} - update booking
- POST /booking/cancel/{code} - cancel booking"
```

**Commit 4: Views (JSP)**
```bash
git add src/main/webapp/WEB-INF/views/booking.jsp
git add src/main/webapp/WEB-INF/views/booking-success.jsp
git add src/main/webapp/WEB-INF/views/booking-manage.jsp
git add src/main/webapp/WEB-INF/views/booking-list.jsp
git add src/main/webapp/WEB-INF/views/booking-detail.jsp
git commit -m "feat(booking): add booking JSP views

- booking.jsp: 3-step booking form (services, datetime, info)
- booking-success.jsp: success page with booking code
- booking-manage.jsp: search form (by code or email)
- booking-list.jsp: list of bookings
- booking-detail.jsp: booking details with edit/cancel"
```

**Commit 5: Filter và Config**
```bash
git add src/main/java/com/nailology/filter/
git add src/main/webapp/WEB-INF/web.xml
git add src/main/webapp/WEB-INF/dispatcher-servlet.xml
git add src/main/webapp/WEB-INF/applicationContext.xml
git commit -m "chore(config): add encoding filter and fix Spring context

- Add CharacterEncodingFilter for UTF-8 support
- Fix component scan to avoid duplicate beans
- Separate controller scan from service/repository scan"
```

**Commit 6: CSS**
```bash
git add src/main/webapp/css/style.css
git commit -m "style(booking): add CSS for booking pages

- Add booking steps indicator
- Add time slots grid
- Add booking cards and status badges
- Add search tabs styling"
```

**Commit 7: Database schema**
```bash
git add Nailology.txt
git commit -m "docs(db): add bookings table schema"
```

**Commit 8: Documentation**
```bash
git add docs/
git commit -m "docs: add booking feature documentation

- Add BOOKING_FEATURE_SUMMARY.md with architecture overview
- Add GIT_COMMIT_GUIDE.md for commit best practices"
```

---

## ⚡ Lệnh Nhanh (Nếu muốn commit tất cả 1 lần)

```bash
# Thêm tất cả file (trừ những file trong .gitignore)
git add .

# Commit với message tổng hợp
git commit -m "feat(booking): implement complete booking system

Features:
- 3-step booking form (services, datetime, customer info)
- Save booking to database with unique booking code
- Search bookings by code, email, or phone
- View, update, and cancel bookings
- UTF-8 encoding support for Vietnamese

Technical:
- Add Booking entity with Hibernate mapping
- Add Repository layer for data access
- Add Service layer with transaction management
- Add Controller with REST-like endpoints
- Add JSP views with responsive design
- Fix Spring context configuration"
```

---

## 🔍 Kiểm Tra Trước Khi Push

```bash
# Xem lịch sử commit
git log --oneline -10

# Xem diff của commit cuối
git show --stat

# Push lên remote
git push origin main
```

---

## ❌ Những Thứ KHÔNG NÊN Commit

1. **target/** - Build artifacts
2. ***.class** - Compiled files
3. **applicationContext.xml** - Chứa DB password
4. **hibernate.cfg.xml** - Chứa DB password
5. **.settings/** - IDE settings
6. **.classpath, .project** - Eclipse files

**Tip:** Tạo file `.example` cho config files:
```bash
cp applicationContext.xml applicationContext.xml.example
# Xóa password trong .example file
# Commit .example file, ignore file gốc
```

---

## 📌 Git Aliases Hữu Ích

Thêm vào `~/.gitconfig`:
```ini
[alias]
    st = status
    co = checkout
    br = branch
    ci = commit
    lg = log --oneline --graph --decorate -10
    last = log -1 HEAD --stat
```

Sử dụng:
```bash
git st      # thay vì git status
git lg      # xem log đẹp
git last    # xem commit cuối
```
