package com.nailology.service;

import com.nailology.entity.Booking;
import com.nailology.entity.StaffAvailability;
import com.nailology.repository.BookingRepository;
import com.nailology.repository.StaffAvailabilityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.*;
import java.util.*;

@Service
@Transactional(readOnly = true)
public class BookingAvailabilityService {

    @Autowired
    private StaffAvailabilityRepository staffAvailabilityRepository;

    @Autowired
    private BookingRepository bookingRepository;

    // Giờ mở cửa mặc định nếu không có staff availability
    private static final LocalTime DEFAULT_OPEN = LocalTime.of(9, 0);
    private static final LocalTime DEFAULT_CLOSE = LocalTime.of(18, 0);
    private static final int SLOT_INTERVAL_MINUTES = 30;

    /**
     * Lấy danh sách khung giờ khả dụng cho chi nhánh và ngày cụ thể
     */
    public List<Map<String, Object>> getAvailableSlots(Long locationId, LocalDate date, int serviceDurationMinutes) {
        List<Map<String, Object>> result = new ArrayList<>();
        
        // Không cho đặt ngày trong quá khứ
        if (date.isBefore(LocalDate.now())) {
            return result;
        }

        // Lấy ngày trong tuần (1=Monday, 7=Sunday theo ISO)
        int dayOfWeek = date.getDayOfWeek().getValue();

        // Lấy lịch rảnh của nhân viên tại chi nhánh này vào ngày đó
        List<StaffAvailability> staffAvailabilities = staffAvailabilityRepository
            .findByLocationAndDayOfWeek(locationId, dayOfWeek);

        // Lấy các booking đã có trong ngày
        List<Booking> existingBookings = bookingRepository.findByLocationAndDate(locationId, date);

        // Tính các slot đã bị chiếm
        Set<LocalTime> bookedSlots = new HashSet<>();
        for (Booking b : existingBookings) {
            LocalTime start = b.getBookingTime();
            int duration = b.getTotalDurationMinutes() != null ? b.getTotalDurationMinutes() : 60;
            // Đánh dấu tất cả slot trong khoảng thời gian booking
            LocalTime current = start;
            while (current.isBefore(start.plusMinutes(duration))) {
                bookedSlots.add(current);
                current = current.plusMinutes(SLOT_INTERVAL_MINUTES);
            }
        }

        // Nếu có staff availability, dùng nó để tạo slots
        if (!staffAvailabilities.isEmpty()) {
            // Gộp tất cả khoảng thời gian có nhân viên rảnh
            Set<LocalTime> availableFromStaff = new TreeSet<>();
            for (StaffAvailability sa : staffAvailabilities) {
                LocalTime current = sa.getStartTime();
                while (current.plusMinutes(serviceDurationMinutes).compareTo(sa.getEndTime()) <= 0) {
                    availableFromStaff.add(current);
                    current = current.plusMinutes(SLOT_INTERVAL_MINUTES);
                }
            }

            // Tạo slots từ availability
            for (LocalTime slot : availableFromStaff) {
                boolean isAvailable = !isSlotConflict(slot, serviceDurationMinutes, bookedSlots);
                // Nếu là hôm nay, không hiển thị slot đã qua
                if (date.equals(LocalDate.now()) && slot.isBefore(LocalTime.now().plusMinutes(30))) {
                    continue;
                }
                Map<String, Object> slotInfo = new HashMap<>();
                slotInfo.put("time", slot.toString().substring(0, 5));
                slotInfo.put("available", isAvailable);
                result.add(slotInfo);
            }
        } else {
            // Fallback: dùng giờ mặc định
            LocalTime current = DEFAULT_OPEN;
            while (current.plusMinutes(serviceDurationMinutes).compareTo(DEFAULT_CLOSE) <= 0) {
                // Nếu là hôm nay, không hiển thị slot đã qua
                if (date.equals(LocalDate.now()) && current.isBefore(LocalTime.now().plusMinutes(30))) {
                    current = current.plusMinutes(SLOT_INTERVAL_MINUTES);
                    continue;
                }
                boolean isAvailable = !isSlotConflict(current, serviceDurationMinutes, bookedSlots);
                Map<String, Object> slotInfo = new HashMap<>();
                slotInfo.put("time", current.toString().substring(0, 5));
                slotInfo.put("available", isAvailable);
                result.add(slotInfo);
                current = current.plusMinutes(SLOT_INTERVAL_MINUTES);
            }
        }

        return result;
    }

    /**
     * Kiểm tra slot có xung đột với booking đã có không
     */
    private boolean isSlotConflict(LocalTime slotStart, int durationMinutes, Set<LocalTime> bookedSlots) {
        LocalTime current = slotStart;
        LocalTime end = slotStart.plusMinutes(durationMinutes);
        while (current.isBefore(end)) {
            if (bookedSlots.contains(current)) {
                return true;
            }
            current = current.plusMinutes(SLOT_INTERVAL_MINUTES);
        }
        return false;
    }

    /**
     * Kiểm tra một slot cụ thể có khả dụng không
     */
    public boolean isSlotAvailable(Long locationId, LocalDate date, LocalTime time, int serviceDurationMinutes) {
        // Không cho đặt ngày trong quá khứ
        if (date.isBefore(LocalDate.now())) {
            return false;
        }
        // Không cho đặt giờ đã qua trong ngày hôm nay
        if (date.equals(LocalDate.now()) && time.isBefore(LocalTime.now())) {
            return false;
        }

        // Kiểm tra có nhân viên rảnh không
        int dayOfWeek = date.getDayOfWeek().getValue();
        List<StaffAvailability> staffAvailabilities = staffAvailabilityRepository
            .findByLocationAndDayOfWeek(locationId, dayOfWeek);

        boolean hasStaffAvailable = false;
        for (StaffAvailability sa : staffAvailabilities) {
            if (!time.isBefore(sa.getStartTime()) && 
                !time.plusMinutes(serviceDurationMinutes).isAfter(sa.getEndTime())) {
                hasStaffAvailable = true;
                break;
            }
        }

        // Nếu không có staff availability data, cho phép đặt trong giờ mặc định
        if (staffAvailabilities.isEmpty()) {
            hasStaffAvailable = !time.isBefore(DEFAULT_OPEN) && 
                               !time.plusMinutes(serviceDurationMinutes).isAfter(DEFAULT_CLOSE);
        }

        if (!hasStaffAvailable) {
            return false;
        }

        // Kiểm tra không trùng booking khác
        return !bookingRepository.isSlotBooked(locationId, date, time);
    }
}
