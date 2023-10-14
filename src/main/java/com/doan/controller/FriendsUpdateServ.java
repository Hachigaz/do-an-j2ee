package com.doan.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import com.doan.model.AccountDetails;
import com.doan.model.sql.sqlFriend;
import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/friends/update")
public class FriendsUpdateServ extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if(uri.contains("update")){
            HttpSession session = req.getSession(true);
            System.out.println(session.getId());

            String userID = session.getAttribute("loggedInID").toString();
            List<AccountDetails> friendList = sqlFriend.getFriends(userID);

            for(AccountDetails details : friendList){
                System.out.println(details.getFirstName());
            }
            String friendData = new Gson().toJson(friendList);
            PrintWriter out = resp.getWriter();
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            out.print(friendData);
            out.flush();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
    
}
