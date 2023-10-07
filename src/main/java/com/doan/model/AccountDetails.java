package com.doan.model;

public class AccountDetails {
    private String userID;
    private String name;
    private String address;
    private String birthDate;
    
    public AccountDetails(String userID, String name, String address, String birthDate) {
        this.userID = userID;
        this.name = name;
        this.address = address;
        this.birthDate = birthDate;
    }

    public String getUserID() {
        return userID;
    }
    public void setUserID(String userID) {
        this.userID = userID;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }
    public String getBirthDate() {
        return birthDate;
    }
    public void setBirthDate(String birthDate) {
        this.birthDate = birthDate;
    }
}
