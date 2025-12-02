package com.nailology.entity;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "locations")
public class Location {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "name", nullable = false, length = 100)
    private String name;

    @Column(name = "suburb", length = 120)
    private String suburb;

    @Column(name = "postcode", length = 10)
    private String postcode;

    @Column(name = "address", length = 255)
    private String address;

    @Column(name = "phone", length = 50)
    private String phone;

    @Column(name = "email", length = 120)
    private String email;

    @Column(name = "status", nullable = false, length = 20)
    private String status;

    @Column(name = "highlight", length = 512)
    private String highlight;

    @Column(name = "coffee_available")
    private Boolean coffeeAvailable = true;

    @Column(name = "display_order")
    private Integer displayOrder = 0;

    @ManyToMany(mappedBy = "locations")
    private Set<ServiceEntity> services = new HashSet<>();

    // Constructors
    public Location() {
    }

    public Location(String name, String status) {
        this.name = name;
        this.status = status;
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

    public String getSuburb() {
        return suburb;
    }

    public void setSuburb(String suburb) {
        this.suburb = suburb;
    }

    public String getPostcode() {
        return postcode;
    }

    public void setPostcode(String postcode) {
        this.postcode = postcode;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getHighlight() {
        return highlight;
    }

    public void setHighlight(String highlight) {
        this.highlight = highlight;
    }

    public Boolean getCoffeeAvailable() {
        return coffeeAvailable;
    }

    public void setCoffeeAvailable(Boolean coffeeAvailable) {
        this.coffeeAvailable = coffeeAvailable;
    }

    public Integer getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(Integer displayOrder) {
        this.displayOrder = displayOrder;
    }

    public Set<ServiceEntity> getServices() {
        return services;
    }

    public void setServices(Set<ServiceEntity> services) {
        this.services = services;
    }
}

