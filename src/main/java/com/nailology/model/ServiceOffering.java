package com.nailology.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "services")
public class ServiceOffering {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private String categoryLabel;

    @Enumerated(EnumType.STRING)
    private ServiceCategory category;

    @Column(length = 800)
    private String description;

    @Column(name = "duration_label")
    private String durationLabel;

    @Column(name = "duration_minutes")
    private Integer durationMinutes;

    @Column(name = "starting_price")
    private BigDecimal startingPrice;

    @Column(name = "homepage_featured")
    private boolean homepageFeatured;

    @Column(name = "is_builder_gel")
    private boolean builderGel;

    @Column(name = "display_order")
    private Integer displayOrder = 0;

    @ManyToMany
    @JoinTable(
            name = "service_locations",
            joinColumns = @JoinColumn(name = "service_id"),
            inverseJoinColumns = @JoinColumn(name = "location_id")
    )
    private Set<Location> locations = new HashSet<>();

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategoryLabel() {
        return categoryLabel;
    }

    public void setCategoryLabel(String categoryLabel) {
        this.categoryLabel = categoryLabel;
    }

    public ServiceCategory getCategory() {
        return category;
    }

    public void setCategory(ServiceCategory category) {
        this.category = category;
        if (category != null && (this.categoryLabel == null || this.categoryLabel.isBlank())) {
            this.categoryLabel = switch (category) {
                case HANDS -> "Dịch vụ tay";
                case NAIL_ART -> "Nail art";
                case FEET -> "Dịch vụ chân";
            };
        }
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDurationLabel() {
        return durationLabel;
    }

    public void setDurationLabel(String durationLabel) {
        this.durationLabel = durationLabel;
    }

    public Integer getDurationMinutes() {
        return durationMinutes;
    }

    public void setDurationMinutes(Integer durationMinutes) {
        this.durationMinutes = durationMinutes;
    }

    public BigDecimal getStartingPrice() {
        return startingPrice;
    }

    public void setStartingPrice(BigDecimal startingPrice) {
        this.startingPrice = startingPrice;
    }

    public boolean isHomepageFeatured() {
        return homepageFeatured;
    }

    public void setHomepageFeatured(boolean homepageFeatured) {
        this.homepageFeatured = homepageFeatured;
    }

    public boolean isBuilderGel() {
        return builderGel;
    }

    public void setBuilderGel(boolean builderGel) {
        this.builderGel = builderGel;
    }

    public Integer getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(Integer displayOrder) {
        this.displayOrder = displayOrder;
    }

    public Set<Location> getLocations() {
        return locations;
    }

    public void setLocations(Set<Location> locations) {
        this.locations = locations;
    }
}

