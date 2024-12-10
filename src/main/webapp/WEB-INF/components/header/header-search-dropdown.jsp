<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="isExist" value="${isExist}" />
<c:if test="${isExist=='true'}">
    <c:forEach var="item" items="${list}">
        <a href="userpage?userID=${item.userID}">
            <div class="card">
              <div class="user-img">
                <img src="/stored-user-images/${item.avatar}" alt="">
              </div>
              <div class="username">${item.firstName}
                ${item.lastName}</div>
            </div>
          </a>
    </c:forEach>
</c:if>
<c:if test="${isExist=='false'}">
    Không tìm thấy tài khoản phù hợp
</c:if>