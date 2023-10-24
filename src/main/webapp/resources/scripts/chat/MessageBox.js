class MessageBox{
    
    chatID;
    friendAccountDetails;

    //
    constructor(chatID, friendAccountDetails){
        this.chatID = chatID;
        this.friendAccountDetails = friendAccountDetails;
    }
    messages =[];
    addMessage(message){
        messages.push(message)
    }
}

class Message{
    chatID;
    sentUserID;
    messageText;
    messageIndex;
    dateSent;

    constructor(chatID, sentUserID, messageText, messageIndex, dateSent){
        this.chatID = chatID;
        this.sentUserID = sentUserID;
        this.messageText = messageText;
        this.messageIndex = messageIndex;
        this.dateSent = dateSent;
    }
}

//này làm xong hết rãnh thì làm, này là hình ảnh đính kèm tin nhắn
class AttachedImage{
    chatID;
    chatIndex;
    imagePath;
}