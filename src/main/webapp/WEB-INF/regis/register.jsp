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
            <label style="font-weight: bold; font-size: 20px;">Đăng ký</label><br>
            <label >Nhanh chóng và dễ dàng. </label><br>
            <label >__________________________________________ </label><br>
                    

            <label class="inline-label" for="username">Username:</label>
            <input class="inline-input" type="text" id="username" name="username" required>
    
            <label class="inline-label" for="email">Email:</label>
            <input class="inline-input" type="email" id="email" name="email" required>
    
            <label class="inline-label" for="password">Password:</label>
            <input class="inline-input" type="password" id="password" name="password" required>
    
            <input class="inline-input1" type="text" id="address" name="address" required placeholder="Địa chỉ"> <br>

            <input class="inline-input2" type="text" id="firstName" name="firstName" required placeholder="Tên">
            <input class="inline-input2" type="text" id="lastName" name="lastName" required placeholder="Họ">
            
    
            <label  class="inline-label"  for="birthDate">Ngày sinh:</label>
            <input  class="inline-input" type="date" id="birthDate" name="birthDate" required>
    
            <label class="inline-label"  for="avatarName">Avatar:</label>
            <input class="inline-input" type="file" id="avatarName" name="avatarName" accept="image/*" required>
    
            <label class="inline-label" for="background">Background:</label>
            <input  class="inline-input" type="file" id="background" name="background" accept="image/*" required>
    
            <input type="submit" value="Đăng ký">
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

                if (response.status === "error") {
                    alert(response.message); // Display only the message part for errors
                } else {
                    alert(response.message); // Display success message

                    // Delay for 4 seconds before redirecting to the "/sign-in" page
                    setTimeout(function () {
                        window.location.href = "sign-in";
                    }, 2000); // 4000 milliseconds = 4 seconds
                }
            },
            error: function (xhr, status, error) {
                console.error(xhr.responseText);
                alert(response.message); 
                // Handle error, e.g., show an error message
            }
        });
    });
});

    </script>
</body>
</html>
