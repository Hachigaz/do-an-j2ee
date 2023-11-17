function start(){
    setupPostFeed();
}

fetch('DataRequest/FriendDetails') // Đặt URL đến API hoặc Servlet của bạn    
    .then(response => response.json())
    .then(data => {
            for(user in data){
                
            }
        })
        .catch(error => console.error('Lỗi khi lấy dữ liệu JSON:', error));
