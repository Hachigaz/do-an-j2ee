<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html>

    <head>
      <link rel="stylesheet" href="resources/css/home/globals.css" />
      <link rel="stylesheet" href="resources/css/home/style.css" />
      <link rel="stylesheet" href="resources/css/components/header.css">
      <link rel="stylesheet" href="resources/css/components/left-menu.css">
      <link rel="stylesheet" href="resources/css/components/main-content.css">
      <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500&display=swap" rel="stylesheet">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
        integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />

      <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
      <script src="resources/scripts/utils/utils.js"></script>
      <script src="resources/scripts/home-page/post.js"></script>
      <script src="resources/scripts/home-page/script.js"></script>

      <script type="text/javascript">
        window.addEventListener('load', start);
      </script>
    </head>

    <body class="main-page">
      <%@ include file="/WEB-INF/components/header/header.jsp" %>

        <div id="main">
          <%@ include file="/WEB-INF/components/left-menu/left-menu.jsp" %>

            <div class="main-content" id="main-content" onscroll="checkScroll(this)">
              <div id="create-post-interface">
                <div class="top">
                  <div class="user-img">
                  </div>
                  <div class="container">
                    <div id="open-create-post-card"
                      onclick="document.getElementById('create-post-container').style.display = 'flex'">What's on your
                      mind?
                    </div>
                  </div>
                </div>
                <div class="bottom">
                  <div class="action">
                    <button id="open-post-picture" onclick="document.getElementById('create-post-container').style.display = 'flex';
                      document.getElementById(`pictures-container`).style.display = `block`;
                      document.getElementById(`create-post-content-textarea`).rows = `2`">
                      <i class="fa-regular fa-image fa-2x" style="color: rgb(16, 216, 118);"></i>
                      Photo/Video
                    </button>
                  </div>
                </div>
              </div>
              <div id="post-list">
              </div>
              <div id="loading-container" class="hehe ">
                <img src="resources/img/loading.gif">
              </div>
            </div>

            <div class="right-menu-container">
              <div class="inner">
                <div class="top">
                  <div class="title">Friend List</div>
                  <div class="see-all">
                    <a href="friend-page">See all</a>
                  </div>
                </div>
                <div class="list">
                  
                </div>
              </div>
            </div>
        </div>

        <div id="create-post-container">
          <form id="create-post-card" action="AddNewPost" method="post" enctype="multipart/form-data">
            <!-- <form id="create-post-card"> -->
            <!-- <div class="top">
              <div class="title">Create post</div>
              <div id="close-create-post-card" onclick="document.getElementById('create-post-container').style.display = 'none'
                    document.getElementById(`pictures-container`).style.display = `none`">
                <i class="fa-solid fa-xmark fa-lg"></i>
              </div>
              <div class="user">
                <div class="left">
                  <div class="user-img">
                    <a href="">
                      <img src="/stored-user-images/${sessionScope.loggedInDetails.avatar}" alt="">
                    </a>
                  </div>
                </div>
                <div class="right">
                  <div class="username">${sessionScope.loggedInDetails.firstName}</div>
                </div>
              </div>
            </div>
            <div class="middle">
              <textarea name="postContent" id="create-post-content-textarea" cols="35" rows="4"
                placeholder="What's on your mind, ${sessionScope.loggedInDetails.firstName}"></textarea>
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
            </div> -->
            <div class="bottom">
              <div class="option-container">
                <div class="title">Add to your post</div>
                <div class="options">
                  <div id="option1" class="option" onclick="document.getElementById(`pictures-container`).style.display = `block`;
                      document.getElementById(`create-post-content-textarea`).rows = `2`;
                      document.getElementById('inner').style.display = 'flex';
                      document.getElementById('container').classList.add('hide');">
                    <div id="name1" class="name">Photo/Video</div>
                    <i class="fa-regular fa-image fa-lg" style="color: rgb(16, 216, 118);"></i>
                  </div>
                  <div id="option2" class="option">
                    <div id="name2" class="name">Feeling/Activity</div>
                    <i class="fa-regular fa-face-laugh fa-lg" style="color: rgb(254, 148, 49);"></i>
                  </div>
                </div>
              </div>
              <div class="submit-container">
                <input id="createPostSubmit" type="submit" value="Post" onclick="//processAddNewPost(event)">
              </div>
            </div>
          </form>
        </div>

        <div class="post-comment-container" id="post-comment-container">
        </div>

        <div id="post-image-detail-container">
          <div class="inner">
            <div id="close-post-image-detail-container">
              <i class="fa-solid fa-xmark fa-2x"
                onclick="document.getElementById('post-image-detail-container').classList.toggle('active')"></i>
            </div>
            <div class="main">
            </div>
          </div>
        </div>
    </body>
    </html>