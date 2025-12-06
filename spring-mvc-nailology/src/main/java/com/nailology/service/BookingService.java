package com.nailology.service;

import com.nailology.model.BookingForm;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class BookingService {

    public List<com.nailology.model.Service> getAllServices() {
        List<com.nailology.model.Service> services = new ArrayList<>();
        
        // Hands services
        services.add(new com.nailology.model.Service(1, "Builder Gel", "This is for Builder Gel only. Additional charges for add-ons.", 75, "1 hr", "hands"));
        services.add(new com.nailology.model.Service(2, "Builder Gel with Extensions", "This is for Builder Gel with Extensions only.", 110, "1 hr 30 min", "hands"));
        services.add(new com.nailology.model.Service(3, "Gel-X Extensions", "This is for Gel-X Extensions only.", 77, "1 hr", "hands"));
        services.add(new com.nailology.model.Service(4, "Dipping Powder (SNS)", "This is for Dipping Powder only.", 60, "1 hr", "hands"));
        services.add(new com.nailology.model.Service(5, "Gel Polish (Shellac)", "This is for Gel Polish only.", 45, "1 hr", "hands"));
        services.add(new com.nailology.model.Service(6, "Nail Polish", "This is for Nail Polish only.", 37, "45 min", "hands"));
        
        // Nail Art services
        services.add(new com.nailology.model.Service(7, "Nail Art - Simple", "Simple nail art design", 25, "30 min", "nailArt"));
        services.add(new com.nailology.model.Service(8, "Nail Art - Complex", "Complex nail art design", 50, "1 hr", "nailArt"));
        services.add(new com.nailology.model.Service(9, "Custom Design", "Custom nail art design", 75, "1.5 hr", "nailArt"));
        
        // Feet services
        services.add(new com.nailology.model.Service(10, "Pedicure - Standard", "Standard pedicure service", 50, "1 hr", "feet"));
        services.add(new com.nailology.model.Service(11, "Pedicure - Gel", "Gel pedicure service", 65, "1 hr 15 min", "feet"));
        services.add(new com.nailology.model.Service(12, "Pedicure - Deluxe", "Deluxe pedicure with extras", 85, "1.5 hr", "feet"));
        
        return services;
    }

    public List<com.nailology.model.Service> getServicesByCategory(String category) {
        List<com.nailology.model.Service> allServices = getAllServices();
        List<com.nailology.model.Service> filtered = new ArrayList<>();
        for (com.nailology.model.Service service : allServices) {
            if (service.getCategory().equals(category)) {
                filtered.add(service);
            }
        }
        return filtered;
    }

    public void saveBooking(BookingForm bookingForm) {
        // TODO: Implement database persistence
        // For now, just log the booking
        System.out.println("Booking saved: " + bookingForm.getCustomerName());
    }
}

