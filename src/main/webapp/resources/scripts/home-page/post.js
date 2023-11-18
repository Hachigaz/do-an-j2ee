let postFrameElement

let loggedInUserDetails;

let postCount = 5;
function setupPostFeed(){
    postFrameElement = document.querySelector("div.user-feed-panel div.posts-frame");
    
    let currentDate = getCurrentDate();

    getPosts()

    let requestUSerDetailParams = new URLSearchParams()
    fetch(`UserServlet/GetUserDetails`)
        .then(response=>response.json())
        .then(jsonObject => {
            loggedInUserDetails = jsonObject;
        })
}

let lastUpdatedPost;
function getPosts(){
    if(!postFrameElement.isLastPost){
        if(postFrameElement.lastUpdated === undefined){
            postFrameElement.lastUpdated = getCurrentDate();
        }
        let params = new URLSearchParams();
        params.append('postCount',postCount)
        params.append('endDate',postFrameElement.lastUpdated)
        const postRequestURL = `Post/GetPosts?${params.toString()}`
    
        fetch(postRequestURL)
            .then(response => response.text())
            .then(text => {
                postFrameElement.insertAdjacentHTML("beforeend",text);

                let posts = postFrameElement.querySelectorAll(".post-item")

                let lastPost = posts[posts.length-1]

                
                postFrameElement.lastUpdated = convertToSQLDate(new Date(new Date(lastPost.querySelector(".post-date").innerText).getTime()-1));

                let returnPostCount = findOccurences(text,"<div class=\"post-item\"")
                
                if(returnPostCount<postCount){
                    postFrameElement.isLastPost=true;
                    postFrameElement.insertAdjacentHTML("beforeend",`<div class="end-of-list cross-effect">Hết</div>`);
                }
            })
    }
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
            getComment(postID)
        }
    }
    else{
        commentSectionElement.style.display="none"
    }
}

let commentCount = 20;
function getComment(postID){
    let commentSectionElement = document.querySelector(`#comment-section-${postID}`)
    if(!commentSectionElement.isLastComment){
        if(commentSectionElement.lastUpdated === undefined){
            commentSectionElement.lastUpdated = getCurrentDate();
        }
        let newUpdated = convertToSQLDate(new Date(convertToJSDate(commentSectionElement.lastUpdated).getTime()-1));

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
                
                let comments = commentListElement.querySelectorAll(".comment-item")
                let lastComment = comments[comments.length-1]
                
                commentSectionElement.lastUpdated = convertToSQLDate(new Date(lastComment.querySelector(".comment-date").innerText));

                let returnedCommentCount = findOccurences(text,"<div class=\"comment-item\">")
                if(returnedCommentCount<commentCount){
                    commentSectionElement.isLastComment=true;
                    commentListElement.insertAdjacentHTML("beforeend",`<div class="end-of-list cross-effect">Hết</div>`);
                }
            })
    }
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
                    <img src="resources/img/userdata/${loggedInUserDetails.avatar}">
                </div>
                <div class="comment-content">
                <div class="comment-bubble">
                    <div class="comment-username">
                        ${loggedInUserDetails.firstName} ${loggedInUserDetails.lastName}
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
            let commentListElement = document.querySelector(`#post-item-${postID} .comment-list`)
            commentListElement.insertAdjacentHTML('afterbegin',newCommentHTML);
        }
    }
}

function reloadPageAndScrollToPost(postID){
    let params = new URLSearchParams();
    params.append("postID",postID);
    let = newUrl = `${window.location.origin + window.location.pathname}?${params.toString()}`
}


function checkCommentScroll(postID){
    let commentListElement = document.querySelector(`#comment-section-${postID}`);

    let isScrolledToBottom = commentListElement.scrollTop + commentListElement.clientHeight === commentListElement.scrollHeight;

    if (isScrolledToBottom) {
      getComment(postID)
    }
}

function checkPostScroll(element){
    var scrollPosition = window.scrollY || window.pageYOffset || document.documentElement.scrollTop;
    var totalHeight = document.body.scrollHeight;
    var viewportHeight = window.innerHeight;

    if (scrollPosition + viewportHeight >= totalHeight) {
        getPosts()
    }
}
