function startupPage(){
    getFriendList()
}

//render elements
async function getFriendList(){
    url = "friends/update"
    response = await (await fetch(url)).json()
    
    friend_panel = document.querySelector("div.friend-panel-frame");
    htmlToAdd = ""
    for(i = 0; i < response.length;i++){
        
        friend_panel.innerHTML+= `            
        <div class="friend-item" onclick="renderChat()">
        <div class="username-frame"><div class="username">${response[i].firstName+" "+response[i].lastName}</div></div>
        <!-- <div class="avatar"><img class="user-avatar" src="resources/img/smith_avt.png" /></div> -->
        </div>`
    }
}

class ChatBox{

}
function renderChat(){
    chat_panel = document.querySelector("div.chat-frame");
    chat_panel.innerHTML = "";
}

function sendMessage(){
    
}