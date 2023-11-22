$(document).ready(function () {
    $('#registerForm').submit(function (event) {
        event.preventDefault();

        var formData = new FormData($('#userregisterForm')[0]);
        var birthDate = $('#birthDate').val();
        formData.append('birthDate', birthDate);
       
        $.ajax({
            type: 'POST',
            url: 'register',
            contentType: false,
            processData: false,
            data: formData,
            success: function (response) {
                console.log(response);

                if (response.status === "error") {
                    alert(response.message); // Display only the message part for errors
                } else {
                    alert(response.message); // Display success message

                    // Delay for 4 seconds before redirecting to the "/sign-in" page
                    setTimeout(function () {
                        window.location.href = "sign-in";
                    }, 2000); // 4000 milliseconds = 4 seconds
                }
            },
            error: function (xhr, status, error) {
                console.error(xhr.responseText);
                alert(response.message); 
                // Handle error, e.g., show an error message
            }
        });
    });
});