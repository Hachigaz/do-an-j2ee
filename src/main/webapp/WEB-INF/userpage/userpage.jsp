<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="resources/css/userpage/posts-userpage.css">
    <link rel="stylesheet" href="resources/css/home/style.css" />

    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <link rel="stylesheet" href="resources/css/components/header.css">
    <link rel="stylesheet" href="resources/css/userpage/userpage.css">
    <link rel="stylesheet" href="resources/css/friend1.css">
    <script src="resources/scripts/friend2.js"></script>
    <script src="resources/scripts/home-page/script.js"></script>
    <script src="resources/scripts/utils/utils.js"></script>


    <title>User Page</title>
</head>

<body>
    <%@ include file="/WEB-INF/components/header/header.jsp" %>
    <div id="post-list">
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
    <div id="settingForm">
        <h2>User Settings</h2>
        <form id="userSettingsForm" action="userpage" method="post" enctype="multipart/form-data">
            <label for="newfirstName">First Name:</label>
            <input type="text" id="newfirstName" name="newfirstName" value="${userDetails.firstName}" required disabled>
        
            <label for="newlastName">Last Name:</label>
            <input type="text" id="newlastName" name="newlastName" value="${userDetails.lastName}" required disabled>
        
            <label for="newaddress">Address:</label>
            <input type="text" id="newaddress" name="newaddress" value="${userDetails.address}" required disabled>
            <label for="newbirthDate">BirthDate</label>
            <input type="date" id="newbirthDate" name="newBirthDate" value="${userDetails.birthDate}" required disabled>
            <label for="avatarName" <% if (!Boolean.parseBoolean(String.valueOf(request.getAttribute("showPostButton")))) { %>style="display: none;"<% } %>>Avatar:</label>
            <input type="file" id="avatarName" name="avatarName" accept="image/*" disabled <% if (!Boolean.parseBoolean(String.valueOf(request.getAttribute("showPostButton")))) { %>style="display: none;"<% } %>>
            <label for="background" <% if (!Boolean.parseBoolean(String.valueOf(request.getAttribute("showPostButton")))) { %>style="display: none;"<% } %>>Background:</label>
            <input type="file" id="background" name="background" accept="image/*" disabled <% if (!Boolean.parseBoolean(String.valueOf(request.getAttribute("showPostButton")))) { %>style="display: none;"<% } %>>
    
            <input type="button" value="Edit" onclick="toggleEdit()" <% if (!Boolean.parseBoolean(String.valueOf(request.getAttribute("showPostButton")))) { %>style="display: none;"<% } %> >
            <input type="submit" value="save" onclick="submitAndRefresh()"  disabled <% if (!Boolean.parseBoolean(String.valueOf(request.getAttribute("showPostButton")))) { %>style="display: none;"<% } %>>
        </form>
        
    </div>
    <!-- New content below the header -->
    <div class="user-page-content">
        <!-- First part of the content -->
        <div class="user-page-wrapper">
            <div class="user-info-wrapper">
                <div class="first-part">
                    <!-- Display the background image -->
                    <img src="/stored-user-images/${userDetails.background}?t=${Date.now()}" alt="background" style="width: 100%;">
                </div>
        
                <!-- Second part of the content -->
                <div class="second-part">
                    <!-- Display the avatar image -->
                    <div id="avatar">
                        <img src="/stored-user-images/${userDetails.avatar}?t=${Date.now()}" alt="background" height="400" style="width: 100%;">
                    </div>
                </div>
        
                <!-- Buttons on the right side -->
                <div class="right-buttons">
                    <a class="setting-button" onclick="toggleSettingsForm()"><i class="fa-solid fa-gear"></i>Setting</a>
                    <!-- <a href="#" <% if (!Boolean.parseBoolean(String.valueOf(request.getAttribute("showPostButton")))) { %>style="display: none;"<% } %>>
                        <i class="fa-regular fa-edit"></i> Post Bài
                    </a>         -->
                </div>
                <div class="left-label" >
                    <label for="name" class="user-name-display">  ${userDetails.firstName}  ${userDetails.lastName}</label><br>
                    <label for="friendcount">  ${userDetails.friendCounts} Bạn bè </label>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="luachon">
    <div class="luachonbutton" onclick="toggleBorder(this); showContent('friend');">
        Bạn bè
    </div>
    <div class="luachonbutton" onclick="toggleBorder(this); showContent('abc');getPostsUSER();">
        Bài viết
    </div>
