package com.doan.controller;

import java.io.*;

import com.doan.model.AccountDetails;
import com.doan.model.sql.sqlAccountDetails;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "userpage", value = "/userpage")
public class UserpageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String userID = (String) request.getSession().getAttribute("loggedInID");
        AccountDetails details = sqlAccountDetails.getDetails(userID);
        
        request.setAttribute("userDetails", details);  // Set the userDetails attribute
        
    
        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/userpage/userpage.jsp");
        dispatcher.forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            // Ensure that "loggedInID" is set correctly in the session during login
            String userID = (String) request.getSession().getAttribute("loggedInID");

    
            // Lấy dữ liệu còn lại từ form
            String newfirstName = request.getParameter("newfirstName");
            String newlastName = request.getParameter("newlastName");
            String newaddress = request.getParameter("newaddress");
            System.out.println("firstName: " + newfirstName + ", lastName: " + newlastName + ", address: " + newaddress);
    
            sqlAccountDetails.updateAccountdetails(userID, newfirstName, newlastName, newaddress);
            sendSuccessResponse(response, "Update thành công.");
        } catch (Exception e) {
            log("Exception occurred: " + e.getMessage());
            sendErrorResponse(response, "Đã xảy ra lỗi: " + e.getMessage());
        }
    }
    private void sendSuccessResponse(HttpServletResponse response, String message) throws IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.write("{\"status\": \"success\", \"message\": \"" + message + "\"}");
        out.close();
    }
    private void sendErrorResponse(HttpServletResponse response, String message) throws IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.write("{\"status\": \"error\", \"message\": \"" + message + "\"}");
        out.close();
    }
}