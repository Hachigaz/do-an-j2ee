package com.doan.model.sql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.doan.model.*;

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
            Connection connection = sqlConnect.connectToDB();

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
    public static List<Account> getAllFriend(String accountID) {
        List<Account> friends = new ArrayList<Account>();
        try {
            Connection connection = sqlConnect.connectToDB();
            String sql = "(SELECT account.* FROM account JOIN friend ON (account.userID = friend.userID1 OR account.userID = friend.userID2) WHERE (friend.userID1 = ? OR friend.userID2 = ?) AND account.userID != ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, accountID);
            preparedStatement.setString(2, accountID);
            preparedStatement.setString(3, accountID);
            ResultSet resultSet = preparedStatement.executeQuery();
    
            while (resultSet.next()) {
                Account friend = new Account();
                // Trích xuất thông tin về bạn bè từ ResultSet và thiết lập cho đối tượng friend
                friend.setAccountID(resultSet.getString("userID"));
                friend.setUsername(resultSet.getString("username"));
                friend.setEmail(resultSet.getString("email"));
                friend.setPassword("");
                // Thêm friend vào danh sách
                friends.add(friend);
            }
    
            // Đảm bảo đóng ResultSet, PreparedStatement và kết nối sau khi hoàn thành
            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return friends;
    }
    public static List<AccountDetails> getAllFriendAccountDetails(String userId){
        List<AccountDetails> friends = new ArrayList<AccountDetails>();
        try {
            Connection connection = sqlConnect.connectToDB();
            String sql = "SELECT ad.* FROM account_details ad JOIN friend f ON ad.userID = CASE WHEN f.userID1 = ? THEN f.userID2 WHEN f.userID2 = ? THEN f.userID1 ELSE NULL END WHERE f.userID1 = ? OR f.userID2 = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, userId);
            preparedStatement.setString(2, userId);
            preparedStatement.setString(3, userId);
            preparedStatement.setString(4, userId);
            ResultSet resultSet = preparedStatement.executeQuery();
    
            
            while (resultSet.next()) {
                AccountDetails friend = new AccountDetails();
                // Trích xuất thông tin về bạn bè từ ResultSet và thiết lập cho đối tượng friend
                friend.setUserID(resultSet.getString("userID"));
                friend.setFirstName(resultSet.getString("firstName"));
                friend.setLastName(resultSet.getString("lastName"));
                friend.setAddress(resultSet.getString("address"));
                friend.setBirthDate(resultSet.getDate("birthDate"));
                friend.setAvatar(resultSet.getString("avatarName"));
                friend.setBackground(resultSet.getString("background"));
                // Thêm friend vào danh sách
                friends.add(friend);
            }
    
            // Đảm bảo đóng ResultSet, PreparedStatement và kết nối sau khi hoàn thành
            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return friends;
    }
    

    public static List<FriendDetails> getFriendsDetails(String userID){
        List<FriendDetails> friendDetails = new ArrayList<FriendDetails>();
        
        try{
            Connection connection = sqlConnect.connectToDB();

            String sql = "SELECT * FROM friend WHERE friend.deleted = 0 AND (friend.userID1 = ? OR friend.userID2 = ?)";
        
            PreparedStatement statement = connection.prepareStatement(sql);

            statement.setString(1, userID);
            statement.setString(2, userID);
            
            ResultSet rs = statement.executeQuery();

            while(rs.next()){
                String friendID = rs.getString(1).equals(userID)?rs.getString(2):rs.getString(1);
                AccountDetails friendAccountDetails = sqlAccountDetails.getDetails(friendID);
                
                friendDetails.add(new FriendDetails(rs.getString(3),friendAccountDetails));
            }

            statement.close();
            connection.close();
        }
        catch(Exception e){
            System.out.println(e.getMessage());
        }

        return friendDetails;
    }

    public static List<String> getFriendIDS(List<Friend> friends,String userID){
        List<String> friendIDs = new ArrayList<String>(); 
        for (Friend friend : friends){
            friendIDs.add(friend.getUserID1().equals(userID)?friend.getUserID2():friend.getUserID1());
        }
        return friendIDs;
    }

    public static void sendFriendRequest(String sendUserID,String receiveUserID){
        try{
            Connection connection = sqlConnect.connectToDB();
            String sql = "call sendFriendRequest(?,?)";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, sendUserID);
            preparedStatement.setString(2, receiveUserID);
            preparedStatement.execute();
        }
        catch (Exception e){
            System.out.println(e.getMessage());
        }
    }
}