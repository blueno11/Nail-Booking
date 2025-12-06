# 🔄 Quản lý Giao dịch (Transaction Management) - Tài liệu

**Ngày Kích hoạt**: 05/12/2025  
**Phiên bản**: 1.0.0  
**Trạng thái**: ✅ ACTIVE

---

## 📋 Tổng Quan

Transaction Management (TM) đã được kích hoạt để đảm bảo tính toàn vẹn dữ liệu trong các thao tác cơ sở dữ liệu. Tất cả các service classes sử dụng `@Transactional` annotation để tự động quản lý transactions.

---

## ✅ Cấu Hình Được Kích Hoạt

### 1. Spring Transaction Manager
```xml
<!-- applicationContext.xml -->
<bean id="transactionManager" 
      class="org.springframework.orm.hibernate5.HibernateTransactionManager">
    <property name="sessionFactory" ref="sessionFactory"/>
</bean>

<!-- Enable với CGLIB Proxy -->
<tx:annotation-driven transaction-manager="transactionManager" 
                      proxy-target-class="true" 
                      mode="proxy"/>
```

### 2. Service Classes với @Transactional
```java
@Service
@Transactional
public class CustomerService { ... }

@Service
@Transactional
public class BookingService { ... }
```

### 3. Proxy Mode
- **proxy-target-class="true"**: Sử dụng CGLIB Proxy (hỗ trợ class-based proxies)
- **mode="proxy"**: Sử dụng Spring AOP proxy mode

---

## 🎯 Tính Năng

### ✅ Commit & Rollback Tự động
- ✅ Tự động commit khi method kết thúc thành công
- ✅ Tự động rollback khi exception xảy ra
- ✅ Không cần gọi `commit()` hoặc `rollback()` thủ công

### ✅ Propagation Control
```java
// Mặc định: REQUIRED
@Transactional(propagation = Propagation.REQUIRED)
public void createCustomer(Customer customer) { ... }

// Hoặc: REQUIRES_NEW (tạo transaction mới)
@Transactional(propagation = Propagation.REQUIRES_NEW)
public void updateCustomerSpent(Long id, Double amount) { ... }
```

### ✅ Isolation Level
```java
// Mặc định: DEFAULT (từ database)
@Transactional(isolation = Isolation.READ_COMMITTED)
public List<Customer> getAllCustomers() { ... }
```

### ✅ Read-only Optimization
```java
// Tối ưu cho SELECT queries
@Transactional(readOnly = true)
public Customer getCustomerById(Long id) { ... }
```

### ✅ Rollback Rules
```java
// Rollback khi exception xảy ra
@Transactional(rollbackFor = Exception.class)
public void saveBooking(Booking booking) { ... }

// Không rollback cho business exceptions
@Transactional(noRollbackFor = BusinessException.class)
public void processPayment(Payment payment) { ... }
```

### ✅ Timeout
```java
// Timeout 30 giây
@Transactional(timeout = 30)
public void longRunningOperation() { ... }
```

---

## 📊 Cấu Trúc Giao Dịch

### Luồng Thực Thi

```
Client Request
  ↓
Controller.handle()
  ↓
Service.@Transactional method
  ├─ BEGIN TRANSACTION
  ├─ Execute business logic
  ├─ Hibernate Session operations
  ├─ Database operations
  ├─ Either:
  │  ├─ COMMIT (if success)
  │  └─ ROLLBACK (if exception)
  └─ END TRANSACTION
  ↓
Response to Client
```

### Ví dụ: Tạo Booking với Khách hàng

```java
// CustomerService.java
@Transactional
public Long saveOrUpdateCustomer(Customer customer) {
    Session session = sessionFactory.getCurrentSession();
    
    if (customer.getId() == null) {
        customer.setCreatedDate(new Date());
        customer.setStatus("ACTIVE");
    }
    
    // INSERT hoặc UPDATE
    Long customerId = (Long) session.merge(customer).getId();
    // ✅ Tự động COMMIT nếu thành công
    // ❌ Tự động ROLLBACK nếu có exception
    
    return customerId;
}

// BookingService.java
@Transactional
public void saveBooking(BookingForm form) {
    // Tất cả thao tác trong 1 transaction:
    // 1. Tạo Booking
    // 2. Update Customer lastVisitDate
    // 3. Update Customer totalSpent
    // Nếu bất kỳ thao tác nào thất bại → ROLLBACK tất cả
}
```

---

## 🔒 Isolation Levels

### Được Hỗ Trợ

| Level | Tên | Mô tả |
|-------|-----|-------|
| 0 | DEFAULT | Mặc định từ database |
| 1 | READ_UNCOMMITTED | Dirty reads (không khuyến khích) |
| 2 | READ_COMMITTED | Mặc định MySQL (khuyến khích) |
| 3 | REPEATABLE_READ | MySQL default |
| 4 | SERIALIZABLE | Cao nhất (chậm nhất) |

