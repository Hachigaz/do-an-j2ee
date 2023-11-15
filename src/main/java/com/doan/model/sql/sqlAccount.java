package com.doan.model.sql;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import com.doan.model.Account;

public class sqlAccount{
    public static final String name = "account";
    
    public static Account getAccountByID(String userID){
        Account account = null;
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");  
            Connection connection = DriverManager.getConnection(sqlConnect.dbURL, sqlConnect.dbUser,sqlConnect.dbPassword);

            Statement statement = connection.createStatement();
            
            String sql = "SELECT * FROM "+ name + " WHERE account.userID = '"+ userID+"'";
            ResultSet rs = statement.executeQuery(sql);
            if(rs.next()){
                account = new Account(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4));
            }
            else{
                System.out.println("empty rs");
            }
            statement.close();
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
            Connection connection = sqlConnect.connectToDB();

            Statement statement = connection.createStatement();
            
            String sql = "SELECT * FROM "+ name + " WHERE account.username = '"+ username+"'";
            ResultSet rs = statement.executeQuery(sql);
            if(rs.next()){
                account = new Account(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4));
            }
            else{
                System.out.println("empty rs");
            }
            statement.close();
            connection.close();
        }
        catch (Exception e){
            System.out.println(e.getMessage());
        }
        return account;
    }
    public static void addAccount(
        String username, String email,
        String userpass, String firstName,
        String lastName, String address,
        Date birthDate, String avatarName,
        String backgroundName
    ){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver"); 
            Connection connection = DriverManager.getConnection(sqlConnect.dbURL,sqlConnect.dbUser,sqlConnect.dbPassword);

            String sql = "CALL addAccount(?,?,?,?,?,?,?,?,?)";

            PreparedStatement statement  = connection.prepareStatement(sql);
            
            // Set parameter values
            statement.setString(1, username);
            statement.setString(2, email);
            statement.setString(3, userpass);
            statement.setString(4, firstName);
            statement.setString(5, lastName);
            statement.setString(6, address);
            statement.setDate(7, birthDate);
            statement.setString(8, avatarName);
            statement.setString(9, backgroundName);



            // Execute s INSERT statement
            int rowsInserted = statement.executeUpdate();

            if (rowsInserted > 0) {
                //System.out.println("A new row has been inserted successfully.");
            } else {
                //System.out.println("No rows were inserted.");
            }
            statement.close();
            connection.close();
        }
        catch (Exception e){
            System.out.println(e.getMessage());
        }
    }
}