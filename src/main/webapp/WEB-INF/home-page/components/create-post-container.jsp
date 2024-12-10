<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

            <c:set var="detail" value="${detail}" />
            <div class="top">
                <div class="title">Create post</div>
                <div id="close-create-post-card" onclick="document.getElementById('create-post-container').style.display = 'none'
                          document.getElementById(`pictures-container`).style.display = `none`">
                    <i class="fa-solid fa-xmark fa-lg"></i>
                </div>
                <div class="user">
                    <div class="left">
                        <div class="user-img">
                            <a href="userpage">
                                <img src="/stored-user-images/${detail.avatar}" alt="">
                            </a>
                        </div>
                    </div>
                    <div class="right">
                        <div class="username">${detail.firstName} ${detail.lastName}</div>
                    </div>
                </div>
            </div>
            <div class="middle">
                <textarea name="postContent" id="create-post-content-textarea" cols="35" rows="4"
                    placeholder="What's on your mind, ${detail.firstName}?"></textarea>
                <div id="pictures-container">
                    <div class="wrap">
                        <div id="close-add-pic-container" onclick="document.getElementById(`pictures-container`).style.display = `none`;
                            document.getElementById(`create-post-content-textarea`).rows = `4`;
                            resetFileInput('files');">
                            <i class="fa-solid fa-xmark fa-lg"></i>
                        </div>
                        <div id="inner" onclick="document.getElementById('files').click();">
                            <div class="title">
                                <div class="icon-wrap">
                                    <i class="fa-solid fa-cloud-arrow-up fa-lg"></i>
                                </div>
                                <div class="text">Add Photos/Videos
                                </div>
                            </div>
                        </div>
                        <div id="container" class="hide">
                            <div class="add-photo-btn" onclick="document.getElementById('files').click();">
                                <i class="fa-solid fa-square-plus fa-lg"></i> Add Photos/Videos
                                <input type="file" name="files" id="files" multiple="true"
                                    accept="image/jpeg, image/png, image/jpg" style="display: none">
                            </div>
                        </div>
                        <div id="create-post-upload-img">
                        </div>
                    </div>
                </div>
            </div>