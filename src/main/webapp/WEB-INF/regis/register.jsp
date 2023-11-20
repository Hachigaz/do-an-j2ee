<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
  <head>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <link rel="stylesheet" href="resources/css/regis/regis.css">

</head>
<body>
    <div id="registerForm" class="clearfix">        
        <form id="userregisterForm" action="register" method="post" enctype="multipart/form-data">
            <label class="inline-label" for="username">Username:</label>
            <input class="inline-input" type="text" id="username" name="username" required>
    
            <label class="inline-label" for="email">Email:</label>
            <input class="inline-input" type="email" id="email" name="email" required>
    
            <label class="inline-label" for="password">Password:</label>
            <input class="inline-input" type="password" id="password" name="password" required>
    
            <input class="inline-input1" type="text" id="address" name="address" required placeholder="address"> <br>

            <input class="inline-input2" type="text" id="firstName" name="firstName" required placeholder="FirstName">
            <input class="inline-input2" type="text" id="lastName" name="lastName" required placeholder="lastName">
            
    
            <label  class="inline-label"  for="birthDate">Ngày sinh:</label>
            <input  class="inline-input" type="date" id="birthDate" name="birthDate" required>
    
            <label class="inline-label"  for="avatarName">Avatar:</label>
            <input class="inline-input" type="file" id="avatarName" name="avatarName" accept="image/*">
    
            <label class="inline-label" for="background">Background:</label>
            <input  class="inline-input" type="file" id="background" name="background" accept="image/*">
    
            <input type="submit" value="register">
        </form>
    </div>
    
    <script>
$(document).ready(function () {
    $('#registerForm').submit(function (event) {
        event.preventDefault();

        var formData = new FormData($('#userregisterForm')[0]);
        var birthDate = $('#birthDate').val();
        formData.append('birthDate', birthDate);
        $.ajax({
            type: 'POST',
            url: 'register',
            contentType: false,
            processData: false,
            data: formData,
            success: function (response) {
                console.log(response);
                // Handle success, e.g., show a success message
            },
            error: function (xhr, status, error) {
                console.error(xhr.responseText);
                // Handle error, e.g., show an error message
            }
        });
    });
});

    </script>
</body>
</html>
