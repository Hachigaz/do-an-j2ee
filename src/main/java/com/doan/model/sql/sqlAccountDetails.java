package com.doan.model.sql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import com.doan.model.AccountDetails;

public class sqlAccountDetails{
    public static final String name = "account_details";
    public static void addAccountDetails(AccountDetails details){
        try{
            Connection connection = sqlConnect.connectToDB();
            String sql = "INSERT INTO "+ name + " (userID,firstName,lastName,birthDate,address,avatarName,background) VALUES (?,?,?,?,?,?,?)";

            PreparedStatement statement  = connection.prepareStatement(sql);
            
            // Set parameter values
            statement.setString(1, details.getUserID());
            statement.setString(2, details.getFirstName());
            statement.setString(3, details.getLastName());
            statement.setDate(4, details.getBirthDate());

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
    public static AccountDetails getDetails(String userID){

        AccountDetails details = null;
        try{
            Class.forName("com.mysql.cj.jdbc.Driver"); 
            Connection connection = DriverManager.getConnection(sqlConnect.dbURL,sqlConnect.dbUser,sqlConnect.dbPassword);

            Statement statement = connection.createStatement();
            
            String sql = "SELECT * FROM "+ name + " WHERE account_details.userID = '"+ userID+"'";
            ResultSet rs = statement.executeQuery(sql);
            
            if(rs.next()){
                details = new AccountDetails(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4),rs.getDate(5),rs.getString(6),rs.getString(7));
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
        return details;
    }

}