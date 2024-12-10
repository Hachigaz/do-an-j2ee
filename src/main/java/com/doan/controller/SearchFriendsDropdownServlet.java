package com.doan.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import com.doan.model.AccountDetails;
import com.doan.model.sql.sqlAccountDetails;
import com.doan.model.sql.sqlFriend;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "SearchFriendsDropdown", value = "/SearchFriendsDropdown")
@MultipartConfig
public class SearchFriendsDropdownServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        PrintWriter out = response.getWriter();
        out.println("SUCCESS");
        out.close();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        HttpSession session = request.getSession();
        String userId = session.getAttribute("loggedInID").toString();
        String keyword = request.getParameter("keyword").toString();
        String isEnter = request.getParameter("isEnter").toString();
        ArrayList<String> list = sqlFriend.getListUserIdFriendhasNameLikeKeyword(userId, keyword);

        if (!list.isEmpty()) {
            System.out.println("List quantity: " + list.size());
            ArrayList<AccountDetails> accDetailList = new ArrayList<>();
            for (int i = 0; i < list.size(); i++) {
                AccountDetails acc = sqlAccountDetails.getDetails(list.get(i));
                accDetailList.add(acc);
            }
            request.setAttribute("isExist", "true");
            request.setAttribute("list", accDetailList);
        } else {
            request.setAttribute("isExist", "false");
        }

        response.setContentType("text/html");
        if (isEnter.equals("false")) {
            RequestDispatcher dispatcher = request
                    .getRequestDispatcher("/WEB-INF/components/header/header-search-dropdown.jsp");
            dispatcher.forward(request, response);
        } else {
            RequestDispatcher dispatcher = request
                    .getRequestDispatcher("/WEB-INF/friend-search-page/friend-search-page.jsp");
            dispatcher.forward(request, response);
        }
    }

}