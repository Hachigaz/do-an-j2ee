<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <link rel="stylesheet" href="resources/css/components/header.css">
    <link rel="stylesheet" href="resources/css/userpage/userpage.css">

    <title>User Page</title>
</head>

<body>
    <%@ include file="/WEB-INF/components/header/header.jsp" %>
    <div id="settingForm">
        <h2>User Settings</h2>
        <form id="userSettingsForm" action="userpage" method="post">
            <label for="newfirstName">First Name:</label>
            <input type="text" id="newfirstName" name="newfirstName" value="${userDetails.firstName}" required>
        
            <label for="newlastName">Last Name:</label>
            <input type="text" id="newlastName" name="newlastName" value="${userDetails.lastName}" required>
        
            <label for="newaddress">Address:</label>
            <input type="text" id="newaddress" name="newaddress" value="${userDetails.address}" required>
        
            <input type="button" value="Edit">
            <input type="submit" value="save">
        </form>
        
    </div>
    <!-- New content below the header -->
    <div class="user-page-content">
        <!-- First part of the content -->
        <div class="first-part">
            <!-- Your content for the first part goes here -->
            <img src="${userDetails.background}?t=${Date.now()}" alt="background" height="400" style="width: 100%;">
        </div>

        <!-- Second part of the content -->
        <div class="second-part">
            <!-- Your content for the second part goes here -->
            <div id="avatar">
                <img src="${userDetails.avatar}?t=${Date.now()}" alt="Avatar" height="150">
            </div>
        </div>

        <!-- Buttons on the right side -->
        <div class="right-buttons">
            <a href="#" class="setting-button"><i class="fa-solid fa-gear"></i>Setting</a>
            <a href="#" class="post-button"><i class="fa-regular fa-edit"></i> Post Bài</a>
        </div>
    </div>
    <script>
$(document).ready(function () {
    $('#settingForm').submit(function (event) {
        event.preventDefault();

        var formData = new FormData($('#userSettingsForm')[0]);

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



            </script>
</body>
</html>
