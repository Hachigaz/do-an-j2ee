<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

      <c:set var="isExist" value="${isExist}" />
      <c:if test="${isExist=='true'}">
        <c:forEach var="item" items="${list}">
          <div id="search-friend-page">
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
              <div class="message">
                <a href="chat-messenger?showChatID=${item.chatID}">
                  <button>Message</button>
                </a>
              </div>
            </div>
        </c:forEach>
      </c:if>
      <c:if test="${isExist=='false'}">
        <div id="search-friend-page">          
            <div class="error">Không tìm thấy người dùng phù hợp</div>
          </div>        
      </c:if>