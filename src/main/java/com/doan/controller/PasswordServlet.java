// Source code is decompiled from a .class file using FernFlower decompiler.
package com.doan.controller;

import com.doan.model.Account;
import com.doan.model.sql.sqlAccount;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(
   name = "changepassword",
   value = {"/changepassword"}
)
public class PasswordServlet extends HttpServlet {
   public PasswordServlet() {
   }

   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.getRequestDispatcher("WEB-INF/changepass/password.jsp").forward(request, response);
   }

   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      HttpSession session = request.getSession();
      String userID = (String)session.getAttribute("loggedInID");
      String currentPassword = request.getParameter("currentPassword");
      String newPassword = request.getParameter("newPassword");
      String confirmNewPassword = request.getParameter("confirmNewPassword");
      String errorMessage = null;
      String successMessage = null;
      if (userID != null && currentPassword != null && newPassword != null && confirmNewPassword != null) {
         Account account = sqlAccount.getAccountByID(userID);
         if (account != null && account.getPassword().equals(currentPassword)) {
            if (newPassword.equals(confirmNewPassword)) {
                // Mật khẩu mới đã được xác nhận đúng
                account.setPassword(newPassword);
                sqlAccount.updatePassword(userID, newPassword);
                successMessage = "Password changed successfully.";
                response.sendRedirect(request.getContextPath() + "/home-page");
                return;
            } else {
                // Mật khẩu mới không khớp với xác nhận mật khẩu
                errorMessage = "New password and confirm password do not match.";
            }
        } else {
            // Tài khoản không tồn tại hoặc mật khẩu hiện tại không chính xác
            errorMessage = "Invalid user or password.";
        }
        

      request.setAttribute("errorMessage", errorMessage);
      request.setAttribute("successMessage", successMessage);
      RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/changepass/password.jsp");
      dispatcher.forward(request, response);
   }
   }}
