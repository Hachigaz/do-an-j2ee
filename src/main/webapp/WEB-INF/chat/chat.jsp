<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css"> -->
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" href="resources/css/chat/globals.css" />
    <link rel="stylesheet" href="resources/css/chat/styleguide.css" />
    <link rel="stylesheet" href="resources/css/chat/style.css" />

    <script src="resources/scripts/chat/chat-render.js"></script>
  </head>
  <body onload="startupPage()">
    <div class="chat">
      <header class="header">
        <div class="logo"><div class="text-wrapper">My Social Network</div></div>
        <div class="home-icon">
          <img class="property-alt" src="resources/img/property-1-alt.png" />
          <img class="property-default" src="resources/img/property-1-default.svg" />
        </div>
      </header>
      <div class="content">
        <div class="friend-panel">
          <div class="friend-panel-frame">
            <!-- <div class="friend-item">
              <div class="username-frame"><div class="username">user123</div></div>
              <div class="avatar"><img class="user-avatar" src="" /></div>
            </div> -->
          </div>
        </div>
        <div class="chat-panel">
          <div class="chat-box">
            <div class="text-input"></div>
            <div class="submit"></div>
          </div>
          <div class="chat-display">
            <div class="chat-frame">
              <!-- <div class="message-frame">
                <div class="from-message">
                  <div class="message-text">from message</div>
                  <div class="user-avatar-wrapper"><img class="img" src="" /></div>
                </div>
              </div>
              <div class="message-frame">
                <div class="to-message">
                  <div class="message-text">to message</div>
                  <div class="user-avatar-wrapper"><img class="img" src="" /></div>
                </div>
              </div> -->
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>