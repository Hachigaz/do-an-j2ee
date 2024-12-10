
    $(document).ready(function () {
        $('form').submit(function (event) {
            event.preventDefault();

            var currentPassword = $('#currentPassword').val();
            var newPassword = $('#newPassword').val();
            var confirmNewPassword = $('#confirmNewPassword').val();

            $.ajax({
                type: 'POST',
                url: 'changepassword',
                data: {
                    currentPassword: currentPassword,
                    newPassword: newPassword,
                    confirmNewPassword: confirmNewPassword
                },
                success: function (response) {
                    if (response === 'success') {
                        alert('Password changed successfully.');
                        window.location.href = "home-page";

                        // Redirect to home-page or perform other actions
                    } else {
                        alert(response); // Display the error message
                    }
                }
            });
        });
    });

