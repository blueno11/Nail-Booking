package com.nailology.config;

import com.nailology.model.Announcement;
import com.nailology.model.GalleryItem;
import com.nailology.model.GalleryItemType;
import com.nailology.model.Location;
import com.nailology.model.LocationStatus;
import com.nailology.model.ServiceCategory;
import com.nailology.model.ServiceOffering;
import com.nailology.repository.AnnouncementRepository;
import com.nailology.repository.GalleryItemRepository;
import com.nailology.repository.LocationRepository;
import com.nailology.repository.ServiceOfferingRepository;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
public class DataInitializer implements CommandLineRunner {

    private final LocationRepository locationRepository;
    private final ServiceOfferingRepository serviceOfferingRepository;
    private final GalleryItemRepository galleryItemRepository;
    private final AnnouncementRepository announcementRepository;

    public DataInitializer(
            LocationRepository locationRepository,
            ServiceOfferingRepository serviceOfferingRepository,
            GalleryItemRepository galleryItemRepository,
            AnnouncementRepository announcementRepository) {
        this.locationRepository = locationRepository;
        this.serviceOfferingRepository = serviceOfferingRepository;
        this.galleryItemRepository = galleryItemRepository;
        this.announcementRepository = announcementRepository;
    }

    @Override
    @Transactional
    public void run(String... args) {
        List<Location> locations = ensureLocationsSeeded();
        seedServices(locations);
        seedGalleryItems();
        seedAnnouncements();
    }

    private List<Location> ensureLocationsSeeded() {
        if (locationRepository.count() > 0) {
            return locationRepository.findAll()
                    .stream()
                    .sorted(Comparator.comparing(Location::getDisplayOrder))
                    .collect(Collectors.toList());
        }

        List<Location> seed = new ArrayList<>();
        seed.add(buildLocation("Kew", "Kew", "3101",
                "160 Cotham Rd, Kew VIC 3101", "+61 3 9000 1234",
                "kew@nailology.com.au", LocationStatus.ACTIVE, 1));
        seed.add(buildLocation("Alphington", "Alphington", "3078",
                "28 Wingrove St, Alphington VIC 3078", "+61 3 9000 2234",
                "alphington@nailology.com.au", LocationStatus.ACTIVE, 2));
        seed.add(buildLocation("Truganina", "Truganina", "3029",
                "45 Leakes Rd, Truganina VIC 3029", "+61 3 9000 3234",
                "truganina@nailology.com.au", LocationStatus.ACTIVE, 3));
        seed.add(buildLocation("Hampton", "Hampton", "3188",
                "72 Hampton St, Hampton VIC 3188", "+61 3 9000 4234",
                "hampton@nailology.com.au", LocationStatus.ACTIVE, 4));
        seed.add(buildLocation("Bentleigh", "Bentleigh", "3204",
                "91 Centre Rd, Bentleigh VIC 3204", "+61 3 9000 5234",
                "bentleigh@nailology.com.au", LocationStatus.COMING_SOON, 5));

        return locationRepository.saveAll(seed);
    }

    private Location buildLocation(
            String name,
            String suburb,
            String postcode,
            String address,
            String phone,
            String email,
            LocationStatus status,
            int order) {
        Location location = new Location();
        location.setName(name);
        location.setSuburb(suburb);
        location.setPostcode(postcode);
        location.setAddress(address);
        location.setPhone(phone);
        location.setEmail(email);
        location.setStatus(status);
        location.setHighlight("Nails & Coffee Bar");
        location.setCoffeeAvailable(true);
        location.setDisplayOrder(order);
        return location;
    }

