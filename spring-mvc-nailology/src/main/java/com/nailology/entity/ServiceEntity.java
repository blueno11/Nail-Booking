package com.nailology.entity;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "services")
public class ServiceEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "name", nullable = false, length = 150)
    private String name;

    @Column(name = "category_label", length = 100)
    private String categoryLabel;

    @Column(name = "category", nullable = false, length = 20)
    private String category;

    @Column(name = "description", length = 800)
    private String description;

    @Column(name = "duration_label", length = 50)
    private String durationLabel;

    @Column(name = "duration_minutes")
    private Integer durationMinutes;

    @Column(name = "starting_price", precision = 10, scale = 2)
    private BigDecimal startingPrice;

    @Column(name = "homepage_featured")
    private Boolean homepageFeatured = false;

    @Column(name = "is_builder_gel")
    private Boolean isBuilderGel = false;

    @Column(name = "display_order")
    private Integer displayOrder = 0;

    @ManyToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinTable(
        name = "service_locations",
        joinColumns = @JoinColumn(name = "service_id"),
        inverseJoinColumns = @JoinColumn(name = "location_id")
    )
    private Set<Location> locations = new HashSet<>();

    // Constructors
    public ServiceEntity() {
    }

    public ServiceEntity(String name, String category) {
        this.name = name;
        this.category = category;
    }

    // Getters and Setters
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

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
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

    public Boolean getHomepageFeatured() {
        return homepageFeatured;
    }

    public void setHomepageFeatured(Boolean homepageFeatured) {
        this.homepageFeatured = homepageFeatured;
    }

    public Boolean getIsBuilderGel() {
        return isBuilderGel;
    }

    public void setIsBuilderGel(Boolean isBuilderGel) {
        this.isBuilderGel = isBuilderGel;
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

