package com.doan.controller;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.stream.Collectors;

import com.doan.model.Account;
import com.doan.model.AccountDetails;
import com.doan.model.sql.sqlAccount;
import com.doan.model.sql.sqlAccountDetails;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
@MultipartConfig

@WebServlet(name = "userpage", value = "/userpage")
public class UserpageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String userID = (String) request.getSession().getAttribute("loggedInID");
        String userID1 = request.getParameter("userID");          // Get userID from the request parameters
        boolean showPostButton = (userID1 == null );

        if (userID1!= null){
            request.setAttribute("showPostButton", showPostButton);  // Set the showPostButton attribute
            AccountDetails details = sqlAccountDetails.getDetails(userID1);
            request.setAttribute("userDetails", details);
        }
        else{ 
        AccountDetails details = sqlAccountDetails.getDetails(userID);
        request.setAttribute("userDetails", details);  // Set the userDetails attribute
        }
            request.setAttribute("showPostButton", showPostButton);  // Set the showPostButton attribute
        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/userpage/userpage.jsp");
        dispatcher.forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            // Ensure that "loggedInID" is set correctly in the session during login
            String userID = (String) request.getSession().getAttribute("loggedInID");
            Account account = sqlAccount.getAccountByID(userID);
            String username = account.getUsername();
            System.out.println(username);
    
            // Lấy dữ liệu còn lại từ form
            Part newFirstNamePart = request.getPart("newfirstName");
            Part newLastNamePart = request.getPart("newlastName");
            Part newAddressPart = request.getPart("newaddress");
            Part newBirthDatePart = request.getPart("newBirthDate");
    
            // Get values from Parts
            String newfirstName = getValueFromPart(newFirstNamePart);
            String newlastName = getValueFromPart(newLastNamePart);
            String newaddress = getValueFromPart(newAddressPart);
            String newBirthDateStr = getValueFromPart(newBirthDatePart);
            Part avatarPart = request.getPart("avatarName");
            Part backgroundPart = request.getPart("background");
    
            // Save images and get paths
            String avatarPath = saveImage(avatarPart, username, "avatar");
            String backgroundPath = saveImage(backgroundPart, username, "background");
 
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date parsedDate = sdf.parse(newBirthDateStr);
            java.sql.Date newBirthDate = new java.sql.Date(parsedDate.getTime());
    
            System.out.println("firstName: " + newfirstName + ", lastName: " + newlastName + ", address: " + newaddress);
            if (avatarPath != null) {
                System.out.println("Avatar saved to: " + avatarPath);
            }
            if (backgroundPath != null) {
                System.out.println("Background saved to: " + backgroundPath);
            }
                     String avatarFilePath =   avatarPath;
           if (avatarPath != null) {
                String prefixToRemove = "c:/tmp/resources/img/userdata/";
                    if (avatarFilePath.startsWith(prefixToRemove)) {
                avatarFilePath = avatarFilePath.substring(prefixToRemove.length());
                }
            }
              
            String backgroundFilePath = backgroundPath;
             if (backgroundPath != null) {
                         String prefixToRemove2 = "c:/tmp/resources/img/userdata/";
                    if (backgroundFilePath.startsWith(prefixToRemove2)) {
                backgroundFilePath = backgroundFilePath.substring(prefixToRemove2.length());
                }
            }

            System.out.println(avatarFilePath);
            System.out.println(backgroundFilePath);
            sqlAccountDetails.updateAccountdetails(userID, newfirstName, newlastName, newaddress, newBirthDate,avatarFilePath,backgroundFilePath);
            sendSuccessResponse(response, "Update thành công.");
        } catch (Exception e) {
            log("Exception occurred: " + e.getMessage());
            sendErrorResponse(response, "Đã xảy ra lỗi: " + e.getMessage());
        }
    }

private String getValueFromPart(Part part) throws IOException {
    BufferedReader reader = new BufferedReader(new InputStreamReader(part.getInputStream(), StandardCharsets.UTF_8));
    return reader.lines().collect(Collectors.joining());
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
    private String saveImage(Part part, String username, String type) throws IOException {
        // Check if no file is chosen
        if (part == null || part.getSize() == 0) {
            return null;
        }
    
        // If a file is chosen, proceed to save it
        String folderPath = "c:/tmp/resources/img/userdata/" + username + "/";
        int fileCount = countFilesInFolder(folderPath);
    
        String fileName = folderPath + (fileCount + 1) + getFileExtension(part);
        try (InputStream input = part.getInputStream();
             OutputStream output = new FileOutputStream(fileName)) {
    
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = input.read(buffer)) != -1) {
                output.write(buffer, 0, bytesRead);
            }
        }
        return fileName;
    }
    private String getFileExtension(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] tokens = contentDisposition.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                String fileName = token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
                int dotIndex = fileName.lastIndexOf('.');
                if (dotIndex > 0) {
                    return fileName.substring(dotIndex);
                }
            }
        }
        return "";
    }
    private int countFilesInFolder(String folderPath) {
        File folder = new File(folderPath);
        File[] files = folder.listFiles();
        if (files != null) {
            return files.length;
        } else {
            return 0;
        }
    }
}