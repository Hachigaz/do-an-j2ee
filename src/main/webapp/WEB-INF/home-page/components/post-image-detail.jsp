<!-- TEST -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

            <c:set var="currentImg" value="${currentImg}" />
            <c:set var="preImg" value="${preImg}" />
            <c:set var="nextImg" value="${nextImg}" />
            <div id="post-image-detail">
                <img src="${currentImg}" alt="">
            </div>
            <div id="to-left-img" onclick="getPreOrNextImage('${preImg}')">
                <i class="fa-solid fa-chevron-left fa-2x"></i>
            </div>
            <div id="to-right-img" onclick="getPreOrNextImage('${nextImg}')">
                <i class="fa-solid fa-chevron-right fa-2x"></i>
            </div>