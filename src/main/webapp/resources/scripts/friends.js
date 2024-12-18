const wrapperItem = document.querySelector(".wrapper-item");
const wrapper = document.querySelector(".wrapper");
fetch("DataRequest/FriendDetails") // Đặt URL đến API hoặc Servlet của bạn
    .then((response) => response.json())
    .then((data) => {
        for (user in data) {
            var item = document.createElement("div");
            wrapperItem.appendChild(item);
            item.classList.add("col-md-3");
            item.classList.add("item");
            var avatar = document.createElement("div");
            avatar.classList.add("avatar");
            var aELM = document.createElement("a");
            aELM.setAttribute("href","userpage?userID="+data[user].userID);
            item.appendChild(avatar);
            var image = document.createElement("img");
            image.setAttribute(
                "src",
                "/stored-user-images/" + data[user].avatar
            );
            aELM.appendChild(image);
            avatar.appendChild(aELM);
            var userFullname = document.createElement("div");
            userFullname.classList.add("user-name");
            userFullname.textContent =
                data[user].firstName + " " + data[user].lastName;
            item.appendChild(userFullname);
            var relationship = document.createElement("div");
            relationship.classList.add("status");
            relationship.textContent = "Bạn bè";
            var statusWrapper = document.createElement("div");
            statusWrapper.classList.add("status-wrapper");
            statusWrapper.classList.add("dropdown-select");
            statusWrapper.appendChild(relationship);
            var caretIcon = document.createElement("i");
            caretIcon.classList.add("fa-solid");
            caretIcon.classList.add("fa-caret-down");
            caretIcon.classList.add("dropdown-caret");
            statusWrapper.appendChild(caretIcon);
            item.appendChild(statusWrapper);
            var dropdown_list = document.createElement("div");
            dropdown_list.classList.add("dropdown-list");
            //
            var dropdown_item_unfriend = document.createElement("div");
            dropdown_item_unfriend.classList.add("dropdown-item");
            var dropdown_text_unfriend = document.createElement("span");
            dropdown_text_unfriend.id = data[user].userID;
            dropdown_text_unfriend.dataset.fullname = userFullname.textContent;
            dropdown_text_unfriend.textContent = "Unfriend";
            dropdown_item_unfriend.setAttribute(
                "onclick",
                "showDialog('" +
                    dropdown_text_unfriend.dataset.fullname +
                    "'); confirmRemove('" +
                    dropdown_text_unfriend.id +
                    "');"
            );
            var dropdown_icon_unfriend = document.createElement("img");
            dropdown_icon_unfriend.classList.add("unfriend-icon");
            dropdown_icon_unfriend.setAttribute(
                "src",
                "resources/img/icon/remove-contact.png"
            );
            dropdown_item_unfriend.appendChild(dropdown_text_unfriend);
            dropdown_item_unfriend.appendChild(dropdown_icon_unfriend);
            //
            var dropdown_item_chat = document.createElement("div");
            dropdown_item_chat.classList.add("dropdown-item");
            var dropdown_text_chat = document.createElement("a");
            dropdown_text_chat.textContent = "Nhắn tin";
            dropdown_text_chat.style.textDecoration = "None";
            dropdown_text_chat.style.color = "#333";
            dropdown_text_chat.setAttribute(
                "href",
                "chat-messenger?showChatID=" +
                    data[user].temporaryProperties.chatID
            );
            var dropdown_icon_chat = document.createElement("img");
            dropdown_icon_chat.classList.add("chat-icon");
            dropdown_icon_chat.setAttribute(
                "src",
                "resources/img/icon/chat.png"
            );
            dropdown_item_chat.appendChild(dropdown_text_chat);
            dropdown_item_chat.appendChild(dropdown_icon_chat);
            dropdown_list.appendChild(dropdown_item_unfriend);

            dropdown_list.appendChild(dropdown_item_chat);
            statusWrapper.appendChild(dropdown_list);
        }
        const dropdownSelects = document.querySelectorAll(".dropdown-select");
        Array.from(dropdownSelects).forEach(function (item) {
            item.addEventListener("click", function () {
                var dropdown = item.querySelector(".dropdown-list");
                var caret = item.querySelector(".dropdown-caret");
                dropdown.classList.toggle("show");
                caret.classList.toggle("fa-caret-down");
                caret.classList.toggle("fa-caret-up");
                });
            });

            document.addEventListener("click", function (e) {
                Array.from(dropdownSelects).forEach(function (item) {
                    if (!item.contains(e.target)) {
                    var dropdown = item.querySelector(".dropdown-list");
                    var caret = item.querySelector(".dropdown-caret");
                    dropdown.classList.remove("show");
                    caret.classList.add("fa-caret-down");
                    caret.classList.remove("fa-caret-up");
                }
                });
            });
            const title_friend_list = document.querySelector(".title-friend-list");
            const title_friend_suggest = document.querySelector(
                ".title-friend-suggest"
            );
            const title_friend_request = document.querySelector(
                ".title-friend-request"
            );
            const friend_list = document.querySelector(".friend-list");
            const friend_suggest = document.querySelector(".friend-suggest");
            const friend_request = document.querySelector(".friend-request");
            title_friend_list.style.backgroundColor = "#fff";
            title_friend_list.addEventListener("click", function () {

            title_friend_list.style.backgroundColor = "#fff";
            title_friend_suggest.style.backgroundColor = "transparent";
            title_friend_request.style.backgroundColor = "transparent";
            friend_list.style.display = "flex";
            friend_suggest.style.display = "none";
            friend_request.style.display = "none";
        });
        title_friend_suggest.addEventListener("click", function () {
            title_friend_suggest.style.backgroundColor = "#fff";
            title_friend_list.style.backgroundColor = "transparent";
            title_friend_request.style.backgroundColor = "transparent";
            friend_suggest.style.display = "flex";
            friend_list.style.display = "none";
            friend_request.style.display = "none";
        });
        title_friend_request.addEventListener("click", function () {
            title_friend_request.style.backgroundColor = "#fff";
            title_friend_list.style.backgroundColor = "transparent";
            title_friend_suggest.style.backgroundColor = "transparent";
            friend_request.style.display = "flex";
            friend_list.style.display = "none";
            friend_suggest.style.display = "none";
        });
    })
    .catch((error) => console.error("Lỗi khi lấy dữ liệu JSON:", error));

