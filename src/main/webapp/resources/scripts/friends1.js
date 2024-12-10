const wrapperItem = document.querySelector(".wrapper-item");
const friendWrapper = document.querySelector(".friend");

const wrapper = document.querySelector(".wrapper");
let loadingMoreFriends = false;
let allFriendsLoaded = false;
let totalFriendsCount = 0;
const itemsToShowInitially = 2; // Show only the first 2 friends initially
const itemsPerLoad = 2; // Load 2 more friends when scrolling
let start1 = 0;

function loadFriends(userID, start1Index, count) {
    loadingMoreFriends = true;

    // Fetch friends from the server based on the start1Index and count
    fetch(`DataRequest/FriendDetails?userID=${userID}&start1=${start1Index}&count=${count}`)
            .then(response => response.json())
        .then(data => {
            console.log('Response data:', data);

            // Determine whether to show the initial items or load more
            const initialLoad = start1Index === 0;

            if (initialLoad) {
                // Clear the wrapperItem before adding new items
                wrapperItem.innerHTML = '';
            }
            totalFriendsCount = data.length;
            for (let i = 0; i < data.length; i++) {
                const user = data[i];
                const friendItem = createFriendItem(user);

                // Only append the first 2 items during the initial load
                if (initialLoad && i < itemsToShowInitially) {
                    wrapperItem.appendChild(friendItem);
                    console.log(`Friend added: ${user.firstName} ${user.lastName}`);
                } else if (!initialLoad) {
                    // Load more items as you scroll (excluding the first 2)
                    wrapperItem.appendChild(friendItem);
                    console.log(`Friend added: ${user.firstName} ${user.lastName}`);
                }
            }

            // Add event listeners for dropdowns
            const dropdownSelects = document.querySelectorAll(".dropdown-select");
            dropdownSelects.forEach(item => {
                item.addEventListener("click", function () {
                    const dropdown = item.querySelector(".dropdown-list");
                    const caret = item.querySelector(".dropdown-caret");
                    dropdown.classList.toggle("show");
                    caret.classList.toggle("fa-caret-down");
                    caret.classList.toggle("fa-caret-up");
                });
            });

            document.addEventListener("click", function (e) {
                dropdownSelects.forEach(item => {
                    if (!item.contains(e.target)) {
                        const dropdown = item.querySelector(".dropdown-list");
                        const caret = item.querySelector(".dropdown-caret");
                        dropdown.classList.remove("show");
                        caret.classList.add("fa-caret-down");
                        caret.classList.remove("fa-caret-up");
                    }
                });
            });

            if (data.length < count || data.length === 0) {
                // If less than expected or no more friends to load
                console.log('No more friends to load');
                loadingMoreFriends = false;
            } else {
                // If loaded expected count, update the start1 index for the next load
                start1 += count;
            }
        })
        .catch(error => console.error('Error fetching friend data:', error))
        .finally(() => {
            loadingMoreFriends = false; // Reset loading status
        });
}


