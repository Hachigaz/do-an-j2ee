const wrapperItem = document.querySelector(".wrapper-item");
const wrapper = document.querySelector(".wrapper");
fetch('DataRequest/FriendDetails') // Đặt URL đến API hoặc Servlet của bạn    
    .then(response => response.json())
    .then(data => {
            for(user in data){
                var item = document.createElement("div");
                wrapperItem.appendChild(item);
                item.classList.add("col-md-3");
                item.classList.add("item");
                var avatar = document.createElement("div");
                avatar.classList.add("avatar");
                item.appendChild(avatar);
                var image = document.createElement("img");
                image.setAttribute("src","resources/img/userdata/"+data[user].avatar);
                avatar.appendChild(image);
                var userFullname = document.createElement("div");
                userFullname.classList.add("user-name");
                userFullname.textContent = data[user].firstName+" "+data[user].lastName;
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
                // dropdown_text_unfriend.setAttribute("onclick","removeFriend("+data[user].userID+")");
                dropdown_text_unfriend.dataset.fullname = userFullname;
                dropdown_text_unfriend.textContent = "Unfriend";
                dropdown_text_unfriend.setAttribute("onclick","showDialog("+dropdown_text_unfriend.dataset.fullname+")");
                var dropdown_icon_unfriend = document.createElement("img");
                dropdown_icon_unfriend.classList.add("unfriend-icon");
                dropdown_icon_unfriend.setAttribute("src","resources/img/icon/remove-contact.png");
                dropdown_item_unfriend.appendChild(dropdown_text_unfriend);
                dropdown_item_unfriend.appendChild(dropdown_icon_unfriend);
                // 
                var dropdown_item_chat = document.createElement("div");
                dropdown_item_chat.classList.add("dropdown-item");
                var dropdown_text_chat = document.createElement("span");
                dropdown_text_chat.textContent = "Nhắn tin";
                var dropdown_icon_chat = document.createElement("img");
                dropdown_icon_chat.classList.add("chat-icon");
                dropdown_icon_chat.setAttribute("src","resources/img/icon/chat.png");
                dropdown_item_chat.appendChild(dropdown_text_chat);
                dropdown_item_chat.appendChild(dropdown_icon_chat);
                dropdown_list.appendChild(dropdown_item_unfriend);

                dropdown_list.appendChild(dropdown_item_chat);
                statusWrapper.appendChild(dropdown_list);
            }   
            const dropdownSelects = document.querySelectorAll(".dropdown-select");
            Array.from(dropdownSelects).forEach(function(item){
                item.addEventListener("click",function(){
                var dropdown = item.querySelector(".dropdown-list");
                var caret = item.querySelector(".dropdown-caret");
                dropdown.classList.toggle("show");
                caret.classList.toggle("fa-caret-down");
                caret.classList.toggle("fa-caret-up");
                });
            });

            document.addEventListener("click", function(e){
                Array.from(dropdownSelects).forEach(function(item){
                if(!item.contains(e.target)){
                    var dropdown = item.querySelector(".dropdown-list");
                    var caret = item.querySelector(".dropdown-caret");
                    dropdown.classList.remove("show");
                    caret.classList.add("fa-caret-down");
                    caret.classList.remove("fa-caret-up");
                }
                });
            });
            const title_friend_list = document.querySelector(".title-friend-list");
            const title_friend_suggest = document.querySelector(".title-friend-suggest");
            const friend_list = document.querySelector(".friend-list");
            const friend_suggest = document.querySelector(".friend-suggest");

            title_friend_list.style.backgroundColor = "#fff";
            title_friend_list.addEventListener("click", function(){
                title_friend_list.style.backgroundColor = "#fff";
                title_friend_suggest.style.backgroundColor = "transparent";
                friend_list.style.display = "flex";
                friend_suggest.style.display = "none";
            });
            title_friend_suggest.addEventListener("click", function(){
                title_friend_suggest.style.backgroundColor = "#fff";
                title_friend_list.style.backgroundColor = "transparent";
                friend_suggest.style.display = "flex";
                friend_list.style.display = "none";
            });
        })
        .catch(error => console.error('Lỗi khi lấy dữ liệu JSON:', error));

const confirm_wrapper = document.createElement("div");
confirm_wrapper.classList.add("confirm-wrapper");
confirm_wrapper.classList.add("hide");
const confirm_content = document.createElement("div");
confirm_content.classList.add("confirm-content");
const confirm_text = document.createElement("div");
confirm_text.classList.add("confirm-text");     
confirm_text.textContent = "Bạn có chắc chắn muốn unfriend "+dropdown_text_unfriend.dataset.fullname+" không?";

const confirm_btns = document.createElement("div");
confirm_btns.classList.add("confirm-btns");
const yes_btn = document.createElement("div");
yes_btn.classList.add("yes-btn");
yes_btn.textContent = "Có";
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
function showDialog(fullname){
    confirm_wrapper.classList.remove("hide");
}