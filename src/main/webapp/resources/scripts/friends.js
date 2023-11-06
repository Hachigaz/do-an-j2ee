fetch('/friend-page') // Đặt URL đến API hoặc Servlet của bạn    
    .then(response => response.json())
    .then(data => {
            // Xử lý dữ liệu JSON ở đây
            console.log(data); // In dữ liệu ra màn hình console
        })
        .catch(error => console.error('Lỗi khi lấy dữ liệu JSON:', error));
