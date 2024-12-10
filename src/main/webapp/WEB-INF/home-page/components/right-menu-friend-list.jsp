<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

            <c:set var="hasFriend" value="${hasFriend}" />
            <c:if test="${hasFriend=='true'}">
                <c:forEach var="item" items="${accountDetailList}">
                    <div class="card">
                        <div class="user-img">
                            <a href="userpage?userID=${item.userID}">
                                <img src="/stored-user-images/${item.avatar}" alt="">
                            </a>
                        </div>
                        <div class="name">
                            <a href="userpage?userID=${item.userID}">${item.firstName}
                                ${item.lastName}</a>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
            <c:if test="${hasFriend=='false'}">
                <div class="alert">You have no friend</div>
            </c:if>