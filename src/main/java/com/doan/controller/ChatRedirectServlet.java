package com.doan.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.List;

import com.doan.model.AccountDetails;
import com.doan.model.ChatObject.Message;
import com.doan.model.sql.sqlAccountDetails;
import com.doan.model.sql.sqlChatObject;
import com.doan.model.sql.sqlFriend;
import com.doan.model.FriendDetails;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonParser;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet({
    "/chat-messenger",

    "/ChatRequest/Messages",
    "/ChatRequest/FriendList",
})
public class ChatRedirectServlet extends HttpServlet{

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if(uri.contains("chat-messenger")){
            redirect(req, resp);
        }
        else if(uri.contains("ChatRequest")){       
            if(uri.contains("Messages")){
                sendMessagesData(req,resp);
            }
            else if(uri.contains("FriendList")){
                sendFriendsData(req,resp);
            }
        }
    }

    protected void redirect(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/chat/chat.jsp");
        dispatcher.forward(request, response);
    }

    protected void sendFriendsData(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        HttpSession session = req.getSession(true);

        String userID = session.getAttribute("loggedInID").toString();

        JsonArray sendBackData = new JsonArray();
        
        Gson gson = new Gson();

        List<FriendDetails> friendDetails = sqlFriend.getFriendsDetails(userID);

        sendBackData.add(JsonParser.parseString(gson.toJson(friendDetails)));

        AccountDetails myAccountDetail = sqlAccountDetails.getDetails(userID);
        sendBackData.add(JsonParser.parseString(gson.toJson(myAccountDetail)));
        
        String friendData = gson.toJson(sendBackData);

        resp.setContentType("application/json");
        
        PrintWriter out = resp.getWriter();
        out.println(friendData);
    }
    
    private void sendMessagesData(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        String chatIDGet = req.getParameter("chatID");
        
        List<Message> messages = sqlChatObject.getMessages(
            Timestamp.valueOf("1000-01-01 00:00:00"),
            Timestamp.valueOf("9999-01-01 12:59:59") ,
            chatIDGet
        );
        
        String messageData = new Gson().toJson(messages);

        resp.setContentType("application/json");
        
        PrintWriter out = resp.getWriter();
        out.println(messageData);
    }
}