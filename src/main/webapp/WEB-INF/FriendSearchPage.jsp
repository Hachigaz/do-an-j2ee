<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:forEach var="item" items="${list}">
<div class="col-md-3 item">
    <div class="avatar">
        <img src="/stored-user-images/${item.avatar}">
    </div>
    <div class="user-name">${item.firstName}
        ${item.lastName}</div>
    <div class="status-wrapper dropdown-select" id="dropdown-select-${item.userID}" onclick="openDropdown('${item.userID}')">
        <div class="status">Bạn bè</div>
        <i class="fa-solid fa-caret-down dropdown-caret"></i>
        <div class="dropdown-list">
            <div class="dropdown-item" onclick="showDialog('${item.firstName} ${item.lastName}'); confirmRemove('${item.userID}');">
                <span id="${item.userID}" data-fullname="${item.firstName} ${item.lastName}">Unfriend</span>
                <img class="unfriend-icon" src="resources/img/icon/remove-contact.png">
            </div>
            <div class="dropdown-item">
                <a href="chat-messenger?showChatID=${item.chatID}" style="text-decoration: none; color: rgb(51, 51, 51);">Nhắn tin</a>
                <img class="chat-icon" src="resources/img/icon/chat.png">
            </div>
        </div>
    </div>
</div>
    
  </c:forEach>