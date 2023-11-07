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
                var commonFriends = document.createElement("div");
                commonFriends.classList.add("common-friend") 
                commonFriends.textContent = "105 bạn chung";
                item.appendChild(commonFriends);
                var relationship = document.createElement("div");
                relationship.classList.add("status");
                relationship.textContent = "Bạn bè";
                item.appendChild(relationship);
            }   
        })
        .catch(error => console.error('Lỗi khi lấy dữ liệu JSON:', error));
