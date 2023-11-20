package com.doan.model;

import java.util.Date;


public class AccountDetails {
    private String userID;
    private String firstName;
    private String lastName;
    private String address;
    private java.sql.Date birthDate;
    private String avatar;
    private String background;
    
    public AccountDetails(){
        
    }
    public AccountDetails(String userID, String firstName, String lastName, String address, java.sql.Date birthDate,
            String avatar, String background) {
        this.userID = userID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.address = address;
        this.birthDate = birthDate;
        this.avatar = avatar;
        this.background = background;
    }
    public String getUserID() {
        return userID;
    }
    public void setUserID(String userID) {
        this.userID = userID;
    }
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }
    public String getAvatar() {
        return avatar;
    }
    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
    public String getBackground() {
        return background;
    }
    public void setBackground(String background) {
        this.background = background;
    }
    public String getFirstName() {
        return firstName;
    }
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    public String getLastName() {
        return lastName;
    }
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    public java.sql.Date getBirthDate() {
        return birthDate;
    }
    public void setBirthDate(java.sql.Date birthDate) {
        this.birthDate = birthDate;
    }
}