const confirm_wrapper = document.createElement("div");
confirm_wrapper.classList.add("confirm-wrapper");
confirm_wrapper.classList.add("hide");
confirm_wrapper.addEventListener("click", function(){
    confirm_wrapper.classList.add("hide");
});
const confirm_content = document.createElement("div");
confirm_content.classList.add("confirm-content");
confirm_content.addEventListener("click",function(e){
    e.stopPropagation();
}); 
const confirm_text = document.createElement("div");
confirm_text.classList.add("confirm-text");     

const confirm_btns = document.createElement("div");
confirm_btns.classList.add("confirm-btns");
const yes_btn = document.createElement("div");
yes_btn.classList.add("yes-btn");
yes_btn.textContent = "Có";
yes_btn.setAttribute("onclick","removeFriend()");
const no_btn = document.createElement("div");
no_btn.classList.add("no-btn");
no_btn.textContent = "Không";
confirm_btns.appendChild(yes_btn);
confirm_btns.appendChild(no_btn);
wrapper.appendChild(confirm_wrapper);
confirm_wrapper.appendChild(confirm_content);
confirm_content.appendChild(confirm_text);
confirm_content.appendChild(confirm_btns);

function removeFriend(userID) {
    // Lấy giá trị của friendID từ trường input
    var friendID = document.getElementById(userID);


    // Tạo một đường dẫn URL với friendID
    var url = "/mxh/DataRequest/Unfriend?friendID=" + friendID.id;
    console.log(friendID.id);

    // Chuyển hướng đến trang FriendRequest với tham số friendID
    // window.location.href = url;
    fetch(url);
    location.reload(true);
    // window.location.href = "/mxh/friend-page";
}
function sendFriend(userID){
    var sendfriendID = document.getElementById(userID);
    var url = "/mxh/DataRequest/SendRequest?sendFriendID="+sendfriendID.id;
    fetch(url);
}

function showDialog(fullname){
    confirm_wrapper.classList.remove("hide");
    confirm_text.textContent = "Bạn có chắc chắn muốn unfriend "+fullname+" không?";
}
no_btn.addEventListener("click", function(){
    confirm_wrapper.classList.add("hide");
});
function confirmRemove(userID){
    yes_btn.addEventListener("click",function(){
        removeFriend(userID);
    });
}