    private void seedServices(List<Location> locations) {
        if (serviceOfferingRepository.count() > 0) {
            return;
        }

        Map<String, Location> locationLookup = locations.stream()
                .collect(Collectors.toMap(Location::getName, l -> l));

        List<ServiceOffering> services = new ArrayList<>();
        services.add(builderGel("Builder Gel Overlay", "Classic builder base, TPO-free", "1 hr",
                60, new BigDecimal("75"), true, 1, locationLookup, ServiceCategory.HANDS));
        services.add(builderGel("Builder Gel Extensions", "Builder Gel kèm tips dài tự nhiên", "1 hr 30 min",
                90, new BigDecimal("110"), true, 2, locationLookup, ServiceCategory.HANDS));
        services.add(builderGel("Gel-X Extensions", "Form dáng nhanh, nhẹ, bảo vệ móng thật", "1 hr",
                60, new BigDecimal("77"), false, 3, locationLookup, ServiceCategory.HANDS));
        services.add(service("Dipping Powder (SNS)", ServiceCategory.HANDS, "Lớp bột mịn bền màu, không mùi gắt",
                "1 hr", 60, new BigDecimal("60"), false, 4, locationLookup));
        services.add(service("Gel Polish (Shellac)", ServiceCategory.HANDS, "Lớp gel bóng nhẹ, tháo dễ dàng",
                "1 hr", 60, new BigDecimal("45"), false, 5, locationLookup));
        services.add(service("Nail Polish", ServiceCategory.HANDS, "Sơn dưỡng nhanh dành cho lịch bận rộn",
                "45 min", 45, new BigDecimal("37"), false, 6, locationLookup));

        services.add(service("Nail Art - Simple", ServiceCategory.NAIL_ART, "Hoạ tiết đơn sắc / french / chrome nhẹ",
                "30 min", 30, new BigDecimal("25"), false, 1, locationLookup));
        services.add(service("Nail Art - Signature", ServiceCategory.NAIL_ART, "Thiết kế theo moodboard riêng",
                "1 hr", 60, new BigDecimal("50"), false, 2, locationLookup));
        services.add(service("Custom Editorial Set", ServiceCategory.NAIL_ART, "Lookbook runway, đính đá & airbrush",
                "1 hr 30 min", 90, new BigDecimal("75"), false, 3, locationLookup));

        services.add(service("Pedicure - Standard", ServiceCategory.FEET, "Ngâm thảo mộc + dưỡng ẩm cơ bản",
                "1 hr", 60, new BigDecimal("50"), false, 1, locationLookup));
        services.add(service("Pedicure - Gel", ServiceCategory.FEET, "Gel polish chống trầy, massage dài hơn",
                "1 hr 15 min", 75, new BigDecimal("65"), false, 2, locationLookup));
        services.add(service("Pedicure - Deluxe", ServiceCategory.FEET, "Tẩy tế bào chết + paraffin + reflexology",
                "1 hr 30 min", 90, new BigDecimal("85"), false, 3, locationLookup));

        serviceOfferingRepository.saveAll(services);
    }

    private ServiceOffering builderGel(
            String name,
            String description,
            String durationLabel,
            int durationMinutes,
            BigDecimal price,
            boolean featured,
            int order,
            Map<String, Location> locationLookup,
            ServiceCategory category) {
        ServiceOffering offering = service(name, category, description, durationLabel,
                durationMinutes, price, true, order, locationLookup);
        offering.setHomepageFeatured(featured);
        offering.setBuilderGel(true);
        return offering;
    }

    private ServiceOffering service(
            String name,
            ServiceCategory category,
            String description,
            String durationLabel,
            int durationMinutes,
            BigDecimal price,
            boolean featured,
            int order,
            Map<String, Location> locationLookup) {
        ServiceOffering offering = new ServiceOffering();
        offering.setName(name);
        offering.setCategory(category);
        offering.setCategoryLabel(category.name());
        offering.setDescription(description);
        offering.setDurationLabel(durationLabel);
        offering.setDurationMinutes(durationMinutes);
        offering.setStartingPrice(price);
        offering.setHomepageFeatured(featured);
        offering.setDisplayOrder(order);
        offering.setLocations(new HashSet<>(locationLookup.values()));
        return offering;
    }

    private void seedGalleryItems() {
        if (galleryItemRepository.count() > 0) {
            return;
        }

        List<GalleryItem> items = new ArrayList<>();
        items.add(galleryItem("Nail Art Hoa", "Pastel blooms & chrome dust", "/images/placeholder.jpg", 1));
        items.add(galleryItem("Ombre Gradient", "Blend màu sunrise", "/images/placeholder.jpg", 2));
        items.add(galleryItem("Geometric Pattern", "Line art tối giản", "/images/placeholder.jpg", 3));
        items.add(galleryItem("Glitter Sparkle", "Party-ready glitter tips", "/images/placeholder.jpg", 4));
        items.add(galleryItem("French Tip Classic", "French trắng sữa", "/images/placeholder.jpg", 5));
        items.add(galleryItem("Holographic Design", "Ánh kim futuristic", "/images/placeholder.jpg", 6));

        galleryItemRepository.saveAll(items);
    }

    private GalleryItem galleryItem(String title, String caption, String url, int order) {
        GalleryItem item = new GalleryItem();
        item.setTitle(title);
        item.setCaption(caption);
        item.setImageUrl(url);
        item.setType(GalleryItemType.PHOTO);
        item.setDisplayOrder(order);
        return item;
    }

    private void seedAnnouncements() {
        if (announcementRepository.count() > 0) {
            return;
        }

        Announcement announcement = new Announcement();
        announcement.setTitle("We're TPO Free");
        announcement.setContent("Tất cả builder gel tại Nailology hoàn toàn không chứa TPO và tuân thủ quy định EU mới nhất.");
        announcement.setCtaLabel("Tìm hiểu builder gels");
        announcement.setCtaUrl("#services");
        announcement.setStartDate(LocalDate.now().minusDays(7));
        announcement.setEndDate(LocalDate.now().plusMonths(6));
        announcement.setPriority(10);
        announcement.setActive(true);

        announcementRepository.save(announcement);
    }
}