function createFriendItem(user) {
    // Create friend item elements (similar to your existing code)
    const friendItem = document.createElement("div");
                friendItem.classList.add("col-md-3");
                friendItem.classList.add("item");

                const avatarLink = document.createElement("a");
                avatarLink.classList.add("avatar-link"); // Optional: add a class for styling
                avatarLink.setAttribute("href", "userpage?userID=" + user.userID);
                
                const avatar = document.createElement("div");
                avatar.classList.add("avatar");
                
                const image = document.createElement("img");
                image.setAttribute("src", "/stored-user-images/" + user.avatar);
                
                avatarLink.appendChild(image);
                avatar.appendChild(avatarLink);
                friendItem.appendChild(avatar);
                
                const userFullname = document.createElement("div");
                userFullname.classList.add("user-name");
                userFullname.textContent = user.firstName + " " + user.lastName;
                friendItem.appendChild(userFullname);

                const relationship = document.createElement("div");
                relationship.classList.add("status");
                relationship.textContent = "";
                const statusWrapper = document.createElement("div");
                statusWrapper.classList.add("status-wrapper");
                statusWrapper.classList.add("dropdown-select");
                statusWrapper.appendChild(relationship);

                const caretIcon = document.createElement("i");
                caretIcon.classList.add("fa-solid");
                caretIcon.classList.add("fa-ellipsis");
                caretIcon.classList.add("dropdown-caret");
                statusWrapper.appendChild(caretIcon);
                if (userID==null){
                    friendItem.appendChild(statusWrapper);
                }

                const dropdownList = document.createElement("div");
                dropdownList.classList.add("dropdown-list");
                dropdownList.style.position = "absolute"; // Set position to absolute
                dropdownList.style.zIndex = "999"; // Set a high z-index to overlay other elements
                const dropdownItemUnfriend = document.createElement("div");
                dropdownItemUnfriend.classList.add("dropdown-item");
                const dropdownTextUnfriend = document.createElement("span");
                dropdownTextUnfriend.id = user.userID;
                dropdownTextUnfriend.dataset.fullname = userFullname.textContent;
                dropdownTextUnfriend.textContent = "Unfriend";
                dropdownTextUnfriend.setAttribute("onclick", `showDialog('${dropdownTextUnfriend.dataset.fullname}'); confirmRemove('${dropdownTextUnfriend.id}');`);
                const dropdownIconUnfriend = document.createElement("img");
                dropdownIconUnfriend.classList.add("unfriend-icon");
                dropdownIconUnfriend.setAttribute("src", "resources/img/icon/remove-contact.png");
                dropdownItemUnfriend.appendChild(dropdownTextUnfriend);
                dropdownItemUnfriend.appendChild(dropdownIconUnfriend);
            
                // Create Nhắn tin dropdown item
                const dropdownItemChat = document.createElement("div");
                dropdownItemChat.classList.add("dropdown-item");
                const dropdownTextChat = document.createElement("a");
                dropdownTextChat.textContent = "Nhắn tin";
                dropdownTextChat.style.textDecoration = "None";
                dropdownTextChat.style.color = "#333";
                dropdownTextChat.setAttribute("href", `chat-messenger?showChatID=${user.temporaryProperties.chatID}`);
                const dropdownIconChat = document.createElement("img");
                dropdownIconChat.classList.add("chat-icon");
                dropdownIconChat.setAttribute("src", "resources/img/icon/chat.png");
                dropdownItemChat.appendChild(dropdownTextChat);
                dropdownItemChat.appendChild(dropdownIconChat);
            
                // Append custom dropdown items
                dropdownList.appendChild(dropdownItemUnfriend);
                dropdownList.appendChild(dropdownItemChat);
                statusWrapper.appendChild(dropdownList);
                if (user.mutualFriend) {
                    statusWrapper.style.backgroundColor = "green";
                }
                // Append friend item to the wrapperItem
                wrapperItem.appendChild(friendItem);
    // ... (your existing code for creating friend items)

    return friendItem;
}
    


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

