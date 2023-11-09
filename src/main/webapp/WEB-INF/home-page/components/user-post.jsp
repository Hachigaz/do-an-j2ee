<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" href="resources/css/home/components/user-post/style.css" />
  </head>
  <body>
    <c:forEach var="postItem" items="${postItems}">
      <div class="post-panel">
        <div class="post-head">
          <div class="author-wrapper">
            <div class="user-icon-wrapper">
              <img src="resources/img/userdata/${userDetails[postItem.userID].avatar}">
            </div>
            <div class="user-name">
              ${userDetails[postItem.userID].firstName} ${userDetails[postItem.userID].lastName}
            </div>
            <div class="post-date">
              ${postItem.datePosted}
            </div>
          </div>
        </div>

        <div class="post-content">
            <div class="post-text">
              ${postItem.description}
            </div>
            <div class="post-images">
              <!-- hinh anh bai viet -->
            </div>
        </div>

        <div class="post-end">
          <!-- like comment subrise -->
          <c:import url="/WEB-INF/home-page/components/comment-section.jsp">
              <c:param name="itemValue" value="${item}"/>
          </c:import>
        </div>
      </div>
    </c:forEach>
  </body>
</html>