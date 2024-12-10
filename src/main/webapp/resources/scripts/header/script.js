// JS Nam thêm vào
window.addEventListener("load", setupHeader());

function setupHeader() {
	const requestURL = `Post/GetHeader`;
	fetch(requestURL)
	.then(response => response.text())
	.then(text => {
		document.querySelector("header .right-menu-icon").insertAdjacentHTML("beforeend", text);
	})
}

// const dropdownNotify = document.getElementById("dropdown-notify");
// dropdownNotify.addEventListener("click", function () {
//     const dropdownMenuNotify = document.getElementById("dropdown-menu-notify");
//     dropdownMenuNotify.classList.toggle("active");
// });

const dropdownMessage = document.getElementById("dropdown-message");
dropdownMessage.addEventListener("click", function () {
    const dropdownMenuMessage = document.getElementById("dropdown-menu-message");
    dropdownMenuMessage.classList.toggle("active");
});

function previewImage() {
    var imageInput = document.getElementById('imageInput');
    var previewImg = document.getElementById('account-detail-user-img');
    var file = imageInput.files[0]; // Lấy tệp tin đã chọn

    // Kiểm tra xem người dùng đã chọn tệp tin hay chưa
    if (file) {
        var reader = new FileReader();

        // Đọc dữ liệu hình ảnh từ tệp tin
        reader.onload = function (e) {
            previewImg.src = e.target.result; // Hiển thị hình ảnh
        }

        reader.readAsDataURL(file); // Đọc dữ liệu dưới dạng URL dữ liệu
    } else {
        previewImg.src = '/img/no-image.png'; // Reset hình ảnh nếu không có tệp tin được chọn
    }
}

function getImageName(url) {
    var name = str_split(url, "/");
    name = name[name.length - 1];
    return name;
}

function checkCreatePostForm() {
    let createPostContentTextarea = document.getElementById("create-post-content-textarea").value.trim();
    let files = document.getElementById("files").files;
    if (createPostContentTextarea == "" && files.length == 0) {
        return false;
    }
    return true;
}

if (document.querySelector("#files")) {
    document.querySelector("#files").addEventListener("change", (e) => {
        if (e.target.files.length > 0) {
            document.getElementById("inner").style.display = 'none';
            document.getElementById("container").classList.remove("hide");
        } else {
            document.getElementById("inner").style.display = 'flex';
            document.getElementById("container").classList.add("hide");
        }
        if (window.File && window.FileReader && window.FileList && window.Blob) {
            const files = e.target.files;
            const output = document.querySelector("#create-post-upload-img");

            for (let i = 0; i < files.length; i++) {
                if (!files[i].type.match("image")) continue;
                const picReader = new FileReader();
                picReader.addEventListener("load", function (event) {
                    const picFile = event.target;
                    const div = document.createElement("div");
                    div.classList.add("img");
                    div.innerHTML = `<img src="${picFile.result}" title="${picFile.name}"/>`;
                    output.appendChild(div);
                })
                picReader.readAsDataURL(files[i]);
            }
        } else {
            window.alert("Your browser does not support the File API");
        }
    })
}

function resetFileInput(id) {
    document.getElementById(id).value = '';
    document.getElementById("create-post-upload-img").innerHTML = "";
}

function seeMorePostText(id) {
    var dots = document.getElementById("dotsPostId-" + id);
    var moreText = document.getElementById("moreTextPostId-" + id);
    var seeMoreBtn = document.getElementById("seeMoreBtnPostId-" + id);
    var seeLessBtn = document.getElementById("seeLessBtnPostId-" + id);

    if (dots.style.display === "none") {
        dots.style.display = "inline";
        seeMoreBtn.style.display = 'inline';
        moreText.style.display = "none";
        seeLessBtn.style.display = "none";
    } else {
        dots.style.display = "none";
        seeMoreBtn.style.display = "none";
        moreText.style.display = "inline";
        seeLessBtn.style.display = "inline";
    }
}

