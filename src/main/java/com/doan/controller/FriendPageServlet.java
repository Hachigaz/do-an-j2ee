package com.doan.controller;

import java.io.IOException;
import java.util.List;

import javax.xml.registry.infomodel.User;

import com.doan.model.Account;
import com.doan.model.sql.sqlAccount;
import com.doan.model.sql.sqlFriend;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name="friend-page",value=("/friend-page"))
public class FriendPageServlet extends HttpServlet{
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        List<Account> friends = sqlFriend.getAllFriend("1");

        Gson gson = new Gson();
        JsonArray jsonArray = new JsonArray();
        for (Account user : friends) {
            JsonObject jsonObject = new JsonObject();
            jsonObject.addProperty("id", user.getAccountID());
            jsonObject.addProperty("name", user.getUsername());
            jsonObject.addProperty("email", user.getEmail());
            jsonArray.add(jsonObject);
        }
        String jsonResult = gson.toJson(jsonArray);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResult.toString());


        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/friend-page.jsp");
        dispatcher.forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("WEB-INF/friend-page.jsp").forward(request, response);
    }
}