### Khuyến cáo
```java
// Cho tất cả reads
@Transactional(readOnly = true, 
               isolation = Isolation.READ_COMMITTED)
public Customer getCustomerById(Long id) { ... }

// Cho writes quan trọng
@Transactional(readOnly = false, 
               isolation = Isolation.REPEATABLE_READ)
public Long saveCustomer(Customer customer) { ... }
```

---

## ⚙️ Các Propagation Types

### 1. REQUIRED (Mặc định)
```java
@Transactional(propagation = Propagation.REQUIRED)
public void method1() {
    // Nếu có transaction rồi → Sử dụng
    // Nếu chưa → Tạo mới
}
```

### 2. REQUIRES_NEW
```java
@Transactional(propagation = Propagation.REQUIRES_NEW)
public void method2() {
    // Luôn tạo transaction mới
    // Suspend transaction cũ (nếu có)
}
```

### 3. NESTED
```java
@Transactional(propagation = Propagation.NESTED)
public void method3() {
    // Tạo savepoint trong transaction hiện tại
    // Rollback chỉ ảnh hưởng nested part
}
```

### 4. SUPPORTS
```java
@Transactional(propagation = Propagation.SUPPORTS)
public void method4() {
    // Tham gia transaction nếu có
    // Không tạo nếu chưa
}
```

---

## 🚨 Rollback Rules

### Cách 1: Rollback cho All Exceptions (Mặc định)
```java
@Transactional
public void saveCustomer(Customer customer) {
    // Tự động rollback cho bất kỳ exception nào
    customerService.save(customer);
}
```

### Cách 2: Custom Rollback Rules
```java
@Transactional(
    rollbackFor = { IOException.class, SQLException.class },
    noRollbackFor = { BusinessException.class }
)
public void process() {
    // Rollback cho IOException, SQLException
    // Không rollback cho BusinessException
}
```

### Cách 3: Cắt ngang Rollback
```java
@Transactional
public void process() {
    try {
        riskyOperation();
    } catch (Exception e) {
        // Ngăn rollback
        TransactionAspectSupport
            .currentTransactionStatus()
            .setRollbackOnly();
    }
}
```

---

## 📈 Hiệu Năng

### Tối ưu Hóa

#### 1. Read-only Transactions
```java
@Transactional(readOnly = true)
public List<Customer> getAllCustomers() {
    // Hibernate tối ưu cho read-only
    // Không tracking changes
    // Tốc độ nhanh hơn
    return session.createQuery(...).getResultList();
}
```

#### 2. Propagation Mức Thấp
```java
// Sử dụng SUPPORTS thay vì REQUIRED
// Nếu không cần transaction mới
@Transactional(propagation = Propagation.SUPPORTS)
public Customer findCustomer(Long id) { ... }
```

#### 3. Timeout
```java
@Transactional(timeout = 30) // 30 giây
public void longOperation() {
    // Tự động rollback nếu vượt 30s
}
```

### Performance Tips
- ✅ Sử dụng `readOnly = true` cho SELECTs
- ✅ Giảm scope của `@Transactional` (chỉ apply trên methods cần)
- ✅ Batch operations trong 1 transaction
- ✅ Avoid nested transactions nếu có thể

---

## 🔍 Debugging & Monitoring

### Enable SQL Logging
```xml
<!-- applicationContext.xml -->
<prop key="hibernate.show_sql">true</prop>
<prop key="hibernate.format_sql">true</prop>
```

### Log4j Configuration
```
log4j.logger.org.springframework.transaction=DEBUG
log4j.logger.org.hibernate.engine.transaction=DEBUG
```

### Ví dụ Log Output
```
[TRACE] Creating new transaction with name [com.nailology.service.CustomerService.saveOrUpdateCustomer]
[DEBUG] BEGIN TRANSACTION
[INFO] Hibernate: INSERT INTO customer (full_name, phone_number, ...) VALUES (...)
[DEBUG] COMMIT
[TRACE] Completing transaction for [com.nailology.service.CustomerService.saveOrUpdateCustomer]
```

---

## ⚠️ Common Mistakes

### ❌ Mistake 1: Gọi Save trực tiếp từ Controller
```java
// ❌ WRONG: Không có transaction
@Controller
public class CustomerController {
    @PostMapping("/save")
    public String save(Customer customer) {
        // Không transaction → Lỗi
        customer.setId(null);
        session.save(customer); // Error!
    }
}
```

