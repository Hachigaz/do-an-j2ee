fetch('DataRequest/Friends') // Đặt URL đến API hoặc Servlet của bạn    
    .then(response => response.json())
    .then(data => {
            for(user in data){
                console.log(data[user].username)
            }
        })
        .catch(error => console.error('Lỗi khi lấy dữ liệu JSON:', error));
