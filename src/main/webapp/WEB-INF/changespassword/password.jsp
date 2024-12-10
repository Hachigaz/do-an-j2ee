<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html>

    <head>
      <link rel="stylesheet" href="resources/css/home/globals.css" />
      <link rel="stylesheet" href="resources/css/home/style.css" />
      <link rel="stylesheet" href="resources/css/components/header.css">
      <link rel="stylesheet" href="resources/css/components/left-menu.css">
      <link rel="stylesheet" href="resources/css/pass/pass.css">

      <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500&display=swap" rel="stylesheet">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
        integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />

      <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
      <script src="resources/scripts/pass/pass.js"></script>


      <script type="text/javascript">
        window.addEventListener('load', start);
      </script>
    </head>

    <body class="main-page">
      <div id="blur-container"></div>
      <%@ include file="/WEB-INF/components/header/header.jsp" %>

        <div id="main">
          <%@ include file="/WEB-INF/components/left-menu/left-menu.jsp" %>        
          <h2>Change Password</h2>
          
          <form method="post" action="changepassword">
          
          <button id="close-button" onclick="goToHomePage()">X</button>
          <label for="currentPassword">Current Password:</label>
          <input type="password" id="currentPassword" name="currentPassword" required><br>
      
          <label for="newPassword">New Password:</label>
          <input type="password" id="newPassword" name="newPassword" required><br>
      
          <label for="confirmNewPassword">Confirm New Password:</label>
          <input type="password" id="confirmNewPassword" name="confirmNewPassword" required><br>
      
          <input type="submit" value="Đổi mật khẩu">  
            </div>
    </body>
    <script>
      function goToHomePage() {
        window.location.href = "home-page";
      }
    </script>
    </html>