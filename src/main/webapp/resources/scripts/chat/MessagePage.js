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

                const params = new URLSearchParams();
                params.append('chatID', currentFriendData.chatID);
                const messageChatRequestURL = `ChatRequest/Messages?${params.toString()}`;


                fetch(messageChatRequestURL)
                    .then(response => response.json())
                    .then(fetchedMessageData => {
                        for(messageIndex in fetchedMessageData){
                            messageBoxes[currentFriendData.chatID].addMessage(fetchedMessageData[messageIndex])
                        }
                    })
                
                messageBoxes[friendData[friendIndex].chatID].chatFrameElement.style.display = "none"
            }

            //temp
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
}

let currentOpenChatID = null;
function showChatFrame(chatID){
    for(index in messageBoxes){
        if(index == chatID){
            messageBoxes[index].chatFrameElement.style.display = "flex"
            currentOpenChatID = messageBoxes[index].chatID

            chatDisplayElement.scrollTop = chatDisplayElement.scrollHeight;
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

        messageBoxes[currentOpenChatID].addMessage(message)
        
        chatDisplayElement.scrollTop = chatDisplayElement.scrollHeight;

        let messageStringJSON = JSON.stringify(message);
        messageSocket.send(messageStringJSON)
    }
}

function processIncomingMessage(event){
    const receivedMessage = event.data;
    console.log(receivedMessage)
    let messageObject = JSON.parse(receivedMessage)

    messageBoxes[messageObject.chatID].addMessage(messageObject)
    
    if(currentOpenChatID==messageObject.chatID){
        chatDisplayElement.scrollTop = chatDisplayElement.scrollHeight;
    }
}
