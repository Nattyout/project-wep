document.getElementById('login-btn').addEventListener('click', function() {
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;
    const errorMessage = document.getElementById('error-message');

    fetch('http://localhost:3000/api/login', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ username, password })
    })
    .then(response => response.json())
    .then(data => {
        if (data.message === 'Login successful') {
            window.location.href = 'attendance.html';  // Redirect to attendance page
        } else {
            errorMessage.textContent = data.message;  // Display error message
        }
    })
    .catch(error => {
        console.error('Error:', error);
        errorMessage.textContent = 'An error occurred during login';
    });
});
/* JavaScript for Back Button*/
function goBack() {
    window.history.back();
}
