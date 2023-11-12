<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link
            rel="stylesheet"
            href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
        />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="resources/css/friend.css" />
        <link rel="stylesheet" href="resources/css/components/header.css">
        <title>Document</title>
    </head>
    <body>
        <%@ include file="components/header.jsp" %>
        <div class="mt-20"></div>
        <div class="wrapper">
            <div class="menu">
                <div class="title">Bạn bè</div>
            </div>
            <div class="friend-wrapper">
                <div class="friend-list">
                    <div class="title col-md-12">
                        <span>Danh sách bạn bè</span>
                        <form action="" class="search-section">
                            <input type="text" class="search-friend" placeholder="Tìm kiếm bạn bè...">
                            <button class="search-button"><i class="fa-solid fa-magnifying-glass"></i></button>
                        </form>
                    </div>
                    <div class="wrapper-item">
                    
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script src="resources/scripts/friends.js"></script>
</html>
