package com.doan.doanj2ee;

import java.io.*;

import com.doan.doanj2ee.sql.Account;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "sign-in", value = "/sign-in")
public class SignInServlet extends HttpServlet {
    private void xuLyDangNhap(String tenTK,String matKhau){

    }
    private void xuLyDangKy(Account newAccount){

    }
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("WEB-INF/sign-in.jsp").forward(request,response);
    }
}