package com.doan.model;

public class Account {
    private String accountID;
    private String username;
    private String email;
    private String password;

    public Account(String accountID, String username, String email, String password) {
        this.accountID = accountID;
        this.username = username;
        this.email = email;
        this.password = password;
    }

    public String getAccountID() {
        return accountID;
    }

    public void setAccountID(String accountID) {
        this.accountID = accountID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
