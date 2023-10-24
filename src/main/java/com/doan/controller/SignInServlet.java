package com.doan.controller;

import java.io.*;

import com.doan.model.Account;
import com.doan.model.sql.sqlAccount;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "sign-in", value = "/sign-in")
public class SignInServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
                    RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/sign-in.jsp");
                    dispatcher.forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String username = request.getParameter("LoginUsername");
        String password = request.getParameter("LoginPassword");



        if(username!=null||password!=null){
             Account account = sqlAccount.getAccountByUsername(username);
                if(account!=null){
                    if(account.getPassword().equals(password)){
                        HttpSession session = request.getSession();
                        //luu user id da dang nhap
                        session.setAttribute("loggedInID", account.getAccountID());
                        //nhay sang trang chu
                        RequestDispatcher dispatcher = request.getRequestDispatcher("/home-page");
                        dispatcher.forward(request, response);
                    }
                    else{
                        //sai mat khau
                        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/sign-in.jsp");
                        dispatcher.forward(request, response);
                    }
                }
                else{
                    //sai ten dang nhap
                    RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/sign-in.jsp");
                    dispatcher.forward(request, response);
                }
        }
        else{
                    RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/sign-in.jsp");
                    dispatcher.forward(request, response);
        }
    }
}