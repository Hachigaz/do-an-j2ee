package com.doan.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.doan.model.Account;
import com.doan.model.AccountDetails;
import com.doan.model.ChatObject.Message;
import com.doan.model.Friend;
import com.doan.model.sql.sqlFriend;
import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "DataRequest", value = {"/DataRequest/Friends","/DataRequest/FriendDetails","/DataRequest/Unfriend","/DataRequest/Strangers","/DataRequest/SendRequest","/DataRequest/ReceiveRequest","/DataRequest/getRequestList"})
public class FriendRequest extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if(uri.contains("Friends")){
            getFriendList(req,resp);
        }else if(uri.contains("FriendDetails")){
            getFriendsDetails(req,resp);
        }else if(uri.contains("Unfriend")){
            removeFriend(req, resp);
        }else if(uri.contains("Strangers")){
            getStrangerDetails(req,resp);
        }else if(uri.contains("SendRequest")){
            SendRequest(req, resp);
        }else if(uri.contains("ReceiveRequest")){
            ReceiveRequest(req, resp);
        }else if(uri.contains("getRequestList")){
            getRequestList(req, resp);
        }
        
    }
    private void getFriendList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        HttpSession session = req.getSession();
        String userID = session.getAttribute("loggedInID").toString();

        List<Account> friends = sqlFriend.getAllFriend(userID);
        String list = new Gson().toJson(friends);
        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();
        out.println(list);
    }
    private void getFriendsDetails(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        HttpSession session = req.getSession();
        String userID = session.getAttribute("loggedInID").toString();

        List<AccountDetails> accountDetails = sqlFriend.getAllFriendAccountDetails(userID);
        String list = new Gson().toJson(accountDetails);
        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();
        out.println(list);
    }
    private void getStrangerDetails(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        HttpSession session = req.getSession();
        String userID = session.getAttribute("loggedInID").toString();

        List<AccountDetails> accountDetails = sqlFriend.getAllStrangerAccountDetails(userID);
        String list = new Gson().toJson(accountDetails);
        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();
        out.println(list);
    }
    private void getRequestList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        HttpSession session = req.getSession();
        String userID = session.getAttribute("loggedInID").toString();

        List<AccountDetails> accountDetails = sqlFriend.getAllSendRequestAccountDetails(userID);
        String list = new Gson().toJson(accountDetails);
        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();
        out.println(list);
    }
    private void ReceiveRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        HttpSession session = req.getSession();
        String userID = session.getAttribute("loggedInID").toString();

        String friendID = req.getParameter("receiveFriendID");

        if (friendID != null && !friendID.isEmpty()) {
            // Gọi phương thức remove từ lớp sqlFriend
            sqlFriend.sendFriendRequest(userID, friendID);

            // Phản hồi cho client
            resp.getWriter().println(friendID);
        } else {
            resp.getWriter().println("Không có friendID được cung cấp.");
            // Xử lý lỗi hoặc cung cấp thông báo khác tùy thuộc vào yêu cầu của bạn.
        }
    }
    private void SendRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        HttpSession session = req.getSession();
        String userID = session.getAttribute("loggedInID").toString();

        String friendID = req.getParameter("sendFriendID");

        if (friendID != null && !friendID.isEmpty()) {
            // Gọi phương thức remove từ lớp sqlFriend
            sqlFriend.sendFriendRequest(userID, friendID);

            // Phản hồi cho client
            resp.getWriter().println(friendID);
        } else {
            resp.getWriter().println("Không có friendID được cung cấp.");
            // Xử lý lỗi hoặc cung cấp thông báo khác tùy thuộc vào yêu cầu của bạn.
        }
    }
    private void removeFriend(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        HttpSession session = req.getSession();
        String userID = session.getAttribute("loggedInID").toString();

        String friendID = req.getParameter("friendID");

        if (friendID != null && !friendID.isEmpty()) {
            // Giả sử lớp Friend có một constructor nhận hai ID người dùng
            Friend friendToRemove = new Friend(userID, friendID);

            // Gọi phương thức remove từ lớp sqlFriend
            sqlFriend.remove(friendToRemove);

            // Phản hồi cho client
            resp.getWriter().println(friendID);
        } else {
            resp.getWriter().println("Không có friendID được cung cấp.");
            // Xử lý lỗi hoặc cung cấp thông báo khác tùy thuộc vào yêu cầu của bạn.
        }
    }
}
