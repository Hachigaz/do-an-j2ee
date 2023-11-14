<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" href="resources/css/home/components/user-post/style.css" />
    <% pageContext.setAttribute("newLineChar", "\n"); %> 
  </head>
  <body>
    <c:forEach var="postItem" items="${postItems}">
      <div class="post-item" id="post-item-${postItem.post.postID}">
        <div class="post-panel">
          <div class="post-head">
            <div class="user-icon-wrapper">
              <img class="user-icon" src="resources/img/userdata/${userDetails[postItem.post.userID].avatar}">
            </div>
            <div class="user-info-wrapper">
              <div class="user-name">
                ${userDetails[postItem.post.userID].firstName} ${userDetails[postItem.post.userID].lastName}
              </div>
              <div class="post-date">
                ${postItem.fDatePosted}
              </div>
            </div>
          </div>
  
          <div class="post-content">
            <div class="post-text-wrapper">
              <div class="post-text">
                <c:set var="paragraphs" value="${fn:split(postItem.post.description,newLineChar)}"/>
                <c:forEach var="para" items="${paragraphs}">
                  <div class="post-text-para">    
                    ${para}
                  </div>
                </c:forEach>
              </div>
              <br>
              <div class="post-image-display">
                <c:if test="${fn:length(postItem.images)>0}">
                  <c:choose>
                    <c:when test="${fn:length(postItem.images)==1}">
                      <div class="post-image-item-large">
                        <img class="post-attached-image" src="resources/img/userdata/${postItem.images[0].image}">
                      </div>
                    </c:when>
                    <c:when test="${fn:length(postItem.images)==2}">
                      <div class="post-image-item-small-wrapper">
                        <div class="post-image-item-small">
                          <img class="post-attached-image" src="resources/img/userdata/${postItem.images[0].image}">
                        </div>
                        <div class="post-image-item-small">
                          <img class="post-attached-image" src="resources/img/userdata/${postItem.images[1].image}">
                        </div>
                      </div>
                    </c:when>
                    <c:when test="${fn:length(postItem.images)==3}">
                      <div class="post-image-item-large">
                        <img class="post-attached-image" src="resources/img/userdata/${postItem.images[0].image}">
                      </div>
                      <div class="post-image-item-small-wrapper">
                        <div class="post-image-item-small">
                          <img class="post-attached-image" src="resources/img/userdata/${postItem.images[1].image}">
                        </div>
                        <div class="post-image-item-small">
                          <img class="post-attached-image" src="resources/img/userdata/${postItem.images[2].image}">
                        </div>
                      </div>
                    </c:when>
                    <c:when test="${fn:length(postItem.images)>3}">
                      <div class="post-image-item-large">
                        <img class="post-attached-image" src="resources/img/userdata/${postItem.images[0].image}">
                      </div>
                      <div class="post-image-item-small-wrapper">
                        <div class="post-image-item-small">
                          <img class="post-attached-image" src="resources/img/userdata/${postItem.images[1].image}">
                        </div>
                        <div class="post-image-item-small">
                          <img class="post-attached-image" src="resources/img/userdata/${postItem.images[2].image}">
                          <div class="image-overlay"></div>
                        </div>
                      </div>
                    </c:when>
                  </c:choose>
                </c:if>
              </div>
            </div>
          </div>
  
          <div class="post-end">
            <div class="post-stat no-select">
              <div class="like-count">
                <div class="count-number">
                  ${postItem.post.likeCount}
                </div>
                <div class="stat-like-icon-wrapper">
                  <img src="resources/img/web_img/home-page/like.png">
                </div>
                  
              </div>
              <div class="comment-count">
                <div class="count-number">
                  ${postItem.post.commentCount}
                </div>
                <div class="stat-like-icon-wrapper">
                  <img src="resources/img/web_img/home-page/comment.png">
                </div>
              </div>
            </div>
            <div class="post-options">
              <c:if test="${not postItem.isLikedByUser}">
                <div class="option-button-wrapper no-select" onclick="processLike('${postItem.post.postID}',this)">
                  <div class="option-icon-wrapper">
                    <img class="unclicked-icon show-icon" src="resources/img/web_img/home-page/like.png">
                    <img class="clicked-icon hide-icon" src="resources/img/web_img/home-page/like-clicked.png">
                  </div>
                  <div class="option-name">
                    Thích
                  </div>
                </div>
              </c:if>

              <c:if test="${postItem.isLikedByUser}">
                <div class="option-button-wrapper no-select clicked" onclick="processLike('${postItem.post.postID}',this)">
                  <div class="option-icon-wrapper">
                    <img class="unclicked-icon hide-icon" src="resources/img/web_img/home-page/like.png">
                    <img class="clicked-icon show-icon clicked" src="resources/img/web_img/home-page/like-clicked.png">
                  </div>
                  <div class="option-name">
                    Thích
                  </div>
                </div>
              </c:if>
              <div class="option-button-wrapper no-select" onclick="processComment('${postItem.post.postID}')">
                <div class="option-icon-wrapper">
                  <img src="resources/img/web_img/home-page/comment.png">
                </div>
                <div class="option-name">
                  Bình luận
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="comment-section" id="comment-section-${postItem.post.postID}">
          <div class="comment-section-title">Bình luận</div>
          <div class="send-comment-form">
            <div class="comment-avatar-icon-wrapper">
              <img src="resources/img/userdata/${userDetails[sessionScope.loggedInID].avatar}">
            </div>
            <div class="comment-input-wrapper">
              <textarea placeholder="Nhập bình luận" value=""
                oninput="(function(textElement){})(this)"></textarea>
              <div class="comment-input-options">
                <div class="submit-comment-button" onclick="processSubmitComment('${postItem.post.postID}')">Gửi</div>
              </div>
            </div>
          </div>
          <div class="comment-list">
            
          </div>
        </div>
      </div>
    </c:forEach>
  </body>
</html>