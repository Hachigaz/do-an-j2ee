package com.doan.model.sql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.doan.model.AccountDetails;
import com.doan.model.Friend;

public class sqlFriend extends sqlObject {
    public static final String name = "friend";
    public static void add(Friend friend){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver"); 
            Connection connection = DriverManager.getConnection(dbURL,dbUser,dbPassword);

            String sql = "INSERT INTO "+ friend + " (userID1,userID2) VALUES (?,?)";

            PreparedStatement statement  = connection.prepareStatement(sql);
            
            // Set parameter values
            statement.setString(1, friend.getUserID1());
            statement.setString(2, friend.getUserID2());

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
    
    public static void remove(Friend friend){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver"); 
            Connection connection = DriverManager.getConnection(dbURL,dbUser,dbPassword);

            String sql = "DELETE FROM " + name + " WHERE (userID1 = ? AND userID2 = ?) OR (userID1 = ? AND userID2 = ?)";

            PreparedStatement statement = connection.prepareStatement(sql);

            statement.setString(1, friend.getUserID1());
            statement.setString(2, friend.getUserID2());

            statement.setString(4, friend.getUserID1());
            statement.setString(3, friend.getUserID2());

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                //System.out.println("Row deleted successfully!");
            } else {

            }
            statement.close();
            connection.close();
        }
        catch (Exception e){
            System.out.println(e.getMessage());
        }
    }
    public static List<AccountDetails> getFriends(String userID){
        List<AccountDetails> friends = new ArrayList<AccountDetails>();
        
        try{
            Class.forName("com.mysql.cj.jdbc.Driver"); 
            Connection connection = DriverManager.getConnection(dbURL,dbUser,dbPassword);

            String sql = "SELECT * FROM account_details,friend WHERE friend.deleted = 0 AND ((account_details.userID = friend.userID1 AND friend.userID2 = ?) OR (account_details.userID = friend.userID2 AND friend.userID1 = ?))";
        
            PreparedStatement statement = connection.prepareStatement(sql);

            statement.setString(1, userID);
            statement.setString(2, userID);

            ResultSet rs = statement.executeQuery();

            while(rs.next()){
                friends.add(new AccountDetails(rs.getString(1),rs.getString(2),rs.getString(3),rs.getString(5),rs.getDate(5),rs.getString(6),rs.getString(7)));
            }

            statement.close();
            connection.close();
        }
        catch (Exception e){
            System.out.println(e.getMessage());
        }

        return friends;
    }
}
