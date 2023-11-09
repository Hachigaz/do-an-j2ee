let chatFrameIDStr = "chat-frame-"
let chatUserItemIDStr = "friend-item-"

let imageSrc = "resources/img/userdata/"

class MessageBox{
    chatID;
    friendAccountDetails;
    
    friendItemElement;
    chatFrameElement;

    //
    constructor(chatID, friendAccountDetails){
        this.chatID = chatID;
        this.friendAccountDetails = friendAccountDetails;

        {
            let chatItemHTML = `
                <div class="friend-item" id="${chatUserItemIDStr+chatID}" onclick="showChatFrame(${chatID})">
                    <div class="username-frame">
                        <div class="username">${friendAccountDetails.firstName+" "+friendAccountDetails.lastName}</div>
                    </div>
                    <div class="avatar">
                        <img class="user-avatar" src="resources/img/userdata/${friendAccountDetails.avatar}" />
                    </div>
                </div> 
            `
            friendPanelElement.insertAdjacentHTML("beforeend",chatItemHTML)
            chatDisplayElement.insertAdjacentHTML("beforeend",`<div class="chat-frame" id="${chatFrameIDStr+chatID}"></div>`)
        }

        this.friendItemElement = document.querySelector(`div#${chatUserItemIDStr+chatID}`)
        this.chatFrameElement = document.querySelector(`div#${chatFrameIDStr+chatID}`)
    }
    messages =[];
    
    addMessage(message){
        this.messages.push(message)

        if(message.userID==this.friendAccountDetails.userID){
            let fromMessageHTML = `
                <div class="message-frame">
                    <div class="from-message">
                        <div class="message-user-wrapper">
                            <div class="user-avatar-wrapper">
                                <img class="img" src="${imageSrc+this.friendAccountDetails.avatar}">
                            </div>
                        </div>
                        <div class="message-box">
                            <div class="user-fullname">${this.friendAccountDetails.lastName}</div>
                            <div class="message-text">${message.message}</div>
                            <div class="date-sent">${message.dateSent}</div>
                        </div>
                    </div>
                </div>`
            this.chatFrameElement.insertAdjacentHTML("beforeend",fromMessageHTML)
        }
        else{
            let toMessageHTML = `
                <div class="message-frame">
                    <div class="to-message">
                        <div class="user-avatar-wrapper">
                            <img class="img" src="${imageSrc+userAccountDetails.avatar}" />
                        </div>
                        <div class="message-box">
                            <div class="message-user-wrapper">
                            <div class="user-fullname">${userAccountDetails.lastName}</div>
                            <div class="message-text">${message.message}</div>
                                <div class="date-sent">${message.dateSent}</div>
                            </div>
                        </div>
                    </div>
                </div>`
            this.chatFrameElement.insertAdjacentHTML("beforeend",toMessageHTML)
        }
    }
}