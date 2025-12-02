package com.nailology.model;

import java.util.List;

public class BookingForm {
    private String customerName;
    private String email;
    private String phone;
    private String location;
    private String date;
    private String time;
    private List<Integer> selectedServiceIds;
    private String message;

    public BookingForm() {
    }

    // Getters and Setters
    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public List<Integer> getSelectedServiceIds() {
        return selectedServiceIds;
    }

    public void setSelectedServiceIds(List<Integer> selectedServiceIds) {
        this.selectedServiceIds = selectedServiceIds;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}

