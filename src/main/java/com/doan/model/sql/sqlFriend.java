package com.doan.model.sql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.doan.model.Friend;

public class sqlFriend{
    public static final String name = "friend";
    public static void add(Friend friend){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver"); 
            Connection connection = DriverManager.getConnection(sqlConnect.dbURL,sqlConnect.dbUser,sqlConnect.dbPassword);

            String sql = "CALL addFriend(?,?)";

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
            Connection connection = sqlConnect.connectToDB();

            String sql = "CALL sRemoveFriend(?,?)";

            PreparedStatement statement = connection.prepareStatement(sql);

            statement.setString(1, friend.getUserID1());
            statement.setString(2, friend.getUserID2());

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
    public static List<Friend> getFriends(String userID){
        List<Friend> friends = new ArrayList<Friend>();
        
        try{
            Class.forName("com.mysql.cj.jdbc.Driver"); 
            Connection connection = DriverManager.getConnection(sqlConnect.dbURL,sqlConnect.dbUser,sqlConnect.dbPassword);

            String sql = "SELECT * FROM friend WHERE friend.deleted = 0 AND (friend.userID1 = ? OR friend.userID2 = ?)";
        
            PreparedStatement statement = connection.prepareStatement(sql);

            statement.setString(1, userID);
            statement.setString(2, userID);

            ResultSet rs = statement.executeQuery();

            while(rs.next()){
                friends.add(new Friend(rs.getString(1),rs.getString(2),rs.getString(3)));
            }

            statement.close();
            connection.close();
        }
        catch (Exception e){
            System.out.println(e.getMessage());
        }

        return friends;
    }

    public static List<String> getFriendIDS(List<Friend> friends,String userID){
        List<String> friendIDs = new ArrayList<String>(); 
        for (Friend friend : friends){
            friendIDs.add(friend.getUserID1().equals(userID)?friend.getUserID2():friend.getUserID1());
        }
        return friendIDs;
    }
}