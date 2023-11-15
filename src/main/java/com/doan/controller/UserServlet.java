package com.doan.controller;

import java.io.IOException;
import java.io.PrintWriter;

import com.doan.model.AccountDetails;
import com.doan.model.sql.sqlAccountDetails;
import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/UserServlet/GetUserDetails")
public class UserServlet extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if(uri.contains("GetUserDetails")){
            getUserDetails(req, resp);
        }
    }

    protected void getUserDetails(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String userID = session.getAttribute("loggedInID").toString();

        AccountDetails details = sqlAccountDetails.getDetails(userID);
        
        String jsonString = new Gson().toJson(details).toString();

        resp.setContentType("application/json");
        PrintWriter writer = resp.getWriter();
        writer.write(jsonString);
        writer.flush();
    }    
}
