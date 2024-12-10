function toggleRegisterForm() {
    var registerForm = document.getElementById("registerForm");

    if (registerForm.style.display === "none" || registerForm.style.display === "") {
        registerForm.style.display = "block";
        applyBlurEffect(true);
    } else {
        registerForm.style.display = "none";
        applyBlurEffect(false);
    }
}

function applyBlurEffect(blur) {
    var elementsToBlur = document.querySelectorAll("body > *:not(#registerForm)");

    for (var i = 0; i < elementsToBlur.length; i++) {
        if (blur) {
            elementsToBlur[i].classList.add("blurred");
            elementsToBlur[i].style.pointerEvents = "none";
        } else {
            elementsToBlur[i].classList.remove("blurred");
            elementsToBlur[i].style.pointerEvents = "auto";
        }
    }
}


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

// Apply blur effect when the page loads based on the initial state of registerForm
document.addEventListener("DOMContentLoaded", function () {
    applyBlurEffect(document.getElementById("registerForm").style.display === "block");
});
