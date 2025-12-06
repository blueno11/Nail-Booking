# 🎨 Nailology Customer Management - Modern UI & CRUD Operations

## Overview
The Customer Management module now features a modern, elegant interface inspired by Nailology's premium brand aesthetic. All CRUD operations have been redesigned with a card-based layout, smooth animations, and professional styling.

---

## 📋 CRUD Operations Available

### 1. **CREATE** - Thêm Khách Hàng (Add Customer)
**Endpoint:** `GET /customer/create`

**Features:**
- Clean form with organized sections
- Required field validation
- Input with placeholders for guidance
- Error message display
- Responsive design

**Fields:**
- Tên Khách Hàng (Full Name) - Required ⭐
- Số Điện Thoại (Phone) - Required ⭐
- Email (Optional)
- Địa Chỉ (Address) - Optional
- Ngày Sinh (Date of Birth) - Optional
- Nhận Marketing (Marketing Preference) - Checkbox
- Ghi Chú (Notes) - Optional

**UI Components:**
```
Header with icon: ➕ Thêm Khách Hàng
Card 1: 👤 Thông Tin Cơ Bản
Card 2: ⚙️ Tùy Chọn
Card 3: 📝 Ghi Chú
Action Buttons: [💾 Lưu Khách Hàng] [← Quay Lại]
```

---

### 2. **READ** - Xem Danh Sách Khách Hàng (View Customer List)
**Endpoint:** `GET /customer`

**Features:**
- Card-based grid layout (responsive)
- Search functionality
- Filter options
- Statistics dashboard
- Quick navigation links

**Display:**
- Customer name with ID
- Phone number & email
- Total spending (formatted currency)
- Status badge (Active/Inactive/Blacklist)
- Marketing preference indicator
- Action buttons (View Detail, Edit)

**Special Views:**
- `GET /customer/top-spenders` - 👑 Top 10 Chi Tiêu Cao Nhất
- `GET /customer/new-customers` - ✨ Khách Hàng Mới
- `GET /customer/marketing/list` - 📧 Danh Sách Marketing

**UI Components:**
```
Header: Khách Hàng + [+ Thêm Khách Hàng]
Stats: [Hoạt Động Count] [Tổng Khách Count]
Search Bar: Input + [🔍 Tìm Kiếm] [Xoá Bộ Lọc] [👑 Top] [✨ Mới]
Customer Cards Grid:
  ├─ Card Header: Name & ID
  ├─ Card Body: Contact, Spending, Status, Marketing
  └─ Card Footer: [Xem Chi Tiết] [Chỉnh Sửa]
```

---

### 3. **READ (Detail)** - Xem Chi Tiết Khách Hàng (View Customer Profile)
**Endpoint:** `GET /customer/{id}`

**Features:**
- Comprehensive customer profile
- Statistics overview
- Service history (recent 5)
- Status management
- Marketing preference toggle

**Display Sections:**
1. **Header Section**
   - Customer name (prominent)
   - ID and registration date
   - Action buttons

2. **Statistics Card** (📊)
   - Visit count
   - Total spending
   - Last visit date

3. **Basic Info Card** (👤)
   - Phone, Email, Address
   - Date of Birth
   - Notes

4. **Status & Preferences Card** (⚙️)
   - Status badge (Active/Inactive/Blacklist)
   - Marketing preference
   - Toggle button for marketing

5. **Service History Card** (📅)
   - Recent bookings (table format)
   - Booking date/time
   - Status & total amount
   - Link to booking details

**Metadata**
- Account creation timestamp
- Last visit timestamp

**Action Buttons:**
```
[✎ Chỉnh Sửa] [📋 Lịch Sử] [🗑️ Xoá] [← Quay Lại]
```

---

### 4. **UPDATE** - Chỉnh Sửa Khách Hàng (Edit Customer)
**Endpoint:** `GET /customer/{id}/edit` → `POST /customer/save`

**Features:**
- Pre-populated form with existing data
- All fields editable
- Validation on save
- Error handling with clear messages
- Same UI structure as Create

**Additional Operations:**

#### 4a. Update Marketing Preference
**Endpoint:** `POST /customer/{id}/update-marketing`
- Toggle marketing subscription
- Instant update
- Status reflected in detail view

#### 4b. Update Customer Status
**Endpoint:** `POST /customer/{id}/update-status`
- Change status (ACTIVE → INACTIVE → BLACKLIST)
- Validation of status values
- Audit trail on customer profile

#### 4c. Update Service History Link
**Endpoint:** `GET /customer/{id}/service-history`
- View complete booking history
- Filter and sort options
- Analytics on service preferences

---

### 5. **DELETE** - Xóa Khách Hàng (Delete Customer)
**Endpoint:** `POST /customer/{id}/delete`

