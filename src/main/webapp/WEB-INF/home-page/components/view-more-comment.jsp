<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

            <c:set var="postID" value="${postID}" />
            <c:set var="isExistMoreComment" value="${isExistMoreComment}" />
            <c:if test="${isExistMoreComment=='true'}">
                <c:set var="commentQuantityOfPost" value="${commentQuantityOfPost}" />
                <c:set var="commentCount" value="${commentCount}" />
                <div class="text" onclick="getMoreComment('${postID}')">View more comments</div>
                <div class="comment-quanntity">${commentCount} of ${commentQuantityOfPost}</div>
            </c:if>

            <c:if test="${isExistMoreComment=='false'}">
            </c:if>