package com.doan.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.List;

import com.doan.model.Account;
import com.doan.model.ChatObject.Message;
import com.doan.model.sql.sqlFriend;
import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DataRequest/Friends")
public class FriendRequest extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if(uri.contains("Friends")){
            getFriendList(req,resp);
        }
    }
    private void getFriendList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        List<Account> friends = sqlFriend.getAllFriend("2");
        
        String list = new Gson().toJson(friends);
        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();
        out.println(list);
    }
}
