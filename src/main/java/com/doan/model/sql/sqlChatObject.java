package com.doan.model.sql;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import com.doan.model.ChatObject.Message;

public class sqlChatObject {
    public static ArrayList<Message> getMessages(Timestamp end,int count,String chatID){
        ArrayList<Message> messages = new ArrayList<Message>();
        try{
            Connection connection = sqlConnect.connectToDB();
            String sql = "select * from message where message.chatID = ? AND date_sent<=? AND deleted = 0 order by date_sent DESC LIMIT ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, chatID);
            statement.setTimestamp(2, end);
            statement.setInt(3,count);

            ResultSet rs = statement.executeQuery();

            while(rs.next()){
                messages.add(new Message(rs.getString(2),rs.getInt(3),rs.getString(4),rs.getTimestamp(5)));
            }
            statement.close();
            connection.close();
        }
        catch(Exception e){
            System.err.println(e);
        }
        return messages;
    }
    public static void sendMessage(int chatID,Message message){
        try{
            Connection connection = sqlConnect.connectToDB();
            String sql = "call sendMessage(?,?,?,?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1,chatID);
            statement.setString(2,message.getUserID());
            statement.setString(3, message.getMessage());
            statement.setTimestamp(4, message.getDateSent());
            statement.execute();
            statement.close();
            connection.close();
        }
        catch(Exception e){
            System.err.println(e);
        }
    }
}