function page(userID) {
    window.location.href = 'userpage?userID=' +userID;
}
//
const urlParams = new URLSearchParams(window.location.search);
const userID = urlParams.get('userID');
console.log(userID);
if (userID==null){
    function loadFriends( start1Index, count) {
        loadingMoreFriends = true;
    
        // Fetch friends from the server based on the start1Index and count
        fetch(`DataRequest/FriendDetails?start1=${start1Index}&count=${count}`)
                .then(response => response.json())
            .then(data => {
                console.log('Response data:', data);
    
                // Determine whether to show the initial items or load more
                const initialLoad = start1Index === 0;
    
                if (initialLoad) {
                    // Clear the wrapperItem before adding new items
                    wrapperItem.innerHTML = '';
                }
                totalFriendsCount = data.length;
                for (let i = 0; i < data.length; i++) {
                    const user = data[i];
                    const friendItem = createFriendItem(user);
    
                    // Only append the first 2 items during the initial load
                    if (initialLoad && i < itemsToShowInitially) {
                        wrapperItem.appendChild(friendItem);
                        console.log(`Friend added: ${user.firstName} ${user.lastName}`);
                    } else if (!initialLoad) {
                        // Load more items as you scroll (excluding the first 2)
                        wrapperItem.appendChild(friendItem);
                        console.log(`Friend added: ${user.firstName} ${user.lastName}`);
                    }
                }
    
                // Add event listeners for dropdowns
                const dropdownSelects = document.querySelectorAll(".dropdown-select");
                dropdownSelects.forEach(item => {
                    item.addEventListener("click", function () {
                        const dropdown = item.querySelector(".dropdown-list");
                        const caret = item.querySelector(".dropdown-caret");
                        dropdown.classList.toggle("show");
                        caret.classList.toggle("fa-caret-down");
                        caret.classList.toggle("fa-caret-up");
                    });
                });
    
                document.addEventListener("click", function (e) {
                    dropdownSelects.forEach(item => {
                        if (!item.contains(e.target)) {
                            const dropdown = item.querySelector(".dropdown-list");
                            const caret = item.querySelector(".dropdown-caret");
                            dropdown.classList.remove("show");
                            caret.classList.add("fa-caret-down");
                            caret.classList.remove("fa-caret-up");
                        }
                    });
                });
    
                if (data.length < count || data.length === 0) {
                    // If less than expected or no more friends to load
                    console.log('No more friends to load');
                    loadingMoreFriends = false;
                } else {
                    // If loaded expected count, update the start1 index for the next load
                    start1 += count;
                }
            })
            .catch(error => console.error('Error fetching friend data:', error))
            .finally(() => {
                loadingMoreFriends = false; // Reset loading status
            });
    }
    
}

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
function renderItem(item) {
    const template = `<div class="col-md-3 item">
        <div class="avatar">
            <img src="/stored-user-images/${item.avatar}" />
        </div>
        <div class="user-name">${item.firstName} ${item.lastName}</div>
        <div class="status-wrapper">
            <div class="status" id='${item.userID}'>Thêm bạn bè</div>
        </div>
    </div>`;

    // Create an element and append it to the wrapper
    const element = document.createElement('div');
    element.innerHTML = template;
    wrapper_item_suggest.appendChild(element.firstChild);
}


function loadMoreFriendsIfNeeded() {
    if (!loadingMoreFriends && !allFriendsLoaded) {
        console.log('Checking if more friends are needed...');

        const friendItemsBefore = document.querySelectorAll(".wrapper-item .item").length;

        const isScrolledToBottom =
            window.innerHeight + window.scrollY >= Math.max(
                document.documentElement.scrollHeight,
                document.body.scrollHeight
            );

        if (isScrolledToBottom || friendItemsBefore === 0) {
            console.log('Loading more friends...');
            loadingMoreFriends = true;
            if (userID==null){
                loadFriends( start1, itemsToShowInitially);
            }else{
                loadFriends(userID, start1, itemsToShowInitially);
            }
        }

        const friendItemsAfter = document.querySelectorAll(".wrapper-item .item").length;
        console.log(`Friend items before: ${friendItemsBefore}, after: ${friendItemsAfter}`);

        if (friendItemsAfter >= totalFriendsCount) {
            console.log('All friends loaded.');
            allFriendsLoaded = true;
        }
    }
}

// Use Intersection Observer to check if the friend div is initially visible
const observer = new IntersectionObserver((entries) => {
    if (entries[0].isIntersecting) {
        // Friend div is initially visible, trigger the initial load
        if (userID==null){
            loadFriends( start1, itemsToShowInitially);
        }else{
            loadFriends(userID, start1, itemsToShowInitially);

        }
        window.addEventListener("scroll", loadMoreFriendsIfNeeded);
        observer.disconnect(); // Disconnect the observer after triggering the initial load
    }
});

// start1 observing the friendWrapper
observer.observe(friendWrapper);

// Initial load when the page is loaded
document.addEventListener("DOMContentLoaded", function () {
    // start1 observing the friendWrapper
    observer.observe(friendWrapper);
});