</div>
</div>
<div class="friend">
<div class="wrapper">
    <div class="friend-wrapper">
        <div class="friend-list">
            <div class="title col-md-12">
            <span> Bạn bè</span>
            <span class="view-all-link" <% if (!Boolean.parseBoolean(String.valueOf(request.getAttribute("showPostButton")))) { %>style="display: none;"<% } %>><a href="friend-page">Xem tất cả bạn bè</a></span>

            </div>
            <div class="wrapper-item">
            
            </div>
        </div>
    </div>
</div>
</div>
<div class="abc">
<div class="main-content" id="main-content">
</div>
</div>
    <script>
$(document).ready(function () {
    $('#settingForm').submit(function (event) {
        event.preventDefault();

        var formData = new FormData($('#userSettingsForm')[0]);
        var birthDate = $('#newbirthDate').val();        
        // Log the form data to the console for debugging
        for (var pair of formData.entries()) {
            console.log('Form Data Entry:', pair);
        }

        $.ajax({
            type: 'POST',
            url: 'userpage',
            contentType: false,
            processData: false,
            data: formData,
            success: function (response) {
                console.log(response);
                // Handle success, e.g., show a success message
            },
            error: function (xhr, status, error) {
                console.error(xhr.responseText);
                // Handle error, e.g., show an error message
            }
        });
    });
});
function getUserIDFromURL() {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get('userID');
    console.log('UserID từ getUserIDFromURL :', urlParams);
}
function toggleSettingsForm() {
        var settingForm = $("#settingForm");
        settingForm.toggle();

        // If the form is now visible, you might want to perform additional actions
        if (settingForm.is(":visible")) {
            // Perform actions when the form is opened
            console.log("Settings form opened");
        } else {
            // Perform actions when the form is closed
            console.log("Settings form closed");
        }
    }
    function submitAndRefresh() {
    // 1. Send the data
    var form = document.getElementById('userSettingsForm');
    
    $.ajax({
        type: 'POST',
        url: 'userpage',
        contentType: false,
        processData: false,
        data: new FormData(form),
        success: function (response) {
            console.log(response);

            location.reload();
        },
        error: function (xhr, status, error) {
            console.error(xhr.responseText);
            // Handle error, e.g., show an error message
        }
    });
}
    function toggleEdit() {
        var inputs = document.querySelectorAll('input[type="text"], input[type="date"], input[type="file"] ,input[type="submit"]');
        for (var i = 0; i < inputs.length; i++) {
            inputs[i].disabled = !inputs[i].disabled;
        }
    }
    function toggleBorder(element) {
            // Remove 'clicked' class from all divs
            document.querySelectorAll('.luachon div').forEach(function (div) {
                div.classList.remove('clicked');
            });

            // Add 'clicked' class to the clicked div
            element.classList.add('clicked');
        }
        function showContent(contentType) {
            // Hide all content sections
            document.querySelector('.friend').style.display = 'none';
            document.querySelector('.abc').style.display = 'none';

            // Show the selected content section
            document.querySelector('.' + contentType).style.display = 'block';
        }
        function getPostsUSER() {
    const urlParams = new URLSearchParams(window.location.search);
    const userID = urlParams.get('userID');
    if(userID==null){
        const postRequestURL = `Post/GetLoggedInPosts?`;
    console.log('postRequestURL:', postRequestURL);

    fetch(postRequestURL)
        .then(response => response.text())
        .then(text => {
            // Select all elements with the class "luachonbutton"
            var postFrameElement1 = document.querySelector('.main-content');

            // Check if the element is found
            if (postFrameElement1) {
                // Insert the received HTML content
                postFrameElement1.insertAdjacentHTML("beforeend", text);
            } else {
                console.error('No element with class "post" found.');
            }
        })
        .catch(error => {
            console.error('Error fetching posts:', error);
        });
    }
    console.log("userID1: " + userID);

    let params = new URLSearchParams();
    params.append('userID', userID);
    let paramsString =  params.toString();

    const postRequestURL = `Post/GetLoggedInPosts?`+paramsString;
    console.log('postRequestURL:', postRequestURL);

    fetch(postRequestURL)
        .then(response => response.text())
        .then(text => {
            // Select all elements with the class "luachonbutton"
            var postFrameElement1 = document.querySelector('.main-content');

            // Check if the element is found
            if (postFrameElement1) {
                // Insert the received HTML content
                postFrameElement1.insertAdjacentHTML("beforeend", text);
            } else {
                console.error('No element with class "post" found.');
            }
        })
        .catch(error => {
            console.error('Error fetching posts:', error);
        });
}



            </script>
</body>
<script src="resources/scripts/friends1.js"></script>
</html>