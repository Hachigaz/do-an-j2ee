let userAccountDetails;
let messageBoxes = [];

let friendPanelElement
let chatDisplayElement

function setupPage(){
    chatDisplayElement = document.querySelector("div.chat-display")
    friendPanelElement = document.querySelector("div.friend-panel-frame")
    //get friend details
    const friendDataRequestURL = `DataRequest/FriendList`;
    fetch(friendDataRequestURL)
        .then(response => response.json())
        .then(fetchedFriendData =>{
            let friendData = fetchedFriendData[0]
            userAccountDetails = fetchedFriendData[1]

            for(friendIndex in friendData){
                const currentFriendData = friendData[friendIndex]

                messageBoxes[currentFriendData.chatID]=new MessageBox(currentFriendData.chatID,currentFriendData.friendDetails)

                const params = new URLSearchParams();
                params.append('chatID', currentFriendData.chatID);
                const messageDataRequestURL = `DataRequest/Messages?${params.toString()}`;


                fetch(messageDataRequestURL)
                    .then(response => response.json())
                    .then(fetchedMessageData => {
                        for(messageIndex in fetchedMessageData){
                            messageBoxes[currentFriendData.chatID].addMessage(fetchedMessageData[messageIndex])
                        }
                        console.log(fetchedMessageData)
                    })
                
                messageBoxes[friendData[friendIndex].chatID].chatFrameElement.style.display = "none"
            }
        })
        .catch(error => console.error(error))
    //setup socket connection
}

function showChatFrame(chatID){
    for(index in messageBoxes){
        if(index == chatID){
            messageBoxes[index].chatFrameElement.style.display = "flex"
        }
        else{
            messageBoxes[index].chatFrameElement.style.display = "none"
        }
    }
}