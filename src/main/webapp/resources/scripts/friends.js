fetch('DataRequest/Friends') // Đặt URL đến API hoặc Servlet của bạn    
    .then(response => response.json())
    .then(data => {
            
        })
        .catch(error => console.error('Lỗi khi lấy dữ liệu JSON:', error));