**Features:**
- Delete button on detail view
- Confirmation dialog with warning
- Permanent deletion (cannot be undone)
- Redirect to list after deletion
- Success notification

**Implementation:**
```javascript
function deleteCustomer() {
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = '/customer/{id}/delete';
    document.body.appendChild(form);
    form.submit();
}
```

**Confirmation Prompt:**
```
"Bạn có chắc chắn muốn xoá khách hàng này? 
Hành động này không thể hoàn tác."
```

---

## 🎨 Design System

### Color Palette
- **Primary:** #c4a080 (Premium Brown/Gold)
- **Dark:** #3d3d3d (Text Color)
- **Accent:** #d4af9e (Light Accent)
- **Light BG:** #f5f1ed (Background)
- **Success:** #28a745 (Green)
- **Danger:** #dc3545 (Red)

### Typography
- **Headings:** Playfair Display (serif, elegant)
- **Body:** Lora (serif, readable)

### Components
- **Cards:** Rounded corners, subtle shadows, left border accent
- **Buttons:** Gradient backgrounds, hover animations, icons
- **Badges:** Status indicators with color coding
- **Forms:** Clean input fields, focus states, placeholders
- **Tables:** Striped rows, hover effects, responsive

### Spacing & Layout
- Container max-width: 1400px
- 40px padding on pages
- 25px margin between cards
- 12px padding in inputs
- Responsive breakpoint: 768px

---

## 🔄 Related Operations

### Booking Linkage
**Endpoint:** `GET /customer/select-for-booking`
- Select existing customer or create new
- Used during booking creation workflow
- Filtered search with active customers
- Quick customer creation

### Booking Creation with Customer
**Endpoint:** `POST /customer/create-from-booking`
- Create new customer from booking process
- Redirect back to booking with customer ID
- Streamlined workflow

---

## ✨ UI Highlights

### Modern Features
1. **Gradient Backgrounds** - Linear gradients for premium feel
2. **Smooth Animations** - Hover effects, transitions, transforms
3. **Icon Usage** - Visual indicators for quick recognition
4. **Card-based Layout** - Organized information hierarchy
5. **Responsive Design** - Mobile-friendly grid and forms
6. **Empty States** - Friendly messages when no data
7. **Status Badges** - Color-coded status indicators
8. **Marketing Toggle** - Quick preference switching
9. **Delete Confirmation** - Safety with confirmation dialogs
10. **Metadata Display** - Timestamps for transparency

### Accessibility
- Clear labels on all form fields
- Required field indicators (*)
- Error messages positioned clearly
- Keyboard navigation support
- Semantic HTML structure
- Proper contrast ratios

---

## 🚀 Performance Considerations

### Lazy Loading
- Bookings collection initialized in service layer
- Prevents LazyInitializationException
- Efficient database queries

### Validation
- Server-side validation on save
- Phone number uniqueness check
- Required field validation
- Email format validation

### Error Handling
- Graceful error messages
- Form preservation on error
- Clear user feedback

---

## 📱 Mobile Responsiveness

- **Desktop:** Full-featured grid layout
- **Tablet:** Adjusted grid (2-3 columns)
- **Mobile:** Single column, stacked buttons
- **Touch-friendly:** Larger tap targets (min 44px)

---

## 🔐 Security Features

- CSRF protection via Spring framework
- Input sanitization
- Authorization checks
- Confirmation dialogs for destructive actions
- Audit logging via createdDate/lastVisitDate

---

## 📊 Data Integrity

### Customer Entity Fields
- `id` (Long) - Primary key
- `fullName` (String) - Required
- `phoneNumber` (String) - Unique, Required
- `email` (String) - Optional, Format validated
- `address` (String) - Optional
- `dateOfBirth` (Date) - Optional, Format: yyyy-MM-dd
- `isAcceptMarketing` (boolean) - Default: true
- `createdDate` (Date) - Auto-set
- `lastVisitDate` (Date) - Updated on booking
- `totalSpent` (Double) - Calculated
- `notes` (String) - Optional
- `status` (String) - ACTIVE/INACTIVE/BLACKLIST
- `bookings` (List<Booking>) - One-to-many relationship

---

## 🎯 Summary

The new Customer Management interface provides a complete CRUD system with modern, elegant UI design that matches Nailology's premium brand. All operations are intuitive, responsive, and include proper validation, error handling, and user feedback.

**Key Endpoints:**
- `GET /customer` - List all customers
- `GET /customer/create` - Create form
- `POST /customer/save` - Save customer
- `GET /customer/{id}` - View detail
- `GET /customer/{id}/edit` - Edit form
- `POST /customer/{id}/delete` - Delete customer
- `POST /customer/{id}/update-marketing` - Toggle marketing
- `GET /customer/{id}/service-history` - View history
- `GET /customer/top-spenders` - Top spenders list
- `GET /customer/new-customers` - New customers list
