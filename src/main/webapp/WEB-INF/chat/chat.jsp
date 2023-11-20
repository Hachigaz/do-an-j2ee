<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css"> -->
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" href="resources/css/globals.css" />
    <link rel="stylesheet" href="resources/css/chat/style.css" />
    <link rel="stylesheet" href="resources/css/components/header.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    <script src="resources/scripts/utils/utils.js"></script>
    <script src="resources/scripts/chat/MessageBox.js"></script>
    <script src="resources/scripts/chat/MessagePage.js"></script>
    <script type="text/javascript">
      window.addEventListener('load',setupPage)
    </script>

</head>
  <body>
    <%@ include file="/WEB-INF/components/header/header.jsp" %>
    <div class="chat">
      <div class="content">
        <div class="friend-panel">
          <div class="friend-panel-frame">
            <!-- <div class="friend-item">
              <div class="username-frame"><div class="username">user123</div></div>
              <div class="avatar"><img class="user-avatar" src="" draggable="false"/></div>
            </div> -->
          </div>
        </div>
        <div class="chat-panel">
          <div class="no-chat-display">
            Chưa có tin nhắn
          </div>
          <div class="chat-display" onscroll="isScrolledTop(this)">
            <!-- <div class="chat-frame">
              <div class="message-frame">
                <div class="to-message">
                  <div class="user-avatar-wrapper">
                    <img class="img" src="/stored-user-images/jim_avt.png">
                  </div>
                  <div class="message-box">
                    <div class="message-user-wrapper">
                      <div class="user-fullname">Huy Gay</div>
                      <div class="message-text">Lorem ipsum dolor sit amet consectetur adipisicing elit. Ullam, obcaecati.</div>
                        <div class="date-sent">19:40</div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="message-frame">
                <div class="from-message">
                  <div class="message-user-wrapper">
                    <div class="user-avatar-wrapper"><img class="img" src="resources/img/profile-4.png" /></div>
                  </div>
                  <div class="message-box">
                    <div class="user-fullname">Thế Hiển</div>
                    <div class="message-text">Lorem ipsum dolor sit amet.</div>
                    <div class="date-sent">21:01</div>
                  </div>
                </div>
              </div>
            </div> -->
          </div>
          <div class="chat-box">
            <input type="text" class="text-input" placeholder="Nhập tin nhắn"></input>
            <button onclick="sendMessage()" class="submit"><i class="fa-solid fa-arrow-right"></i></button>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>