const wrapper_item_suggest = document.querySelector(".friend-suggest .wrapper-item");
function renderItem(item){
    const template = 
`<div class="col-md-3 item">
    <div class="avatar">
    
        <a href="userpage?userID=${item.userID}">
        <img src="/stored-user-images/${item.avatar}"/>
    </a>
    </div>
    <div class="user-name">${item.firstName} ${item.lastName}</div>
    <div class="status-wrapper"">
        <div class="status" id='${item.userID}'>Thêm bạn bè</div>
    </div>
</div>`;
    wrapper_item_suggest.insertAdjacentHTML("beforeend", template);
}
fetch("DataRequest/Strangers") // Đặt URL đến API hoặc Servlet của bạn
    .then((response) => response.json())
    .then((data) => {
        for (user in data) {
            renderItem(data[user]);
        }
        const add_friend_btns = document.querySelectorAll(
            ".friend-suggest .status-wrapper .status"
        );
        Array.from(add_friend_btns).forEach(function (item) {
            item.addEventListener("click", function () {
                if (item.textContent === "Thêm bạn bè") {
                    item.style.backgroundColor = "#808080";
                    item.textContent = "Hủy yêu cầu";
                    sendFriend(item.id);
                    localStorage.setItem(item.id,"Hủy yêu cầu");
                }else if(item.textContent === "Hủy yêu cầu"){
                    item.style.backgroundColor = "#10d876";
                    item.textContent = "Thêm bạn bè";
                    sendFriend(item.id);
                    localStorage.setItem(item.id,"Thêm bạn bè");
                }
            });
            const savedState = localStorage.getItem(item.id);
            if (savedState === "Hủy yêu cầu") {
                item.style.backgroundColor = "#808080";
                item.textContent = "Hủy yêu cầu";
            } else if (savedState === "Thêm bạn bè") {
                item.style.backgroundColor = "#10d876";
                item.textContent = "Thêm bạn bè";
            }

        });
    })
    .catch(error => console.error('Lỗi khi lấy dữ liệu JSON:', error));

const wrapper_item_request = document.querySelector(".friend-request .wrapper-item");
function renderItemRequest(item){
    const template = 
`<div class="col-md-3 item">
    <div class="avatar">
    <a href="userpage?userID=${item.userID}">
        <img src="/stored-user-images/${item.avatar}"/>
    </a>
    </div>
    <div class="user-name">${item.firstName} ${item.lastName}</div>
    <div class="status-wrapper"">
        <div class="status" id='${item.userID}'>Chấp nhận</div>
    </div>
</div>`;
    wrapper_item_request.insertAdjacentHTML("beforeend", template);
}
fetch('DataRequest/getRequestList') // Đặt URL đến API hoặc Servlet của bạn    
    .then(response => response.json())
    .then(data => {
        for(user in data){
            renderItemRequest(data[user]);
        }
        const accept_friend_btns = document.querySelectorAll(".friend-request .status-wrapper .status");
        Array.from(accept_friend_btns).forEach(function(item){
            item.addEventListener("click",function(){
                if(item.textContent === "Chấp nhận"){
                    item.style.backgroundColor = "#808080";
                    item.textContent = "Đã chấp nhận";
                    sendFriend(item.id);
                }else if(item.textContent === "Đã chấp nhận"){
                    item.style.pointerEvent = "None";
                }
            });
        });
    })
    .catch(error => console.error('Lỗi khi lấy dữ liệu JSON:', error));
    
var friend_list_input = document.querySelector(".friend-list .search-friend");
// Ajax
friend_list_input.addEventListener("keypress", function (event) {
    if (event.key === "Enter") {
        var keyword = friend_list_input.value;
        if (keyword == "") {
            return;
        }
        event.preventDefault();
        var formData = new FormData();
        formData.append("keyword", keyword);
        var xml = new XMLHttpRequest();
        var request = "/mxh/SearchFriendsDropdown";
        xml.open("POST", request, true);
        // xml.onload = function () {
        //     document.querySelector("#main .main-content").innerHTML = this.responseText;
        // }
        xml.onreadystatechange = function () {
            if (this.readyState == XMLHttpRequest.DONE && this.status == 200) {
                document.querySelector(".wrapper-item").innerHTML =
                    this.responseText;
            } else {
                console.log(this.status);
            }
        };
        xml.send(formData);
    }
});
function openDropdown(id) {
    var temp = document.getElementById("dropdown-select-" + id);
    var dropdown = temp.querySelector(".dropdown-list");
    var caret = temp.querySelector(".dropdown-caret");
    dropdown.classList.toggle("show");
    caret.classList.toggle("fa-caret-down");
    caret.classList.toggle("fa-caret-up");
}