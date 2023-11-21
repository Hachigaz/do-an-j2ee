let userAccountDetails;
let messageBoxes = [];

let friendPanelElement
let chatDisplayElement

let messageSocket

function setupPage(){
    chatDisplayElement = document.querySelector("div.chat-display")
    friendPanelElement = document.querySelector("div.friend-panel-frame")
    //get friend details
    const friendChatRequestURL = `ChatRequest/FriendList`;
    fetch(friendChatRequestURL)
        .then(response => response.json())
        .then(fetchedFriendData =>{
            let friendData = fetchedFriendData[0]
            userAccountDetails = fetchedFriendData[1]

            for(friendIndex in friendData){
                const currentFriendData = friendData[friendIndex]
                messageBoxes[currentFriendData.chatID]=new MessageBox(currentFriendData.chatID,currentFriendData.friendDetails)                
                messageBoxes[currentFriendData.chatID].chatFrameElement.style.display = "none"
                messageBoxes[currentFriendData.chatID].lastUpdated = getCurrentDate()
                getMessage(currentFriendData.chatID)
            }

            let webSocketProtocol = location.protocol === 'https:' ? 'wss:' : 'ws:';
            const messageSocketUrl = `${webSocketProtocol}//${location.host}/mxh/messageSocket?userID=${userAccountDetails.userID}`
            messageSocket = new WebSocket(messageSocketUrl)
            messageSocket.onmessage=processIncomingMessage
        })
        .catch(error => console.error(error))
        const text_input = document.querySelector(".chat-box .text-input");
        text_input.addEventListener("keydown", function(e){
            if(e.code === 'Enter'){
                e.preventDefault();
                sendMessage();
            }
        });

    
    

    setTimeout(() => {
        const urlParams = new URLSearchParams(window.location.search);
        const chatIDToShow = urlParams.get('showChatID');
        if(chatIDToShow!=undefined){
            showChatFrame(chatIDToShow)
        }
    }, 500);
}

let currentOpenChatID = null;
function showChatFrame(chatID){
    for(index in messageBoxes){
        console.log(chatID==index)
        let chatBoxElement = document.querySelector(".chat-box")
        let noChatElement = document.querySelector(".no-chat-display")
        if(index == chatID){
            chatBoxElement.style.display='block'
            
            messageBoxes[index].chatFrameElement.style.display = "flex"
            currentOpenChatID = messageBoxes[index].chatID

            chatDisplayElement.scrollTop = chatDisplayElement.scrollHeight;
            
            if(messageBoxes[index].hasMessages){
                chatDisplayElement.style.display='block'
                noChatElement.style.display='none'
            }
            else{
                chatDisplayElement.style.display='none'
                noChatElement.style.display='block'
            }
        }
        else{
            messageBoxes[index].chatFrameElement.style.display = "none"
        }
    }
}

function sendMessage(){
    let textInputElement = document.querySelector("input.text-input")
    
    if(currentOpenChatID!=null && textInputElement.value != ""){


        let message = {
            chatID : currentOpenChatID,
            userID : userAccountDetails.userID,
            message : textInputElement.value,
            dateSent : getCurrentFormattedDate()
        }

        textInputElement.value = ""

        messageBoxes[currentOpenChatID].addMessage(message,"beforeend")
        
        chatDisplayElement.scrollTop = chatDisplayElement.scrollHeight;

        let messageStringJSON = JSON.stringify(message);
        messageSocket.send(messageStringJSON)

        if(!messageBoxes[currentOpenChatID].hasMessages){
            messageBoxes[currentOpenChatID].hasMessages=true;
            let noChatElement = document.querySelector(".no-chat-display")
            noChatElement.style.display='none'
            chatDisplayElement.style.display='block'
        }
    }
}

function processIncomingMessage(event){
    const receivedMessage = event.data;
    console.log(receivedMessage)
    let messageObject = JSON.parse(receivedMessage)

    messageBoxes[messageObject.chatID].addMessage(messageObject,"beforeend")
    
    if(currentOpenChatID==messageObject.chatID){
        chatDisplayElement.scrollTop = chatDisplayElement.scrollHeight;
    }
}

let messageCount = 10
function getMessage(chatID){
    let getChatID = chatID==undefined?currentOpenChatID:chatID

    if(!messageBoxes[getChatID].isLastMessage && getChatID != undefined){

        const params = new URLSearchParams();
        params.append('chatID', getChatID);
        params.append('lastDate',messageBoxes[getChatID].lastUpdated)
        params.append('count',messageCount)
        const messageChatRequestURL = `ChatRequest/Messages?${params.toString()}`;
    
    
        fetch(messageChatRequestURL)
            .then(response => response.json())
            .then(fetchedMessageData => {
                if(fetchedMessageData.length!=0){
                    messageBoxes[getChatID].hasMessages=true;
                }
                let currentMessages = messageBoxes[getChatID].messages
                let lastMessage = currentMessages[currentMessages.length-10]
                for(messageIndex in fetchedMessageData){
                    messageBoxes[getChatID].addMessage(fetchedMessageData[messageIndex],'afterbegin')
                }
                
                if(fetchedMessageData.length<messageCount){
                    messageBoxes[getChatID].isLastMessage=true;
                }
                else{
                    messageBoxes[getChatID].lastUpdated = convertToSQLDate(new Date(new Date(fetchedMessageData[fetchedMessageData.length-1].dateSent).getTime()-1))
                }
                if(lastMessage!=undefined){
                    let messageElements = chatDisplayElement.querySelectorAll(`#chat-frame-${getChatID} .message-frame .message-text`)
                    for(index in messageElements){
                        console.log(messageElements[index].innerText)
                        if(messageElements[index].innerText == lastMessage.message){
                            let scrollPosition = messageElements[index].offsetTop;
                            chatDisplayElement.scrollTop = scrollPosition;
                        }
                    }
                }
            })
    }
}

function isScrolledTop(element){
    // Check if the element is scrolled to the top
        if(element.scrollTop === 0){
            if(!element.isLocked){
                element.isLocked=true;
                getMessage()
                element.isLocked=false;
            }
        }
}

// var friend_items = document.querySelectorAll(".friend-panel .friend-item");

// friend_items.forEach(item => {
//     item.addEventListener("click", function() {
//         friend_items.forEach(item => {
//             item.style.backgroundColor = "white";
//         });
//         this.style.backgroundColor = "#E0F4FF";
//     });
// });