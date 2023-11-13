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
        })
}

function processLike(postID, element){
    if(element.isAvailable === undefined){
        element.isAvailable=true
    }
    if(element.isAvailable){
        element.isAvailable=false;
        setTimeout(function(element){
            console.log(element)
            element.isAvailable=true;
        }, 5000, element);
    }
    else{
        alert("chưa được")
    }
}

function processComment(postID){
    let commentSectionElement = document.querySelector(`#comment-section-${postID}`)
    if(commentSectionElement.style.display == "none"){
        commentSectionElement.style.display="block"
        if(commentSectionElement.innerHTML.trim() === ""){
            getComment(postID)
        }
    }
    else{
        commentSectionElement.style.display="none"
    }
}

function getComment(postID){
    let commentSectionElement = document.querySelector(`#comment-section-${postID}`)
    if(commentSectionElement.lastUpdated === undefined){
        commentSectionElement.lastUpdated = getCurrentDate();
    }
    let newUpdated = convertToSQLDate(convertToJSDate(commentSectionElement.lastUpdated).getTime()-1000*60*60*24);
    

    let params = new URLSearchParams();
    params.append('lastDate',newUpdated)
    params.append('commentCount',10)

    let getCommentURL = `Post/GetComments?${params.toString()}`
    fetch(getCommentURL)
        .then(response => response.text())
        .then(text => {
            console.log(text)
            commentSectionElement.insertAdjacentHTML("beforeend",text);
        })
}

function submitComment(postID){

}