package com.nailology.service;

import com.nailology.entity.Booking;
import com.nailology.entity.Booking.BookingStatus;
import com.nailology.entity.Location;
import com.nailology.entity.ServiceEntity;
import com.nailology.model.BookingForm;
import com.nailology.model.Service;
import com.nailology.repository.BookingRepository;
import com.nailology.repository.LocationRepository;
import com.nailology.repository.ServiceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@org.springframework.stereotype.Service
@Transactional
public class BookingService {

    @Autowired
    private BookingRepository bookingRepository;

    @Autowired
    private LocationRepository locationRepository;

    @Autowired
    private ServiceRepository serviceRepository;

    @Transactional(readOnly = true)
    public List<Service> getAllServices() {
        List<ServiceEntity> entities = serviceRepository.findAll();
        if (entities.isEmpty()) {
            return getDefaultServices();
        }
        return entities.stream().map(this::convertToModel).collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<Location> getAllLocations() {
        return locationRepository.findAllActive();
    }

    @Transactional
    public Booking saveBooking(BookingForm form) {
        Booking booking = new Booking();
        booking.setCustomerName(form.getCustomerName());
        booking.setEmail(form.getEmail());
        booking.setPhone(form.getPhone());
        booking.setMessage(form.getMessage());

        // Set location
        if (form.getLocationId() != null) {
            Location location = locationRepository.findById(form.getLocationId())
                .orElseThrow(() -> new RuntimeException("Location not found"));
            booking.setLocation(location);
        }

        // Parse date and time
        if (form.getDate() != null && !form.getDate().isEmpty()) {
            booking.setBookingDate(LocalDate.parse(form.getDate()));
        }
        if (form.getTime() != null && !form.getTime().isEmpty()) {
            booking.setBookingTime(LocalTime.parse(form.getTime()));
        }

        // Process services
        if (form.getSelectedServiceIds() != null && !form.getSelectedServiceIds().isEmpty()) {
            List<Long> serviceIds = form.getSelectedServiceIds().stream()
                .map(Long::valueOf).collect(Collectors.toList());
            List<ServiceEntity> services = serviceRepository.findByIds(serviceIds);
            
            String ids = services.stream().map(s -> s.getId().toString()).collect(Collectors.joining(","));
            String names = services.stream().map(ServiceEntity::getName).collect(Collectors.joining(", "));
            BigDecimal total = services.stream()
                .map(s -> s.getStartingPrice() != null ? s.getStartingPrice() : BigDecimal.ZERO)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
            int duration = services.stream()
                .mapToInt(s -> s.getDurationMinutes() != null ? s.getDurationMinutes() : 0)
                .sum();

            booking.setServiceIds(ids);
            booking.setServiceNames(names);
            booking.setTotalPrice(total);
            booking.setTotalDurationMinutes(duration);
        }

        booking.setStatus(BookingStatus.PENDING);
        return bookingRepository.save(booking);
    }

    @Transactional(readOnly = true)
    public Optional<Booking> findByBookingCode(String code) {
        return bookingRepository.findByBookingCode(code);
    }

    @Transactional(readOnly = true)
    public List<Booking> findByEmail(String email) {
        return bookingRepository.findByEmail(email);
    }

    @Transactional(readOnly = true)
    public List<Booking> findByEmailAndPhone(String email, String phone) {
        return bookingRepository.findByEmailAndPhone(email, phone);
    }

    @Transactional
    public Booking updateBooking(Long id, BookingForm form) {
        Booking booking = bookingRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Booking not found"));
        
        if (booking.getStatus() == BookingStatus.CANCELLED || booking.getStatus() == BookingStatus.COMPLETED) {
            throw new RuntimeException("Cannot update cancelled or completed booking");
        }

        if (form.getDate() != null && !form.getDate().isEmpty()) {
            booking.setBookingDate(LocalDate.parse(form.getDate()));
        }
        if (form.getTime() != null && !form.getTime().isEmpty()) {
            booking.setBookingTime(LocalTime.parse(form.getTime()));
        }
        if (form.getLocationId() != null) {
            Location location = locationRepository.findById(form.getLocationId())
                .orElseThrow(() -> new RuntimeException("Location not found"));
            booking.setLocation(location);
        }
        if (form.getMessage() != null) {
            booking.setMessage(form.getMessage());
        }

        return bookingRepository.save(booking);
    }

    @Transactional
    public void cancelBooking(String bookingCode) {
        Booking booking = bookingRepository.findByBookingCode(bookingCode)
            .orElseThrow(() -> new RuntimeException("Booking not found"));
        booking.setStatus(BookingStatus.CANCELLED);
        bookingRepository.save(booking);
    }

    public List<String> getAvailableTimeSlots() {
        List<String> slots = new ArrayList<>();
        slots.add("09:00");
        slots.add("09:30");
        slots.add("10:00");
        slots.add("10:30");
        slots.add("11:00");
        slots.add("11:30");
        slots.add("12:00");
        slots.add("12:30");
        slots.add("13:00");
        slots.add("13:30");
        slots.add("14:00");
        slots.add("14:30");
        slots.add("15:00");
        slots.add("15:30");
        slots.add("16:00");
        slots.add("16:30");
        slots.add("17:00");
        return slots;
    }


    private Service convertToModel(ServiceEntity entity) {
        Service service = new Service();
        service.setId(entity.getId().intValue());
        service.setName(entity.getName());
        service.setDescription(entity.getDescription());
        service.setPrice(entity.getStartingPrice() != null ? entity.getStartingPrice().doubleValue() : 0);
        service.setDuration(entity.getDurationLabel() != null ? entity.getDurationLabel() : 
            (entity.getDurationMinutes() != null ? entity.getDurationMinutes() + " min" : ""));
        service.setCategory(entity.getCategory());
        return service;
    }

    private List<Service> getDefaultServices() {
        List<Service> services = new ArrayList<>();
        services.add(new Service(1, "Builder Gel", "This is for Builder Gel only.", 75, "1 hr", "hands"));
        services.add(new Service(2, "Builder Gel with Extensions", "Builder Gel with Extensions.", 110, "1 hr 30 min", "hands"));
        services.add(new Service(3, "Gel-X Extensions", "Gel-X Extensions only.", 77, "1 hr", "hands"));
        services.add(new Service(4, "Dipping Powder (SNS)", "Dipping Powder only.", 60, "1 hr", "hands"));
        services.add(new Service(5, "Gel Polish (Shellac)", "Gel Polish only.", 45, "1 hr", "hands"));
        services.add(new Service(6, "Nail Polish", "Nail Polish only.", 37, "45 min", "hands"));
        services.add(new Service(7, "Nail Art - Simple", "Simple nail art design", 25, "30 min", "nailArt"));
        services.add(new Service(8, "Nail Art - Complex", "Complex nail art design", 50, "1 hr", "nailArt"));
        services.add(new Service(9, "Custom Design", "Custom nail art design", 75, "1.5 hr", "nailArt"));
        services.add(new Service(10, "Pedicure - Standard", "Standard pedicure service", 50, "1 hr", "feet"));
        services.add(new Service(11, "Pedicure - Gel", "Gel pedicure service", 65, "1 hr 15 min", "feet"));
        services.add(new Service(12, "Pedicure - Deluxe", "Deluxe pedicure with extras", 85, "1.5 hr", "feet"));
        return services;
    }
}
