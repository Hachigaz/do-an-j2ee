<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css"> -->
<!DOCTYPE html>
<html>
  <head>
    
  </head>
  <body>
    <c:forEach var="comment" items="${comments}">
      <div class="comment-item">
        <div class="comment-avatar-icon-wrapper">
          <img src="resources/img/userdata/${}">
        </div>
        <div class="comment-bubble">
          <div class="comment-username">
            ${}
          </div>
          <div class="comment-text">
            ${}
          </div>
        </div>
        <div class="comment-options">
          <div class="comment-date">
            ${}
          </div>
          <div class="comment-like-button">
            Thích
          </div>
        </div>
      </div>
    </c:forEach>
  </body>
</html>