**✅ FIX:**
```java
@Controller
public class CustomerController {
    @PostMapping("/save")
    public String save(Customer customer) {
        // Gọi service (có @Transactional)
        customerService.saveOrUpdateCustomer(customer);
        return "redirect:/customer";
    }
}
```

### ❌ Mistake 2: Lazy Load Outside Transaction
```java
// ❌ WRONG
@Transactional(readOnly = true)
public Customer getCustomer(Long id) {
    return session.get(Customer.class, id);
}

// Sau khi method return, transaction đóng
customer.getBookings().size(); // ❌ LazyInitializationException
```

**✅ FIX:**
```java
// Fetch eagerly
@Transactional(readOnly = true)
public Customer getCustomerWithBookings(Long id) {
    return session.createQuery(
        "SELECT c FROM Customer c LEFT JOIN FETCH c.bookings WHERE c.id = :id",
        Customer.class
    ).setParameter("id", id).getSingleResult();
}
```

### ❌ Mistake 3: Transaction quá dài
```java
// ❌ WRONG: Transaction bao hàm business logic
@Transactional
public String processRequest() {
    Customer c = saveCustomer();
    sendEmail(c); // ❌ Lâu, hold lock
    return "success";
}
```

**✅ FIX:**
```java
// Transaction chỉ cho DB operations
@Transactional
public Customer saveCustomer() { ... }

public String processRequest() {
    Customer c = saveCustomer(); // ✅ Transaction
    sendEmail(c); // ✅ Ngoài transaction
    return "success";
}
```

---

## ✅ Best Practices

### 1. Service Level Transactions
```java
@Service
@Transactional
public class CustomerService {
    @Transactional(readOnly = true)
    public Customer getCustomerById(Long id) { ... }
    
    @Transactional(readOnly = false)
    public Long saveCustomer(Customer c) { ... }
}
```

### 2. Method-level Override
```java
@Transactional
public class BookingService {
    // Inherits class-level @Transactional
    public void createBooking() { ... }
    
    // Override for read-only
    @Transactional(readOnly = true)
    public Booking getBooking(Long id) { ... }
    
    // Custom propagation
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void updateStats() { ... }
}
```

### 3. Exception Handling
```java
@Transactional
public void processBooking(Booking b) throws BookingException {
    try {
        saveBooking(b);
        updateInventory(b);
    } catch (InventoryException e) {
        // ✅ Auto-rollback booking
        throw new BookingException("Inventory unavailable", e);
    }
}
```

### 4. Batch Operations
```java
@Transactional
public void bulkUpdateCustomers(List<Customer> customers) {
    for (int i = 0; i < customers.size(); i++) {
        session.merge(customers.get(i));
        
        // Flush mỗi 50 records
        if (i % 50 == 0) {
            session.flush();
            session.clear();
        }
    }
}
```

---

## 📞 Troubleshooting

### Issue: LazyInitializationException
```
org.hibernate.LazyInitializationException: 
  could not initialize proxy - no Session
```
**Solution**: Fetch eagerly hoặc đảm bảo transaction vẫn active

### Issue: Deadlock
```
Deadlock found when trying to get a lock; try restarting transaction
```
**Solution**: Giảm thời gian transaction, optimize indexes

### Issue: Transaction Timeout
```
Transaction timeout after 30 seconds
```
**Solution**: Tăng timeout hoặc optimize query

---

## 📊 Status Check

### Verify Transaction is Active
```java
@Transactional
public void verify() {
    TransactionStatus status = 
        TransactionAspectSupport.currentTransactionStatus();
    
    System.out.println("Is Active: " + status.isCompleted());
    System.out.println("Is New: " + status.isNewTransaction());
    System.out.println("Has Savepoint: " + status.hasSavepoint());
}
```

---

## 🎓 Learning Resources

### Docs
- [Spring Transaction Management](https://spring.io/guides/gs/managing-transactions/)
- [Hibernate Transactions](https://docs.jboss.org/hibernate/orm/5.6/userguide/html_single/Hibernate_User_Guide.html#transactions)

### Examples in Code
- `CustomerService.java` - @Transactional usage
- `BookingService.java` - Transaction management
- `applicationContext.xml` - Transaction config

---

## ✅ Checklist

### Ngày Kích hoạt
- [x] TransactionManager bean configured
- [x] @Transactional annotations added
- [x] CGLIB proxy mode enabled
- [x] Hibernateconfig updated
- [x] All services have @Transactional
- [x] Testing completed
- [x] Documentation done

### Regular Checks
- [ ] Monitor transaction logs
- [ ] Check for deadlocks
- [ ] Optimize long-running transactions
- [ ] Review timeout settings

---

**Status**: ✅ PRODUCTION READY  
**Last Updated**: 05/12/2025  
**Next Review**: 30 days
