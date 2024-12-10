<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

      <c:set var="postID" value="${postID}" />
      <c:forEach var="commentItem" items="${commentItems}">
        <div class="comment">
          <div class="user-img">
            <a href="userpage?userID=${commentItem.userDetails.userID}">
              <img src="/stored-user-images/${commentItem.userDetails.avatar}" alt="User's Image">
            </a>
          </div>
          <div class="right">
            <div class="content">
              <div class="username">
                <a href="userpage?userID=${commentItem.userDetails.userID}">${commentItem.userDetails.firstName} ${commentItem.userDetails.lastName}</a>
              </div>
              <div class="text">
                ${commentItem.comment.comment}
              </div>
            </div>
            <div class="time">${commentItem.comment.date}</div>
          </div>
        </div>
      </c:forEach>
      <c:set var="isExistMoreComment" value="${isExistMoreComment}" />
      <c:if test="${isExistMoreComment=='true'}">
        <c:set var="commentQuantityOfPost" value="${commentQuantityOfPost}" />
        <c:set var="commentCount" value="${commentCount}" />
      </c:if>

      <c:if test="${isExistMoreComment=='false'}">
        <script>
          let viewMoreCommentDiv = document.querySelector("#post-comment-container-${postID} #view-more-comment");
          viewMoreCommentDiv.classList.remove("active");
        </script>
      </c:if>
