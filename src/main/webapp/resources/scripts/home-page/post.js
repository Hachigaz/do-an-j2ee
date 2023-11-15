let postFrameElement

let postCount = 10;
function setupPostFeed(){
    postFrameElement = document.querySelector("div.user-feed-panel div.posts-frame");
    
    let currentDate = getCurrentDate();

    getPosts(currentDate,postCount)
}

let lastUpdatedPost;
function loadMorePosts(){

}

function getPosts(end,count){
    let params = new URLSearchParams();
    params.append('postCount',count)
    params.append('endDate',end)
    const postRequestURL = `Post/GetPosts?${params.toString()}`

    fetch(postRequestURL)
        .then(response => response.text())
        .then(text => {
            postFrameElement.insertAdjacentHTML("beforeend",text);
            if(findOccurences(text,"<div class=\"comment-item\">")<postCount){
                postFrameElement.insertAdjacentHTML("beforeend",`<div class="end-of-list cross-effect">Hết</div>`);
            }
        })
}

function processLike(postID, element){
    if(element.isAvailable === undefined){
        element.isAvailable=true
    }
    if(element.isAvailable){
        element.classList.toggle("clicked")
        element.isAvailable=false;

        let clickedIconElement = element.querySelector("img.clicked-icon")
        let unclickedIconElement = element.querySelector("img.unclicked-icon")
        
        if(clickedIconElement.classList.contains("show-icon")){
            clickedIconElement.classList.add("hide-icon")
            clickedIconElement.classList.remove("show-icon")
            unclickedIconElement.classList.add("show-icon")
            unclickedIconElement.classList.remove("hide-icon")

            let likeCountElement = document.querySelector(`#post-item-${postID} .like-count .count-number`)
            likeCountElement.textContent = parseInt(likeCountElement.innerText) - 1
        }
        else{
            clickedIconElement.classList.add("show-icon")
            clickedIconElement.classList.remove("hide-icon")
            unclickedIconElement.classList.add("hide-icon")
            unclickedIconElement.classList.remove("show-icon")

            let likeCountElement = document.querySelector(`#post-item-${postID} .like-count .count-number`)
            likeCountElement.textContent = parseInt(likeCountElement.innerText) + 1
        }

        const params = new URLSearchParams();
        params.append('postID',postID);
        const requestLikePostURL = `Post/LikePost?${params.toString()}`

        fetch(requestLikePostURL);

        setTimeout(function(element){
            element.isAvailable=true;
        }, 5000, element);
    }
    else{
        alert("chưa được")
    }
}

function showComment(postID){
    let commentSectionElement = document.querySelector(`#comment-section-${postID}`)
    
    if(commentSectionElement.style.display == ""){
        commentSectionElement.style.display="none"
    }
    if(commentSectionElement.style.display == "none"){
        commentSectionElement.style.display="block"
        let commentListElement = document.querySelector(`#comment-section-${postID} .comment-list`)
        if(commentListElement.innerHTML.trim() === ""){
            let returnedCommentCount = getComment(postID)
            
            if(returnedCommentCount<commentCount){
                commentListElement.insertAdjacentHTML("beforeend",`<div class="end-of-list cross-effect">Hết</div>`);
            }
        }
    }
    else{
        commentSectionElement.style.display="none"
    }
}

function onPostScroll(){
    
}

function onCommentScroll(postID){

}

let commentCount = 10;
function getComment(postID){
    let commentSectionElement = document.querySelector(`#comment-section-${postID}`)
    if(commentSectionElement.lastUpdated === undefined){
        commentSectionElement.lastUpdated = getCurrentDate();
    }
    let newUpdated = convertToSQLDate(new Date(convertToJSDate(commentSectionElement.lastUpdated).getTime()));
    
    let returnedCommentCount = -1;

    let params = new URLSearchParams();
    params.append('lastDate',newUpdated)
    params.append('commentCount',commentCount)
    params.append('postID',postID)

    let getCommentURL = `Post/GetComments?${params.toString()}`
    fetch(getCommentURL)
        .then(response => response.text())
        .then(text => {
            let commentListElement = document.querySelector(`#comment-section-${postID} .comment-list`)
            commentListElement.insertAdjacentHTML("beforeend",text);
            returnedCommentCount = findOccurences(text,"<div class=\"comment-item\">")

            if(returnedCommentCount==-1){
                console.log("lỗi không xác định ở getComment")
            }
            return returnedCommentCount;
        })
}

function processSubmitComment(postID){
    let commentInputElement = document.querySelector(`#post-item-${postID} .comment-input-wrapper textarea`)
    let commentText = commentInputElement.value;

    if(commentInputElement.isAvailable==undefined){
        commentInputElement.isAvailable = true;
    }

    if(commentInputElement.isAvailable){
        if(commentText!=""){
            let params = new URLSearchParams();
            params.append('postID',postID)
            params.append('commentText',commentText)
            params.append('dateSent',getCurrentDate())
        
            let getCommentURL = `Post/AddComment?${params.toString()}`
            fetch(getCommentURL)
    
            commentInputElement.value="";
    
            commentInputElement.isAvailable = false;
            
            setTimeout(function(element){
                element.isAvailable=true;
            }, 5000, commentInputElement);

            let newCommentHTML = `
            <div class="comment-item">
                <div class="comment-avatar-icon-wrapper">
                    <img src="resources/img/userdata/${"ABC"}">
                </div>
                <div class="comment-content">
                <div class="comment-bubble">
                    <div class="comment-username">
                        ${"AV"} ${"ASD"}
                    </div>
                    <div class="comment-text">
                        ${commentText}
                    </div>
                </div>
                <div class="comment-options">
                    <div class="comment-date">
                        ${getCurrentFormattedDate()}
                    </div>
                </div>
                </div>
            </div>
            `
            let commentListElement = document.querySelector(`#post-item-${postID}`)
            commentListElement.insertAdjacentHTML('afterbegin',newCommentHTML);
        }
    }
}

function reloadPageAndScrollToPost(postID){
    let params = new URLSearchParams();
    params.append("postID",postID);
    let = newUrl = `${window.location.origin + window.location.pathname}?${params.toString()}`
}