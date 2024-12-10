<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Document</title>
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
        <script src="resources/scripts/regis/Regis.js"></script>
        <link rel="stylesheet" href="resources/css/login.css"/>

        <link rel="stylesheet" href="resources/css/regis/regis.css">
    </head>
    <body>
        <div id="registerForm" class="clearfix">    
            <span class="close-button" onclick="toggleRegisterForm()">X</span>
    
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
        <div class="login-page">
            <div class="img-login">
                <img
                    src="resources/img/image-login.png"
                    alt=""
                    class="img-login"
                />
                <span class="title-login">Connect to everyone</span>
            </div>
            <div class="container-login">
                <div class="login-form">
                    <span class="title-form">Login</span>
                    <form action="sign-in" method="post">
                        <div class="input-container">
                            <input type="text" name="LoginUsername" placeholder="Username">
                        </div>
                        <div class="input-container">
                            <input type="password" name="LoginPassword" placeholder="Password">
                        </div>
                        <!-- <div class="remember-and-forget">
                            <div class="remember">
                                <input type="checkbox">
                                <span class="remember-text">Remember me</span>
                            </div>
                        </div> -->
                        <input type="submit" class="submit-login" value="Login">
                        <span class="register-desc">Don't have account <a  class="register-link" onclick="toggleRegisterForm()">Register</a></span>
                    </form>
                </div>
            </div>
        </div>
    </body>

</html>
