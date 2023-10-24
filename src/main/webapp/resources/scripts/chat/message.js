let friends
let messageSocket

let friend_panel
let chat_panel

let myUserInfo;

imageSrc = "resources/img/userdata/"
chatFrameIDStr = "chat-frame-"
chatUserItemIDStr = "user-item-"

let chatFrames = [];

//start funcs
async function setupPage(){
    friend_panel = document.querySelector("div.friend-panel-frame");
    chat_panel = document.querySelector("div.chat-display");

    await setupUserInfos()

    for(index in chatFrames){
        chatFrames[index].renderChat()
    }

    let webSocketProtocol = location.protocol === 'https:' ? 'wss:' : 'ws:';
    
    const messageSocketUrl = `${webSocketProtocol}//${location.host}/mxh/messageSocket?userID=${myUserInfo.userID}`;

    messageSocket = new WebSocket(messageSocketUrl)

    // messageSocket.addEventListener('open', (event) => {
    //     console.log('WebSocket connection opened.');

    //     // Send a message to the server
    //     messageSocket.send('Hello, WebSocket server!');
    // });
    
    // messageSocket.addEventListener(
    //     "message",
    //     function processMessagePackage(event){
            
    //     }
    // )
    messageSocket.onmessage=processIncomingMessage
}




//render elements
async function setupUserInfos(){
    url = "message/getFriends"
    returnData = await (await fetch(url)).json()
    htmlToAdd = ""
    friends = returnData[0];
    myUserInfo = returnData[1];
    for(i = 0; i < friends.length;i++){
        
        friend_panel.innerHTML+= `            
        <div class="friend-item" itemIndex="${friends[i].chatID}" onclick="showChatFrame(this)">
        <div class="username-frame"><div class="username">${friends[i].firstName+" "+friends[i].lastName}</div></div>
        <div class="avatar"><img class="user-avatar" src="resources/img/userdata/${friends[i].avatar}" /></div>
        </div>`

        chat_panel.insertAdjacentHTML("beforeend",`<div class="chat-frame" id="${chatFrameIDStr+friends[i].chatID}"></div>`)
        
        let messages = await initChatMessages(friends[i].chatID)
        chatFrames.push(new ChatFrame(document.querySelector("#"+chatFrameIDStr+friends[i].chatID),friends[i],messages))
    }
    hideOtherChatFrames(null)

    for(index in chatFrames){
        console.log(chatFrames[index])
        chatFrames[index].renderChat()
    }
}

async function initChatMessages(chatID){
    url = "message/getMessages"
    const requestOptions = {
    method: 'GET',
    headers: {
        'chatID': chatID,
    },
    };
    
    let dataResp = await (await fetch(url,requestOptions)).json();
    let messages = [];
    for(index in dataResp){
        messages.push(new Message(
            chatID,
            dataResp[index].userID,
            dataResp[index].message,
            dataResp[index].index,
            dataResp[index].dateSent
        ))
    }
    return messages
}

class ChatFrame{
    htmlDiv;
    otherUserInfo;
    messages;

    constructor(htmlDiv,otherUserInfo,messages){
        this.htmlDiv = htmlDiv
        this.otherUserInfo = otherUserInfo
        this.messages = messages
    }

    renderChat(){
        this.htmlDiv.innerHTML = ""
        for(index in this.messages){
            if(this.messages[index].userID === myUserInfo.userID){
                this.htmlDiv.insertAdjacentHTML("beforeend",this.makeHtmlToMessage(this.messages[index]))
            }
            else{
                this.htmlDiv.insertAdjacentHTML("beforeend",this.makeHtmlFromMessage(this.messages[index]))
            }
        }
    }

    makeHtmlToMessage(message){
        let htmlString = 
        `<div class="message-frame">
            <div class="to-message">
            <div class="message-text">${message.textMessage}</div>
            <div class="user-avatar-wrapper"><img class="img" src="${imageSrc+myUserInfo.avatar}" draggable="false"/></div>
            </div>
        </div>`
        return htmlString
    }
    makeHtmlFromMessage(message){
        let htmlString = 
        `<div class="message-frame"}">
            <div class="from-message">
                <div class="message-text">${message.textMessage}</div>
                <div class="user-avatar-wrapper"><img class="img" src="${imageSrc+this.otherUserInfo.avatar}" draggable="false"/></div>
            </div>
        </div>`
        return htmlString
    }
}

class Message{
    chatID;
    userID;
    textMessage;
    index;
    dateSent;

    constructor(chatID,userID,textMessage,dateSent){
        this.chatID=chatID
        this.userID=userID
        this.textMessage=textMessage
        this.dateSent=dateSent
    }
}

function hideOtherChatFrames(itemIndex){
    for(i = 0; i < chat_panel.children.length ; i++){
        if(itemIndex == i){
            chat_panel.children[i].style.display = "flex"
        }
        else{
            chat_panel.children[i].style.display = "none"
        }
    }
}
let currentOpeningFrame;
function showChatFrame(element){
    currentOpeningFrame = element.getAttribute("itemIndex")

    hideOtherChatFrames(parseInt(element.getAttribute("itemIndex")))
}
function sendMessage(){
    textInput = document.querySelector("input.text-input");
    if(textInput.value!==""){
        dateSent = getDateSent();
        newMessage = new Message(currentOpeningFrame,myUserInfo.userID,textInput.value,dateSent)
        textInput.value=""
        
        let messageStringJSON = JSON.stringify(newMessage);
        messageSocket.send(messageStringJSON)
    }
}

function processIncomingMessage(event){
    const receivedMessage = event.data;
    console.log(receivedMessage)
}

function getDateSent() {
    var date = new Date();

    var year = date.getFullYear();
    var month = (date.getMonth() + 1).toString().padStart(2, '0');
    var day = date.getDate().toString().padStart(2, '0');
    var hours = date.getHours().toString().padStart(2, '0');
    var minutes = date.getMinutes().toString().padStart(2, '0');
    var seconds = date.getSeconds().toString().padStart(2, '0');
    
    return year + "-"+month+"-"+day+" "+ hours + ":" + minutes + ":" + seconds;
  }