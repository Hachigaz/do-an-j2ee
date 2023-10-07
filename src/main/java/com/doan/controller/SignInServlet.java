package com.doan.controller;

import java.io.*;

import com.doan.model.Account;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "SignIn", value = "/sign-in")
public class SignInServlet extends HttpServlet {
    private void xuLyDangNhap(String tenTK,String matKhau){

    }
    private void xuLyDangKy(Account newAccount){

    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String username = request.getParameter("DangNhap_Username");
        String password = request.getParameter("DangNhap_Password");

        System.out.println(username);
        System.out.println(password);

        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/sign-in.jsp");
        dispatcher.forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        
    }
}