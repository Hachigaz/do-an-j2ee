package com.doan.controller;

import java.io.IOException;
import java.util.List;

import com.doan.model.AccountDetails;
import com.doan.model.sql.sqlFriend;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name="element",value="/element")
public class ElementSliderServ extends HttpServlet{
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession(true);
        System.out.println(session.getId());
        //da tao session

        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/element-slider.jsp");
        
        String userID = session.getAttribute("loggedInID").toString();
        System.out.println(userID);

        List<AccountDetails> friendList = sqlFriend.getFriends(userID);

        for(AccountDetails details : friendList){
            System.out.println(details.getFirstName());
        }

        dispatcher.forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        
    }
}