// Trong pass.js
$(document).ready(function () {
    // Bắt sự kiện khi form được submit
    $('form').submit(function (event) {
        // Ngăn chặn hành động mặc định của form
        event.preventDefault();

        // Lấy giá trị từ các ô input
        var currentPassword = $('#currentPassword').val();
        var newPassword = $('#newPassword').val();
        var confirmNewPassword = $('#confirmNewPassword').val();

        // Kiểm tra logic xác nhận mật khẩu
        if (newPassword !== confirmNewPassword) {
            alert("New password and confirm password do not match.");
            return;
        }

        // Tạo form để gửi dữ liệu
        var form = $('<form action="changepassword" method="post">' +
            '<input type="hidden" name="currentPassword" value="' + currentPassword + '">' +
            '<input type="hidden" name="newPassword" value="' + newPassword + '">' +
            '<input type="hidden" name="confirmNewPassword" value="' + confirmNewPassword + '">' +
            '</form>');

        // Thêm form vào body và submit nó
        $('body').append(form);
        form.submit();
    });
});
