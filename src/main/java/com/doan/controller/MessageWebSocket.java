package com.doan.controller;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;

import com.doan.model.ChatObject.Message;
import com.doan.model.sql.sqlChatObject;
import com.doan.model.sql.sqlFriend;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@ServerEndpoint("/messageSocket")
public class MessageWebSocket {
    private static List<Session> sessions = new ArrayList<Session>();
    @OnOpen
    public void onOpen(Session session) {
        sessions.add(session);
        
        String socketUserID = session.getRequestParameterMap().get("userID").get(0);
        session.getUserProperties().put("userID", socketUserID);
    }
    
    @OnClose
    public void onClose(Session session) {
        sessions.remove(session);
    }
    
    @OnMessage
    public void onMessage(String message, Session session) { 
        try {
            JsonObject messageJSON = JsonParser.parseString(message).getAsJsonObject();

            int chatID = Integer.parseInt(messageJSON.get("chatID").getAsString());

            String textMessage = messageJSON.get("message").getAsString();       
            
            SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d, yyyy, h:mm:ss a");
            Date parsedDate = dateFormat.parse(messageJSON.get("dateSent").getAsString());
            Timestamp timestamp = new Timestamp(parsedDate.getTime());

            Message userMsg = new Message(
                messageJSON.get("userID").getAsString(),
                -1,//msg index
                textMessage,
                timestamp
            );
            sqlChatObject.sendMessage(chatID, userMsg);


            String sendUserID = session.getUserProperties().get("userID").toString();
            List<String> friendIDs = sqlFriend.getFriendIDS(sendUserID);

            for(Session otherSession : sessions){
                for(String friendID : friendIDs){
                    if(otherSession.getUserProperties().get("userID").equals(friendID)){
                        try{
                            otherSession.getBasicRemote().sendText(message);
                        }
                        catch(Exception e){
                            System.out.println(e);
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}