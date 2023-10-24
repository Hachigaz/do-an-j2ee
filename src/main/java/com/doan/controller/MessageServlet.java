package com.doan.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.doan.model.AccountDetails;
import com.doan.model.Friend;
import com.doan.model.ChatObject.Message;
import com.doan.model.sql.sqlAccountDetails;
import com.doan.model.sql.sqlChatObject;
import com.doan.model.sql.sqlFriend;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonParser;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet({"/message/getFriends","/message/getMessages"})
public class MessageServlet extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if(uri.contains("getFriends")){
            sendFriendsData(req,resp);
        }
        else if(uri.contains("getMessages")){
            sendMessagesData(req,resp);
        }
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
    
    protected void sendFriendsData(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        HttpSession session = req.getSession(true);

        String userID = session.getAttribute("loggedInID").toString();

        JsonArray sendBackData = new JsonArray();
        
        Gson gson = new Gson();

        List<UserInfo> friendInfos = new ArrayList<UserInfo>();
        for(Friend friend : sqlFriend.getFriends(userID)){
            String friendID = userID.equals(friend.getUserID1())?friend.getUserID2():friend.getUserID1();
            AccountDetails friendDetails = sqlAccountDetails.getDetails(friendID);
            friendInfos.add(new UserInfo(
                friendDetails.getUserID(),
                friendDetails.getFirstName(),
                friendDetails.getLastName(),
                friendDetails.getAddress(),
                friendDetails.getBirthDate(),
                friendDetails.getAvatar(),
                friendDetails.getBackground(),
                friend.getChatID()
                ));
        };

        sendBackData.add(JsonParser.parseString(gson.toJson(friendInfos)));

        AccountDetails myAccountDetail = sqlAccountDetails.getDetails(userID);
        sendBackData.add(JsonParser.parseString(gson.toJson(myAccountDetail)));
        
        String friendData = gson.toJson(sendBackData);

        

        resp.setContentType("application/json");
        
        PrintWriter out = resp.getWriter();
        out.println(friendData);
        out.flush();
    }
    
    private void sendMessagesData(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        String chatIDGet = req.getHeader("chatID");
        
        List<Message> messages = sqlChatObject.getMessages(
            Timestamp.valueOf("1000-01-01 00:00:00"),
            Timestamp.valueOf("9999-01-01 12:59:59") ,
            chatIDGet
        );
        
        String messageData = new Gson().toJson(messages);

        resp.setContentType("application/json");
        
        PrintWriter out = resp.getWriter();
        out.println(messageData);
        out.flush();
    }
}


class UserInfo{
    private String userID;
    private String firstName;
    private String lastName;
    private String address;
    private Date birthDate;
    private String avatar;
    private String background;
    private String chatID;

    public UserInfo(String userID, String firstName, String lastName, String address, Date birthDate,
            String avatar, String background, String chatID) {
        this.userID = userID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.address = address;
        this.birthDate = birthDate;
        this.avatar = avatar;
        this.background = background;
        this.chatID = chatID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getBackground() {
        return background;
    }

    public void setBackground(String background) {
        this.background = background;
    }

    public String getChatID() {
        return chatID;
    }

    public void setChatID(String chatID) {
        this.chatID = chatID;
    }
}