const wrapperItem = document.querySelector(".wrapper-item");
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
                caretIcon.classList.add("dropdown-caret")
                statusWrapper.appendChild(caretIcon);
                item.appendChild(statusWrapper);
                var dropdown_list = document.createElement("div");
                dropdown_list.classList.add("dropdown-list");
                // 
                var dropdown_item_unfriend = document.createElement("div");
                dropdown_item_unfriend.classList.add("dropdown-item");
                var dropdown_text_unfriend = document.createElement("span");
                dropdown_text_unfriend.textContent = "Unfriend";
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
        })
        .catch(error => console.error('Lỗi khi lấy dữ liệu JSON:', error));

const dropdownSelects = document.querySelectorAll(".dropdown-select");
const dropdownList = document.querySelector(".dropdown-list");
const dropdownItems = document.querySelector(".dropdown-item");
const dropdownCaret = document.querySelector(".dropdown-caret");

// dropdownSelect.addEventListener("click", function(){
//     dropdownList.classList.toggle("show");
//     dropdownCaret.classList.toggle("fa-caret-down");
//     dropdownCaret.classList.toggle("fa-caret-up");
// });
dropdownSelects.forEach(function(item){
    item.addEventListener("click", function(){
        dropdownList.classList.toggle("show");
        dropdownCaret.classList.toggle("fa-caret-down");
        dropdownCaret.classList.toggle("fa-caret-up");
    })
});
document.addEventListener("click", function(e){
    if(!dropdownSelects.contains(e.target)){
        dropdownList.classList.remove("show");
        dropdownCaret.classList.add("fa-caret-down");
        dropdownCaret.classList.remove("fa-caret-up");
    }
});
