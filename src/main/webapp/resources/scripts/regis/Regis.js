// $(document).ready(function () {
//   $('#registerForm').submit(function (event) {
//     event.preventDefault();

//     var formData = {
//       username: $('#username').val(),
//       email: $('#email').val(),
//       password: $('#password').val(),
//       firstName: $('#firstName').val(),
//       lastName: $('#lastName').val(),
//       address: $('#address').val(),
//       birthDate: $('#birthDate').val(),
//     };

//     $.ajax({
//       type: 'POST',
//       url: 'register',
//       contentType: 'application/json',
//       data: JSON.stringify(formData),
//       success: function (response) {
//         console.log(response);
//         // Xử lý phản hồi từ máy chủ (nếu cần)
//       },
//       error: function (error) {
//         console.error(error);
//         // Xử lý lỗi (nếu cần)
//       }
//     });
//   });
// });
