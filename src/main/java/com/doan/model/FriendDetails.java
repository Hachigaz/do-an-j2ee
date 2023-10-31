package com.doan.model;

public class FriendDetails {
    
    private String chatID;
    private AccountDetails friendDetails;
    
    public FriendDetails(String chatID, AccountDetails friendDetails) {
        this.chatID = chatID;
        this.friendDetails = friendDetails;
    }
    
    public String getChatID() {
        return chatID;
    }
    public void setChatID(String chatID) {
        this.chatID = chatID;
    }
    public AccountDetails getFriendDetails() {
        return friendDetails;
    }
    public void setFriendDetails(AccountDetails friendDetails) {
        this.friendDetails = friendDetails;
    }
}