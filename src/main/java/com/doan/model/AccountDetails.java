package com.doan.model;

import java.util.HashMap;
import java.util.Map;


public class AccountDetails {
    private String userID;
    private String firstName;
    private String lastName;
    private String address;
    private java.sql.Date birthDate;
    private String avatar;
    private String background;
    private int chatID;
    private int friendCounts;

    public AccountDetails(){
        
    }
    public AccountDetails(String userID, String firstName, String lastName, String address, java.sql.Date birthDate,
            String avatar, String background, int friendCounts) {
        this.userID = userID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.address = address;
        this.birthDate = birthDate;
        this.avatar = avatar;
        this.background = background;
        this.friendCounts=friendCounts;
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
    private Map<String, String> temporaryProperties = new HashMap<>();

    public int getChatID() {
        return this.chatID;
    }
    public void setChatID(int chatID) {
        this.chatID = chatID;
    }
     public int getfriendCounts() {
        return this.friendCounts;
    }
    public void setfriendCounts(int friendCounts) {
        this.friendCounts = friendCounts;
    }

    // Phương thức để thêm một thuộc tính tạm thời
    public void setTemporaryProperty(String propertyName, String value) {
        temporaryProperties.put(propertyName, value);
    }

    // Phương thức để lấy giá trị của một thuộc tính tạm thời
    public String getTemporaryProperty(String propertyName) {
        return temporaryProperties.get(propertyName);
    }
}
