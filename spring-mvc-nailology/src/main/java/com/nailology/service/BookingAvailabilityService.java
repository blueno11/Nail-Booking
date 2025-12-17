package com.nailology.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;  // Thêm import

import java.time.*;
import java.util.List;

@Service
@Transactional(readOnly = true)  // Chỉ đọc dữ liệu nên có thể dùng readOnly để tối ưu
public class BookingAvailabilityService {

    @Autowired
    private StaffAvailabilityService staffAvailabilityService;

    // Các method kiểm tra lịch rảnh...
}