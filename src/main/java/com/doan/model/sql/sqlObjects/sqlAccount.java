package com.doan.model.sql.sqlObjects;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import com.doan.model.Account;

public class sqlAccount extends sqlObject{
    public static final String name = "account";
    public static Account getAccountByID(String userID){
        Account account = null;
        try{
            Connection connection = DriverManager.getConnection(dbURL,dbUser,dbPassword);

            Statement statement = connection.createStatement();
            
            String sql = "SELECT * FROM "+ name + " WHERE account.userID = '"+ userID+"'";
            ResultSet rs = statement.executeQuery(sql);
            rs.next();
            account = new Account(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4));
            connection.close();
        }
        catch (Exception e){
            System.out.println(e.getMessage());
        }
        return account;
    }
    public static Account getAccountByUsername(String username){
        Account account = null;
        try{
            Connection connection = DriverManager.getConnection(dbURL,dbUser,dbPassword);

            Statement statement = connection.createStatement();
            
            String sql = "SELECT * FROM "+ name + " WHERE account.userID = '"+ username+"'";
            ResultSet rs = statement.executeQuery(sql);
            rs.next();
            account = new Account(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4));
            connection.close();
        }
        catch (Exception e){
            System.out.println(e.getMessage());
        }
        return account;
    }
}