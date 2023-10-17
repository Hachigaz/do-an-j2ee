<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css"> -->
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" href="resources/css/chat/globals.css" />
    <link rel="stylesheet" href="resources/css/chat/styleguide.css" />
    <link rel="stylesheet" href="resources/css/chat/style.css" />
    <link rel="stylesheet" href="resources/css/components/header.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Fredoka:wght@600&family=Lato&display=swap" rel="stylesheet">
    <script src="resources/scripts/chat/chat-render.js"></script>
  </head>
  <body onload="startupPage()">
    <div class="chat">
      <%@ include file="/WEB-INF/components/header.jsp" %>
    </div>
  </body>
</html>