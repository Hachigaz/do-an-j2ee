<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css"> -->
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" href="resources/css/home/components/comment-section/style.css" />
  </head>
  <body>
    <c:forEach var="commentItem" items="${commentItems}">
      <div class="comment-item">
        <div class="comment-avatar-icon-wrapper">
          <img src="resources/img/userdata/${commentItem.userDetails.avatar}">
        </div>
        <div class="comment-content">
          <div class="comment-bubble">
            <div class="comment-username">
              ${commentItem.userDetails.firstName} ${commentItem.userDetails.lastName}
            </div>
            <div class="comment-text">
              ${commentItem.comment.comment}
            </div>
          </div>
          <div class="comment-options">
            <div class="comment-date">
              ${commentItem.fDateSent}
            </div>
            <!-- <c:if test="${commentItem.isLikedByUser}">
              <div class="comment-like-button clicked" onclick="processLikeComment()">
                Thích
              </div>
            </c:if>

            <c:if test="${not commentItem.isLikedByUser}">
              <div class="comment-like-button" onclick="processLikeComment()">
                Thích
              </div>
            </c:if> -->
          </div>
        </div>
      </div>
    </c:forEach>
  </body>
</html>