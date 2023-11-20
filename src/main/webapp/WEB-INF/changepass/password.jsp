<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css"> -->
<!DOCTYPE html>
<html>
  <head>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="resources/scripts/pass/pass.js"></script>
    </script>

</head>
<body>
    <h2>Change Password</h2>
        <form method="post" action="changepassword">
        
        
        <label for="currentPassword">Current Password:</label>
        <input type="password" id="currentPassword" name="currentPassword" required><br>
    
        <label for="newPassword">New Password:</label>
        <input type="password" id="newPassword" name="newPassword" required><br>
    
        <label for="confirmNewPassword">Confirm New Password:</label>
        <input type="password" id="confirmNewPassword" name="confirmNewPassword" required><br>
    
        <input type="submit" value="changepassword">
    </form>
    <script>
        function validateForm() {
            var currentPassword = document.getElementById("currentPassword").value;
            var newPassword = document.getElementById("newPassword").value;
            var confirmNewPassword = document.getElementById("confirmNewPassword").value;
    
            // Add your validation logic here
            if (newPassword !== confirmNewPassword) {
                alert("New password and confirm password do not match.");
                return false;
            }
    
            return true;
        }
    </script>
</body>
</html>
