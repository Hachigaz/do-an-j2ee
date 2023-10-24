package com.doan.controller;

import java.sql.Timestamp;
import java.util.ArrayList;
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
        System.out.println("opened session: "+session.getId());
        sessions.add(session);
        
        String socketUserID = session.getRequestParameterMap().get("userID").get(0);
        session.getUserProperties().put("userID", socketUserID);
    }
    
    @OnClose
    public void onClose(Session session) {
        System.out.println("closed session: "+session.getId());
        sessions.remove(session);
    }
    
    @OnMessage
    public void onMessage(String message, Session session) {
        JsonObject messageJSON = JsonParser.parseString(message).getAsJsonObject();

        int chatID = Integer.parseInt(messageJSON.get("chatID").getAsString());

        String textMessage = messageJSON.get("textMessage").getAsString();        

        Message userMsg = new Message(
            messageJSON.get("userID").getAsString(),
            -1,
            textMessage,
            Timestamp.valueOf(messageJSON.get("dateSent").getAsString())
        );
        sqlChatObject.sendMessage(chatID, userMsg);
        
        System.out.println(message);

        String sendUserID = session.getUserProperties().get("userID").toString();
        List<String> friendIDs = sqlFriend.getFriendIDS(sqlFriend.getFriends(sendUserID),sendUserID);

        for(Session otherSession : sessions){
            for(String friendID : friendIDs){
                if(otherSession.getUserProperties().get("userID").equals(friendID)){
                    try{
                        otherSession.getBasicRemote().sendText(message);
                        System.out.println("sent message to "+otherSession.getId());
                    }
                    catch(Exception e){
                        System.out.println(e);
                    }
                }
            }
        }
    }
}