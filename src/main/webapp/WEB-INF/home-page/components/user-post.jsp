<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

			<c:set var="isFirstLoad" value="${isFirstLoad}" />
			<c:if test="${isFirstLoad=='true'}">
				<c:forEach var="postItem" items="${postItems}">
					<div class="post-card" id="post-card-${postItem.post.postID}">
						<input type="hidden" name="postId" value="${postItem.post.postID}">
						<input type="hidden" name="pictureQuantity" value="${postItem.post.postID}">
						<input type="hidden" name="likedQuantity" id="likedQuantity-${postItem.post.postID}"
							value="${postItem.post.likeCount}">
						<input type="hidden" name="commentQuantity" id="innerCommentQuantity-${postItem.post.postID}"
							value="${postItem.post.commentCount}">
						<input type="hidden" name="isLiked-${postItem.post.postID}" id="isLiked-${postItem.post.postID}"
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
										${userDetails[postItem.post.userID].lastName}</div>
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
													onclick="openImageDetail('/stored-user-images/${postItem.images[3].image}')">
													+
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
										<div class="count-number">${postItem.post.likeCount} Like</div>
									</c:if>
									<c:if test="${postItem.isLikedByUser}">
										<div class="wrap">
											<i class="fa-solid fa-thumbs-up fa-sm"></i>
										</div>
										You and ${postItem.post.likeCount - 1} others
									</c:if>
								</div>
								<div id="commentNumberId-${postItem.post.postID}" class="comment-number" onclick="openPostCommentCard('${postItem.post.postID}');
                getPostDetail('${postItem.post.postID}')">
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
							<div class="container" id="comment-section-${postItem.post.postID}" onclick="openPostCommentCard('${postItem.post.postID}');
                getPostDetail('${postItem.post.postID}')">
								<i class="fa-regular fa-comment fa-2x"></i> Comment
							</div>
						</div>
					</div>
					</div>


				</c:forEach>
			</c:if>

			<c:if test="${isFirstLoad=='false'}">
				<c:set var="isExistMorePost" value="${isExistMorePost}" />
				<c:if test="${isExistMorePost=='true'}">
					<c:forEach var="postItem" items="${postItems}">
						<div class="post-card" id="post-card-${postItem.post.postID}">
							<input type="hidden" name="postId" value="${postItem.post.postID}">
							<input type="hidden" name="pictureQuantity" value="${postItem.post.postID}">
							<input type="hidden" name="likedQuantity" id="likedQuantity-${postItem.post.postID}"
								value="${postItem.post.likeCount}">
							<input type="hidden" name="commentQuantity"
								id="innerCommentQuantity-${postItem.post.postID}" value="${postItem.post.commentCount}">
							<input type="hidden" name="isLiked-${postItem.post.postID}"
								id="isLiked-${postItem.post.postID}" value="${postItem.isLikedByUser}">
							<div class="top">
								<a href="userpage?userID=${postItem.post.userID}">
									<div class="user-img">
										<img src="/stored-user-images/${userDetails[postItem.post.userID].avatar}" alt="">
									</div>
								</a>
								<div class="user-info">
									<a href="userpage?userID=${postItem.post.userID}">
										<div class="name">${userDetails[postItem.post.userID].firstName}
											${userDetails[postItem.post.userID].lastName}</div>
									</a>
									<div class="time">${postItem.fDatePosted}</div>
								</div>
							</div>
							<div class="content">
								<div class="text">
									<c:set var="paragraphs"
										value="${fn:split(postItem.post.description,newLineChar)}" />
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
														onclick="openImageDetail('/stored-user-images/${postItem.images[3].image}')">
														+
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
											<div class="count-number">${postItem.post.likeCount} Like</div>
										</c:if>
										<c:if test="${postItem.isLikedByUser}">
											<div class="wrap">
												<i class="fa-solid fa-thumbs-up fa-sm"></i>
											</div>
											You and ${postItem.post.likeCount - 1} others
										</c:if>
									</div>
									<div id="commentNumberId-${postItem.post.postID}" class="comment-number" onclick="openPostCommentCard('${postItem.post.postID}');
                getPostDetail('${postItem.post.postID}')">
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
								<div class="container" id="comment-section-${postItem.post.postID}" onclick="openPostCommentCard('${postItem.post.postID}');
                getPostDetail('${postItem.post.postID}')">
									<i class="fa-regular fa-comment fa-2x"></i> Comment
								</div>
							</div>
						</div>
						</div>
					</c:forEach>
				</c:if>
				<c:if test="${isExistMorePost=='false'}">

				</c:if>
			</c:if>