let postFrameElement

const postCount = 3;
const friendListQuantity = 20;
const commentCount = 5;
function setupPostFeed() {
	postFrameElement = document.querySelector("div#main div.main-content #post-list");

	let currentDate = getCurrentDate();

	setupCreatePostInterface();
	setupCreatePostContainer();
	setupLeftMenu();
	getPosts(currentDate, postCount);
	getFriendList();
}

let lastUpdatedPost;
function loadMorePosts() {

}

function setupCreatePostInterface() {
	const requestURL = `Post/GetCreatePostInterface`;
	fetch(requestURL)
	.then(response => response.text())
	.then(text => {
		document.querySelector("#create-post-interface .top .user-img").innerHTML  = text;
	})
}

function setupLeftMenu() {
	const requestURL = `Post/GetLeftMenu`;
	fetch(requestURL)
	.then(response => response.text())
	.then(text => {
		document.querySelector("#main .left-menu-container .top .list").insertAdjacentHTML("afterbegin", text);
	})
}

function setupCreatePostContainer() {
	const requestURL = `Post/GetCreatePostContainer`;
	fetch(requestURL)
	.then(response => response.text())
	.then(text => {
		document.querySelector("#create-post-container #create-post-card").insertAdjacentHTML("afterbegin", text);
	})
}


function getPosts(end, count) {
	let params = new URLSearchParams();
	params.append('postCount', count)
	params.append('endDate', end)
	const postRequestURL = `Post/GetPosts?${params.toString()}`

	fetch(postRequestURL)
		.then(response => response.text())
		.then(text => {
			postFrameElement.insertAdjacentHTML("beforeend", text);
		})
}

function getFriendList() {
	let params = new URLSearchParams();
	params.append("listQuantity", friendListQuantity);
	const postRequestURL = `Post/GetRightFriendList?${params.toString()}`;
	fetch(postRequestURL)
		.then(response => response.text())
		.then(text => {
			document.querySelector("#main .right-menu-container .inner .list").innerHTML = text;
		})
}

function processLike(postID, element) {
	console.log(element.isAvailable)
	if (element.isAvailable === undefined) {
		element.isAvailable = true
	}
	if (element.isAvailable) {
		likePost(postID)
		element.isAvailable = false;
		const params = new URLSearchParams();
		params.append('postID', postID);

		const requestLikePostURL = `Post/LikePost?${params.toString()}`

		fetch(requestLikePostURL);

		setTimeout(function (element) {
			element.isAvailable = true;
		}, 5000, element);
	} else {
		alert("Vui lòng chờ vài giây trước khi bấm lại")
	}
}

function processComment(postID) {
	let commentListElement = document.querySelector(`#post-comment-container`)
	if (commentListElement.innerHTML.trim() === "") {
		getComment(postID);
	} else {
		commentListElement.innerHTML = '';
	}
}


function getComment(postID) {
	let commentSectionElement = document.querySelector(`#post-comment-container`)
	if (commentSectionElement.lastUpdated === undefined) {
		commentSectionElement.lastUpdated = getCurrentDate();
	}
	let newUpdated = convertToSQLDate(new Date(convertToJSDate(commentSectionElement.lastUpdated).getTime() - 1000 * 60 * 60 * 24));


	let params = new URLSearchParams();
	let currentDate = getCurrentDate();
	params.append('postCount', postCount);
	params.append('currentDate', currentDate);
	params.append('lastDate', newUpdated)
	params.append('commentCount', commentCount)
	params.append('postID', postID)

	let getCommentURL = `Post/GetComments?${params.toString()}`
	fetch(getCommentURL)
		.then(response => response.text())
		.then(text => {
			let commentListElement = document.querySelector(`#post-comment-container`)
			commentListElement.insertAdjacentHTML("beforeend", text);
			if (findOccurences(text, "<div class=\"comment-item\">") < commentCount) {
				commentListElement.insertAdjacentHTML("beforeend", `<div class="end-of-list cross-effect">Hết</div>`);
			}
		})
}

function getPostDetail(postId) {
	let commentSectionElement = document.querySelector(`#post-comment-container`)
	if (commentSectionElement.lastUpdated === undefined) {
		commentSectionElement.lastUpdated = getCurrentDate();
	}
	let newUpdated = convertToSQLDate(new Date(convertToJSDate(commentSectionElement.lastUpdated).getTime() - 1000 * 60 * 60 * 24));


	let params = new URLSearchParams();
	params.append('postCount', postCount);
	params.append('currentDate', getCurrentDate());
	params.append('lastDate', newUpdated)
	params.append('commentCount', commentCount)
	params.append('postId', postId);

	const postRequestURL = `Post/GetPostDetail?${params.toString()}`

	fetch(postRequestURL)
		.then(response => response.text())
		.then(text => {
			let postDetail = document.querySelector(`#post-comment-container`)
			postDetail.innerHTML = text;
		})
}

