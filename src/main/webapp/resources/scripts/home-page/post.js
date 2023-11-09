let postFrameElement

function setupPostFeed(){
    postFrameElement = document.querySelector("div.user-feed-panel div.posts-frame");
    
    let currentDate = getCurrentDate();
    let lastDate = convertToSQLDate(new Date(new Date().getTime()-1000*60*60*24))

    getPosts(lastDate,currentDate)
}
function getPosts(start,end){
    let params = new URLSearchParams();
    params.append('startDate',start)
    params.append('endDate',end)
    const postRequestURL = `Post/GetPosts?${params.toString()}`

    fetch(postRequestURL)
        .then(response => response.text())
        .then(text => {
            postFrameElement.insertAdjacentHTML("beforeend",text);
        })
}