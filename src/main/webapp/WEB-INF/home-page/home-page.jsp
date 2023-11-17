<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" href="resources/css/globals.css" />
    <link rel="stylesheet" href="resources/css/home/style.css" />
    <link rel="stylesheet" href="resources/css/components/header.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    
    
    <script src="resources/scripts/utils/utils.js"></script>
    <script src="resources/scripts/home-page/post.js"></script>
    <script src="resources/scripts/home-page/script.js"></script>
    
    <script type="text/javascript">
      window.addEventListener('load',start)
    </script>
  </head>
  <body class="main-page" onscroll="checkPostScroll(this)">
    <%@ include file="/WEB-INF/components/header/header.jsp" %>
    <div class="content-panel">
      <div class="menu-bar">

      </div>
      <div class="user-feed-panel">
        <div class="create-post-panel">

        </div>
        <div class="posts-frame">
          <!-- <c:forEach var="postItem" items="${postItems}">
            <c:import url="/WEB-INF/home-page/components/user-post.jsp">
              <c:param name="post" value="${postItem.post}"/>
            </c:import>
          </c:forEach> -->
        </div>
      </div>
      <div class="option-bar">
        
      </div>
    </div>
  </body>
</html>