function likePost(id) {
    let isLiked = document.getElementById("isLiked-" + id)
    let likePost = document.getElementById("likePost-" + id);
    let likedQuantity = document.getElementById("likedQuantity-" + id);
    likedQuantity.value = Number(likedQuantity.value);
    likedQuantity.value = parseInt(likedQuantity.value);
    let likeNumberId = document.getElementById("likeNumberId-" + id);
    if (isLiked.value == "false") {
        likedQuantity.value = parseInt(likedQuantity.value) + parseInt("1");
        likePost.innerHTML = '<i class="fa-solid fa-thumbs-up fa-2x"></i> Like';
        likePost.classList.add("liked");
        likeNumberId.innerHTML = '<div class="wrap"><i class="fa-solid fa-thumbs-up fa-sm"></i></div> You and ' + (parseInt(likedQuantity.value) - 1) + ' others';
        isLiked.value = 'true';
    } else {
        likedQuantity.value -= 1;
        likePost.innerHTML = '<i class="fa-regular fa-thumbs-up fa-2x"></i> Like';
        likePost.classList.remove("liked");
        likeNumberId.innerHTML = '<div class="wrap"><i class="fa-solid fa-thumbs-up fa-sm"></i></div> ' + likedQuantity.value + ' Like';
        isLiked.value = 'false';
    }
}

function openPostCommentCard(id) {
    document.getElementById("post-comment-container").classList.toggle("active");
}

function cutText(word, string) {
    return
}

function openImageDetail(src) {
    document.getElementById("post-image-detail-container").classList.toggle("active");
    var str = src.split("/");
    var currentImgURL = str[2] + "/" + str[3];

    let params = new URLSearchParams();
    params.append("imageSrc", currentImgURL);

    let getImageDetail = `Post/GetImageDetail?${params.toString()}`
    fetch(getImageDetail)
        .then(response => response.text())
        .then(text => {
            document.querySelector("#post-image-detail-container .inner .main").innerHTML = text;
        })
}

function getPreOrNextImage(src) {
    var str = src.split("/");
    var currentImgURL = str[2] + "/" + str[3];

    let params = new URLSearchParams();
    params.append("imageSrc", currentImgURL);

    let getImageDetail = `Post/GetImageDetail?${params.toString()}`
    fetch(getImageDetail)
        .then(response => response.text())
        .then(text => {
            document.querySelector("#post-image-detail-container .inner .main").innerHTML = text;
        })
}

function checkFriends(keyword) {
    document.getElementById('search-friend-dropdown').classList.add('active');
    if (keyword == "") {
        document.querySelector("#search-friend-dropdown .list").innerHTML = "";
        return;
    }
    var formData = new FormData();
    formData.append("isEnter", "false");
    formData.append("keyword", keyword)
    var xml = new XMLHttpRequest();
    var request = "/mxh/SearchFriendsDropdown";
    xml.open("POST", request, true);
    xml.onload = function () {
        if (this.responseText != "None") {
            document.querySelector("#search-friend-dropdown .list").innerHTML = this.responseText;
        } else {
            document.querySelector("#search-friend-dropdown .list").innerHTML = "";
        }
    }
    xml.send(formData);
}

document.querySelector(".header-search .input-container #keyword").addEventListener("keypress", function (event) {
    if (event.key === "Enter") {
        var keyword = document.querySelector(".header-search .input-container #keyword").value;
        if (keyword == "") {
            return;
        }
        var formData = new FormData();
        formData.append("isEnter", "true");
        formData.append("keyword", keyword)
        var xml = new XMLHttpRequest();
        var request = "/mxh/SearchFriendsDropdown";
        
        xml.open("POST", request, true);
        xml.onreadystatechange = function () {
            if (this.readyState == XMLHttpRequest.DONE && this.status == 200) {
                document.querySelector("#main .main-content").innerHTML = this.responseText;
                document.getElementById('search-friend-dropdown').classList.remove('active')
            } else {
                console.log(this.status);
            }
        };
        xml.send(formData);
    }
});