function processSubmitComment(postID) {
	let commentInputElement = document.querySelector(`#post-comment-container-${postID} 
    .create-comment .input-container  #post-comment-submit-content-${postID}`)
	let commentText = commentInputElement.value.trim();

	if (commentText != "") {
		let params1 = new URLSearchParams();
		params1.append('postID', postID)
		params1.append('commentText', commentText)
		params1.append('dateSent', getCurrentDate())

		let getCommentURL = `Post/AddComment?${params1.toString()}`
		fetch(getCommentURL)
			.then(response => response.text())
			.then(text => {
				let postComments = document.querySelector(`#post-comment-container-${postID} .comment-card-main .comments-container`)
				postComments.insertAdjacentHTML("afterbegin", text);

				commentQuantity1 = document.querySelector("#main .main-content #post-list #post-card-" + postID + " #innerCommentQuantity-" + postID);
				commentQuantity1.value = Number(commentQuantity1.value);
				commentQuantity1.value = parseInt(commentQuantity1.value);
				commentQuantity1.value = parseInt(commentQuantity1.value) + parseInt("1");
				document.querySelector("#main .main-content #post-list #commentNumberId-" + postID).innerText = commentQuantity1.value + " Comment";

				commentQuantity2 = document.querySelector("#post-comment-container #innerCommentQuantity-" + postID);
				commentQuantity2.value = Number(commentQuantity2.value);
				commentQuantity2.value = parseInt(commentQuantity2.value);
				commentQuantity2.value = parseInt(commentQuantity2.value) + parseInt("1");
				document.querySelector("#post-comment-container #commentNumberId-" + postID).innerText = commentQuantity2.value + " Comment";
			})

		commentInputElement.value = "";

	}
}

function submitCommentByPressEnter(id, e) {
	if (e.key === "Enter") {
		processSubmitComment(id);
	}
}


function processAddNewPost(e) {
	if (!checkCreatePostForm()) {
		e.preventDefault();
		window.alert("Bạn chưa nhập nội dung cho bài post.");
	} else {

		let description = document.getElementById("create-post-content-textarea");

		let formData = new FormData();
		formData.append('description', description.value);

		let inputElement = document.getElementById("files");
		if (inputElement.files.length > 0) {
			let files = Array.from(inputElement.files);
			let quantity = 0;
			files.forEach(function (file, index) {
				formData.append('image-' + index, file);
				++quantity;
			});
			formData.append('imageQuantity', quantity);
		} else {
			formData.append('imageQuantity', 0);
		}

		// 
		fetch('AddNewPost', {
			method: 'POST',
			body: formData,
		})
			.then(response => response.text())
			.then(text => {
				postFrameElement.insertAdjacentHTML("afterbegin", text);
			})

		description.value = '';
		document.getElementById("create-post-container").style.display = 'none';
		document.getElementById("create-post-upload-img").innerHTML = "";
		document.getElementById("create-post-upload-img").style.display = 'none';
	}
}

function getMoreComment(postID) {
	let pos = document.querySelectorAll("#post-comment-container-" + postID + " .comment-card-main .comments-container .comment").length;

	let commentSectionElement = document.querySelector(`#post-comment-container`)
	if (commentSectionElement.lastUpdated === undefined) {
		commentSectionElement.lastUpdated = getCurrentDate();
	}
	let newUpdated = convertToSQLDate(new Date(convertToJSDate(commentSectionElement.lastUpdated).getTime() - 1000 * 60 * 60 * 24));


	let params = new URLSearchParams();
	params.append('currentDate', getCurrentDate());
	params.append('lastDate', newUpdated)
	params.append('commentCount', commentCount)
	params.append('postId', postID);
	params.append('pos', pos);

	const postRequestURL = `Post/GetMoreComment?${params.toString()}`
	fetch(postRequestURL)
		.then(response => response.text())
		.then(text => {
			document.querySelector("#post-comment-container-" + postID + " .comment-card-main .comments-container").insertAdjacentHTML("beforeend", text)
		})

	const viewMoreCommentRequestURL = `Post/GetViewMoreComment?${params.toString()}`
	fetch(viewMoreCommentRequestURL)
		.then(response => response.text())
		.then(text => {
			let viewMoreComment = document.querySelector("#post-comment-container-" + postID + " #view-more-comment");
			if (text != "")
				viewMoreComment.innerHTML = text;
			else {
				viewMoreComment.innerHTML = text;
			}
		})
}

function difference(first, sec) {
	return Math.abs(first - sec);
}

function checkScroll(e) {
	var diff = difference((e.scrollTop + e.clientHeight), e.scrollHeight);

	if (diff < 1) {
		processGetMorePost(e.scrollHeight);
	}
}

function processGetMorePost(height) {
	let pos = document.querySelectorAll("#post-list .post-card").length;

	let loading = document.getElementById("loading-container");
	if (!loading.classList.contains("active")) {
		loading.classList.toggle("active");
		height = Number(height);
		height = parseInt(height);
		loading.style.bottom = height;

		let params = new URLSearchParams();
		let currentDate = getCurrentDate();
		params.append('postCount', postCount);
		params.append('endDate', currentDate);
		params.append('pos', pos);
		const postRequestURL = `Post/GetMorePosts?${params.toString()}`;

		fetch(postRequestURL)
			.then(response => response.text())
			.then(text => {
				setTimeout(function () {
					loading.classList.toggle("active");
					loading.style.bottom = 0;
					postFrameElement.insertAdjacentHTML("beforeend", text);
				}, 2000);
			});
	} 
}