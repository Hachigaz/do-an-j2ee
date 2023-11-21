package com.doan.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import com.doan.model.sql.sqlAccount;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet(name = "register", value = "/register")
@MultipartConfig
public class RegisterServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("WEB-INF/regis/register.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            // Nhận dữ liệu từ yêu cầu POST
            String birthDate = request.getParameter("birthDate");
    
            // Parse birthDate as a java.sql.Date
            java.sql.Date sqlBirthDate = java.sql.Date.valueOf(birthDate);
    
            // Lấy dữ liệu còn lại từ form
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String address = request.getParameter("address");
            System.out.println(username+email+password+firstName+lastName+address);
            // Kiểm tra xem đã có tài khoản với email hoặc tên người dùng đã đăng ký chưa
            if (sqlAccount.isEmailExists(email) || sqlAccount.isUsernameExists(username)) {
                sendErrorResponse(response, "Email hoặc tên người dùng đã được sử dụng.");
            } else {
                // Thực hiện đăng ký và gửi phản hồi thành công về trình duyệt

                String folderPathUserHome = "d:/tmp/resources/img/userdata/" + username;
                File folderUserHome = new File(folderPathUserHome);
    
                // Create folder using servlet context path
                                // Navigate to the desired folder within the WEB-INF directory
                
                
                if (folderUserHome.mkdirs()) {
                    System.out.println("User Home Folder created successfully: " + folderUserHome.getAbsolutePath());}
                // Check and report the result for the first folder (user's home directory)

                    // ... (code for file saving and database operation)
// ... (code for file saving and database operation)
Part avatarPart = request.getPart("avatarName");
Part backgroundPart = request.getPart("background");
String avatarFileName = saveFile(avatarPart, folderPathUserHome, "avatar");
String backgroundFileName = saveFile(backgroundPart, folderPathUserHome, "background");

// Construct file paths for the avatar and background images
String avatarFilePath = username + "/" + avatarFileName;
String backgroundFilePath = username + "/" + backgroundFileName;

// Add the account to the database with image file paths
sqlAccount.addAccount(username, email, password, firstName, lastName, address, sqlBirthDate,
        avatarFilePath, backgroundFilePath);
        request.setAttribute("username", username);
        request.setAttribute("avatarImagePath", avatarFilePath);
        request.setAttribute("backgroundImagePath", backgroundFilePath);

// Dispatch to the user page JSP
                    sendSuccessResponse(response, "Đăng ký thành công.");  
            }
            } catch (Exception e) {
                // Handle exception
                log("Exception occurred: " + e.getMessage());
                sendErrorResponse(response, "Đã xảy ra lỗi.");
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
    private String saveFile(Part filePart, String folderPath, String type) throws IOException {
        String fileName = getFileName(filePart, type);

    // Rename the file to "0" or "1"
    String newFileName = type.equals("avatar") ? "0" : "1";

    // Append the original file extension to the new name
    int dotIndex = fileName.lastIndexOf('.');
    String extension = (dotIndex > 0) ? fileName.substring(dotIndex) : "";
    newFileName = newFileName + extension;

    // Full path for the new file
    String filePath = folderPath + File.separator + newFileName;

    // Read the input stream and write to the file
    try (InputStream inputStream = filePart.getInputStream();
         OutputStream outputStream = new FileOutputStream(filePath)) {
        byte[] buffer = new byte[1024];
        int bytesRead;
        while ((bytesRead = inputStream.read(buffer)) != -1) {
            outputStream.write(buffer, 0, bytesRead);
        }
    }
    return newFileName;
}

    private String getFileName(Part part, String type) {
        // Get content-disposition header and parse out the filename
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                // Get the file name and append the type
                String fileName = token.substring(token.indexOf('=') + 2, token.length() - 1);
                return type + "_" + fileName;
            }
        }
        // If no filename found in the header, return an empty string or handle as appropriate
        return "";
    }
}
