<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<head>
  <script defer src="resources/scripts/header/script.js"></script>
</head>

<header>
    <div class="nav-top">
      <a href="home-page">
        <img src="resources/img/logo.jpg" alt="">
      </a>
    </div>
    <div class="header-search">
      <div class="input-container">
        <input type="text" name="keyword" id="keyword" placeholder="Starting typing to seach.." 
        onclick="document.getElementById('search-friend-dropdown').classList.toggle('active')"
        onkeyup="checkFriends(this.value)">
        <button class="search-btn">
          <i class="fa-solid fa-magnifying-glass fa-lg"></i>
        </button>
      </div>
      <div id="search-friend-dropdown">
        <div class="title">Recent searches</div>
        <div class="close-search" onclick="document.getElementById('search-friend-dropdown').classList.toggle('active')">Close</div>
        <div class="list">
        </div>
      </div>
    </div>
    <div class="center-menu-icon">
      <a href="home-page" class="icon">
        <div class="icon-container active">
          <i class="fa-solid fa-house fa-lg"></i>
        </div>
      </a>
      <!-- <a href="#" class="icon">
        <div class="icon-container">
          <i class="fa-solid fa-bolt fa-lg"></i>
        </div>
      </a>
      <a href="#" class="icon">
        <div class="icon-container">
          <i class="fa-solid fa-video fa-lg"></i>
        </div>
      </a> -->
      <a href="friend-page" class="icon">
        <div class="icon-container">
          <i class="fa-solid fa-user fa-lg"></i>
        </div>
      </a>
      <!-- <a href="#" class="icon">
        <div class="icon-container">
          <i class="fa-solid fa-bag-shopping fa-lg"></i>
        </div>
      </a> -->
    </div>
    <div class="right-menu-icon">
      <!-- <a href="#" id="dropdown-notify" class="icon">
        <div id="orange-dot" class="active"></div>
        <i class="fa-regular fa-bell fa-2x"></i>
      </a> -->
      <!-- <div id="dropdown-menu-notify">
        <h4 class="title">Notification</h4>
        <div class="list">
          <div class="line">
            <div class="user-img">
              <img src="/stored-user-images/alice_avatar.png" alt="">
            </div>
            <div class="info">
              <div class="top">
                <h5 class="user-name">Monkey D Luffy</h5>
                <div class="time">5 hours</div>
              </div>
              <div class="text">There are many variations of pass..</div>
            </div>
          </div>
          <div class="line">
            <div class="user-img">
              <img src="/stored-user-images/bob_avatar.png" alt="">
            </div>
            <div class="info">
              <div class="top">
                <h5 class="user-name">Ichijou Raku</h5>
                <div class="time">5 min</div>
              </div>
              <div class="text">Mobile Apps UI Designer is require..</div>
            </div>
          </div>
          <div class="line">
            <div class="user-img">
              <img src="/stored-user-images/charlie_avatar.png" alt="">
            </div>
            <div class="info">
              <div class="top">
                <h5 class="user-name">Midoriya Izuku</h5>
                <div class="time">3 sec</div>
              </div>
              <div class="text">There are many variations of pass..</div>
            </div>
          </div>
          <div class="line">
            <div class="user-img">
              <img src="/stored-user-images/david_avatar.png" alt="">
            </div>
            <div class="info">
              <div class="top">
                <h5 class="user-name">Uzumaki Naruto</h5>
                <div class="time">3 sec</div>
              </div>
              <div class="text">There are many variations of pass..</div>
            </div>
          </div>
          <div class="line">
            <div class="user-img">
              <img src="/stored-user-images/grace_avatar.png" alt="">
            </div>
            <div class="info">
              <div class="top">
                <h5 class="user-name">Monkey D Luffy</h5>
                <div class="time">3 sec</div>
              </div>
              <div class="text">There are many variations of pass..</div>
            </div>
          </div>
          <div class="line">
            <div class="user-img">
              <img src="/stored-user-images/eva_avatar.png" alt="">
            </div>
            <div class="info">
              <div class="top">
                <h5 class="user-name">Monkey D Luffy</h5>
                <div class="time">3 sec</div>
              </div>
              <div class="text">There are many variations of pass..</div>
            </div>
          </div>
          <div class="line">
            <div class="user-img">
              <img src="/stored-user-images/frank_avatar.png" alt="">
            </div>
            <div class="info">
              <div class="top">
                <h5 class="user-name">Monkey D Luffy</h5>
                <div class="time">3 sec</div>
              </div>
              <div class="text">There are many variations of pass..</div>
            </div>
          </div>
          <div class="line">
            <div class="user-img">
              <img src="/stored-user-images/henry_avatar.png" alt="">
            </div>
            <div class="info">
              <div class="top">
                <h5 class="user-name">Monkey D Luffy</h5>
                <div class="time">3 sec</div>
              </div>
              <div class="text">There are many variations of pass..</div>
            </div>
          </div>
        </div>
      </div> -->
      <a href="chat-messenger" id="dropdown-message" class="icon">
        <i class="fa-regular fa-message fa-2x"></i>
      </a>
      <!-- <div id="dropdown-menu-message">
        <div class="blur-background"></div>
        <div class="container">
          <div class="contact">
            <div class="title">CONTACTS</div>
            <div class="list">
              <a href="#" class="message-link">
                <div class="line">
                  <div class="user-img">
                    <img src="/stored-user-images/isabella_avatar.png" alt="">
                    <div class="dot-container active">
                      <div class="dot dot-green"></div>
                    </div>
                  </div>
                  <div class="info">
                    <h3 class="username">Hurin Seary</h3>
                    <div class="dot"></div>
                  </div>
                </div>
              </a>
              <a href="#" class="message-link">
                <div class="line">
                  <div class="user-img">
                    <img src="/stored-user-images/jack_avatar.png" alt="">
                    <div class="dot-container active">
                      <div class="dot dot-orange"></div>
                    </div>
                  </div>
                  <div class="info">
                    <h3 class="username">Hurin Seary</h3>
                    <div class="dot"></div>
                  </div>
                </div>
              </a>
              <a href="#" class="message-link">
                <div class="line">
                  <div class="user-img">
                    <img src="/stored-user-images/liam_avatar.png" alt="">
                    <div class="dot-container">
                      <div class="dot"></div>
                    </div>
                  </div>
                  <div class="info">
                    <h3 class="username">Hurin Seary</h3>
                    <div class="dot"></div>
                  </div>
                </div>
              </a>
              <a href="#" class="message-link">
                <div class="line">
                  <div class="user-img">
                    <img src="/stored-user-images/alice_avatar.png" alt="">
                    <div class="dot-container">
                      <div class="dot"></div>
                    </div>
                  </div>
                  <div class="info">
                    <h3 class="username">Hurin Seary</h3>
                    <div class="dot"></div>
                  </div>
                </div>
              </a>
              <a href="#" class="message-link">
                <div class="line">
                  <div class="user-img">
                    <img src="/stored-user-images/bob_avatar.png" alt="">
                    <div class="dot-container">
                      <div class="dot"></div>
                    </div>
                  </div>
                  <div class="info">
                    <h3 class="username">Hurin Seary</h3>
                    <div class="dot"></div>
                  </div>
                </div>
              </a>
              <a href="#" class="message-link">
                <div class="line">
                  <div class="user-img">
                    <img src="/stored-user-images/charlie_avatar.png" alt="">
                    <div class="dot-container">
                      <div class="dot"></div>
                    </div>
                  </div>
                  <div class="info">
                    <h3 class="username">Hurin Seary</h3>
                    <div class="dot"></div>
                  </div>
                </div>
              </a>
              <a href="#" class="message-link">
                <div class="line">
                  <div class="user-img">
                    <img src="/stored-user-images/david_avatar.png" alt="">
                    <div class="dot-container">
                      <div class="dot"></div>
                    </div>
                  </div>
                  <div class="info">
                    <h3 class="username">Hurin Seary</h3>
                    <div class="dot"></div>
                  </div>
                </div>
              </a>
              <a href="#" class="message-link">
                <div class="line">
                  <div class="user-img">
                    <img src="/stored-user-images/eva_avatar.png" alt="">
                    <div class="dot-container">
                      <div class="dot"></div>
                    </div>
                  </div>
                  <div class="info">
                    <h3 class="username">Hurin Seary</h3>
                    <div class="dot"></div>
                  </div>
                </div>
              </a>
              <a href="#" class="message-link">
                <div class="line">
                  <div class="user-img">
                    <img src="/stored-user-images/frank_avatar.png" alt="">
                    <div class="dot-container">
                      <div class="dot"></div>
                    </div>
                  </div>
                  <div class="info">
                    <h3 class="username">Hurin Seary</h3>
                    <div class="dot"></div>
                  </div>
                </div>
              </a>
              <a href="#" class="message-link">
                <div class="line">
                  <div class="user-img">
                    <img src="/stored-user-images/grace_avatar.png" alt="">
                    <div class="dot-container">
                      <div class="dot"></div>
                    </div>
                  </div>
                  <div class="info">
                    <h3 class="username">Hurin Seary</h3>
                    <div class="dot"></div>
                  </div>
                </div>
              </a>
              <a href="#" class="message-link">
                <div class="line">
                  <div class="user-img">
                    <img src="/stored-user-images/henry_avatar.png" alt="">
                    <div class="dot-container">
                      <div class="dot"></div>
                    </div>
                  </div>
                  <div class="info">
                    <h3 class="username">Hurin Seary</h3>
                    <div class="dot"></div>
                  </div>
                </div>
              </a>
              <a href="#" class="message-link">
                <div class="line">
                  <div class="user-img">
                    <img src="/stored-user-images/liam_avatar.png" alt="">
                    <div class="dot-container">
                      <div class="dot"></div>
                    </div>
                  </div>
                  <div class="info">
                    <h3 class="username">Hurin Seary</h3>
                    <div class="dot"></div>
                  </div>
                </div>
              </a>
            </div>
          </div>
        </div>  
      </div> -->
      <a href="sign-out" id="dropdown-setting" class="icon">
        <i class="fa-solid fa-right-from-bracket fa-2x"></i>
      </a>
      <div id="dropdown-menu-setting"></div>
    </div>
  </header>