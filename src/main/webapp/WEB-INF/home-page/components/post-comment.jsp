<!-- TEST -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


      <c:set var="postItem" value="${postItem}" />
      <!-- <div class="post-comment-container" id="post-comment-container-${postItem.post.postID}"> -->
      <div class="comment-card" id="post-comment-container-${postItem.post.postID}">
        <div class="title">
          ${userDetails[postItem.post.userID].firstName}
          ${userDetails[postItem.post.userID].lastName}'s Post
          <div class="close-post-comment-container"
            onclick="document.getElementById('post-comment-container').classList.toggle('active')">
            <i class="fa-solid fa-xmark fa-lg"></i>
          </div>
        </div>
        <div class="comment-card-main">
          <input type="hidden" name="postId" value="${postItem.post.postID}">
          <input type="hidden" name="pictureQuantity" value="${postItem.post.postID}">
          <input type="hidden" name="likedQuantity" id="innerLikedQuantity-${postItem.post.postID}"
            value="${postItem.post.likeCount}">
          <input type="hidden" name="commentQuantity" id="innerCommentQuantity-${postItem.post.postID}"
            value="${postItem.post.commentCount}">
          <input type="hidden" name="isInnerLiked-${postItem.post.postID}" id="isInnerLiked-${postItem.post.postID}"
            value="${postItem.isLikedByUser}">
          <div class="top">
            <a href="userpage?userID=${postItem.post.userID}">
              <div class="user-img">
                <img src="/stored-user-images/${userDetails[postItem.post.userID].avatar}" alt="">
              </div>
            </a>
            <div class="user-info">
              <a href="userpage?userID=${postItem.post.userID}">
                <div class="name">${userDetails[postItem.post.userID].firstName}
                  ${userDetails[postItem.post.userID].lastName}
                </div>
              </a>
              <div class="time">${postItem.fDatePosted}</div>
            </div>
          </div>
          <div class="content">
            <div class="text">
              <c:set var="paragraphs" value="${fn:split(postItem.post.description,newLineChar)}" />
              <c:forEach var="para" items="${paragraphs}">
                ${para}
              </c:forEach>
            </div>
            <div class="post-picture-container">
              <c:if test="${fn:length(postItem.images)>0}">
                <c:choose>
                  <c:when test="${fn:length(postItem.images)==1}">
                    <div class="pictures-line-1">
                      <img src="/stored-user-images/${postItem.images[0].image}" alt=""
                        onclick="openImageDetail('/stored-user-images/${postItem.images[0].image}')">
                    </div>
                  </c:when>
                  <c:when test="${fn:length(postItem.images)==2}">
                    <div class="pictures-line-1">
                      <img src="/stored-user-images/${postItem.images[0].image}" alt=""
                        onclick="openImageDetail('/stored-user-images/${postItem.images[0].image}')">
                    </div>
                    <div class="pictures-line-1">
                      <img src="/stored-user-images/${postItem.images[1].image}" alt=""
                        onclick="openImageDetail('/stored-user-images/${postItem.images[1].image}')">
                    </div>
                  </c:when>
                  <c:when test="${fn:length(postItem.images)==3}">
                    <div class="pictures-line-1">
                      <img src="/stored-user-images/${postItem.images[0].image}" alt=""
                        onclick="openImageDetail('/stored-user-images/${postItem.images[0].image}')">
                    </div>
                    <div class="pictures-line-1">
                      <img src="/stored-user-images/${postItem.images[1].image}" alt=""
                        onclick="openImageDetail('/stored-user-images/${postItem.images[1].image}')">
                    </div>
                    <div class="pictures-line-1">
                      <img src="/stored-user-images/${postItem.images[2].image}" alt=""
                        onclick="openImageDetail('/stored-user-images/${postItem.images[2].image}')">
                    </div>
                  </c:when>
                  <c:when test="${fn:length(postItem.images)==4}">
                    <div class="pictures-line-1">
                      <img src="/stored-user-images/${postItem.images[0].image}" alt=""
                        onclick="openImageDetail('/stored-user-images/${postItem.images[0].image}')">
                    </div>
                    <div class="pictures-line-1">
                      <img src="/stored-user-images/${postItem.images[1].image}" alt=""
                        onclick="openImageDetail('/stored-user-images/${postItem.images[1].image}')">
                    </div>
                    <div class="pictures-line-2">
                      <img src="/stored-user-images/${postItem.images[2].image}" alt=""
                        onclick="openImageDetail('/stored-user-images/${postItem.images[2].image}')">
                    </div>
                    <div class="pictures-line-2">
                      <img src="/stored-user-images/${postItem.images[3].image}" alt=""
                        onclick="openImageDetail('/stored-user-images/${postItem.images[3].image}')">
                    </div>
                  </c:when>
                  <c:when test="${fn:length(postItem.images)>4}">
                    <div class="pictures-line-1">
                      <img src="/stored-user-images/${postItem.images[0].image}" alt=""
                        onclick="openImageDetail('/stored-user-images/${postItem.images[0].image}')">
                    </div>
                    <div class="pictures-line-1">
                      <img src="/stored-user-images/${postItem.images[1].image}" alt=""
                        onclick="openImageDetail('/stored-user-images/${postItem.images[1].image}')">
                    </div>
                    <div class="pictures-line-2">
                      <img src="/stored-user-images/${postItem.images[2].image}" alt=""
                        onclick="openImageDetail('/stored-user-images/${postItem.images[2].image}')">
                    </div>
                    <div class="pictures-line-2">
                      <div class="see-more-pic-container"
                        onclick="openImageDetail('/stored-user-images/${postItem.images[3].image}')">+
                        ${fn:length(postItem.images) - 4 + 1}</div>
                      <img src="/stored-user-images/${postItem.images[3].image}" alt="">
                    </div>
                  </c:when>
                </c:choose>
              </c:if>
            </div>
          </div>
          <div class="interact-container">
            <div class="top">
              <div id="likeNumberId-${postItem.post.postID}" class="like-number">
                <c:if test="${!postItem.isLikedByUser}">
                  <div class="wrap">
                    <i class="fa-solid fa-thumbs-up fa-sm"></i>
                  </div>
                  <div class="count-number">
                    ${postItem.post.likeCount} Like
                  </div>
                </c:if>
                <c:if test="${postItem.isLikedByUser}">
                  <div class="wrap">
                    <i class="fa-solid fa-thumbs-up fa-sm"></i>
                  </div>
                  You and ${postItem.post.likeCount - 1} others
                </c:if>
              </div>
              <div id="commentNumberId-${postItem.post.postID}" class="comment-number">
                <i class="fa-regular fa-comment fa-lg"></i>
                ${postItem.post.commentCount} Comment
              </div>
            </div>
            <div class="bottom">
              <c:if test="${!postItem.isLikedByUser}">
                <div id="likePost-${postItem.post.postID}" class="container" onclick="; 
                    processLike('${postItem.post.postID}',this) ">
                  <i class="fa-regular fa-thumbs-up fa-2x"></i> Like
              </c:if>
              <c:if test="${postItem.isLikedByUser}">
                <div id="likePost-${postItem.post.postID}" class="container liked" onclick=";
                    processLike('${postItem.post.postID}',this)">
                  <i class="fa-solid fa-thumbs-up fa-2x"></i> Like
              </c:if>
            </div>
            <div class="container">
              <i class="fa-regular fa-comment fa-2x"></i> Comment
            </div>
          </div>
          <div class="comments-container">

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
          </div>
          <c:set var="isExistMoreComment" value="${isExistMoreComment}" />
            <c:if test="${isExistMoreComment=='true'}">
              <c:set var="commentQuantityOfPost" value="${commentQuantityOfPost}" />
              <c:set var="commentCount" value="${commentCount}" />
              <div id="view-more-comment" class="active">
                  <div class="text" onclick="getMoreComment('${postItem.post.postID}')">View more comments</div>
                  <div class="comment-quanntity">${commentCount} of ${commentQuantityOfPost}</div>
              </div>
            </c:if>
        </div>
      </div>
      <div class="create-comment">
        <div class="user-img">
          <img src="/stored-user-images/${loggedInDetails.avatar}" alt="">
        </div>
        <div class="input-container">
          <input type="text" name="content-${postItem.post.postID}"
            id="post-comment-submit-content-${postItem.post.postID}" placeholder="Write a public comment..."
            onkeypress="submitCommentByPressEnter('${postItem.post.postID}', event)">
          <button onclick="processSubmitComment('${postItem.post.postID}')">
            <i class="fa-solid fa-paper-plane fa-lg"></i>
          </button>
        </div>
      </div>
      </div>