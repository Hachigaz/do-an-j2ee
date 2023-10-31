<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Document</title>
        <link rel="stylesheet" href="resources/css/login.css"/>
    </head>
    <body>
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
                    <form action="home-page" method="post">
                        <div class="input-container">
                            <input type="text" name="LoginUsername" placeholder="Username">
                        </div>
                        <div class="input-container">
                            <input type="password" name="LoginPassword" placeholder="Password">
                        </div>
                        <div class="remember-and-forget">
                            <div class="remember">
                                <input type="checkbox">
                                <span class="remember-text">Remember me</span>
                            </div>
                            <a href="reset">Forgot your Password?</a>
                        </div>
                        <input type="submit" class="submit-login" value="Login">
                        <span class="register-desc">Don't have account <a href="#" class="register-link">Register</a></span>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
