// Automatically fetch and display student data when the page loads
window.addEventListener('load', function () {
    fetch('http://localhost:3000/api/get-students')
        .then(response => response.json())
        .then(data => {
            let tableBody = document.getElementById('student-table').getElementsByTagName('tbody')[0];
            tableBody.innerHTML = ""; // Clear existing rows

            // Iterate over data and create rows dynamically
            data.students.forEach((student) => {
                let row = tableBody.insertRow();

                // Create Present checkbox
                let presentCell = row.insertCell();
                presentCell.innerHTML = `<input type="radio" name="attendance-${student.id}" value="P">`;

                // Create Absent checkbox
                let absentCell = row.insertCell();
                absentCell.innerHTML = `<input type="radio" name="attendance-${student.id}" value="A">`;

                // Insert student details
                row.insertCell().innerText = student.id;
                row.insertCell().innerText = student.number;
                row.insertCell().innerText = student.prefix;
                row.insertCell().innerText = student.first_name;
                row.insertCell().innerText = student.last_name;
                row.insertCell().innerText = student.section;
                row.insertCell().innerText = student.subject;
            });
        })
        .catch(error => {
            console.error('Error fetching student data:', error);
        });
});

// Event listener for the "Confirm" button
document.getElementById('confirm-btn').addEventListener('click', function () {
    let tableBody = document.getElementById('student-table').getElementsByTagName('tbody')[0];
    let rows = tableBody.getElementsByTagName('tr');

    let selectedStudents = [];

    // Collect selected attendance data
    Array.from(rows).forEach(row => {
        let studentId = row.cells[0].getElementsByTagName('input')[0].name.split('-')[1];
        let status = row.cells[0].getElementsByTagName('input')[0].checked ? 'P' :
            row.cells[1].getElementsByTagName('input')[0].checked ? 'A' : '';

        if (status) {
            selectedStudents.push({
                student_id: studentId,
                status: status
            });
        }
    });

    // Send the selected data to the server for insertion
    fetch('http://localhost:3000/api/insert-attendance', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ students: selectedStudents })
    })
    .then(response => response.json())
    .then(result => {
        alert(result.message);
    })
    .catch(error => {
        console.error('Error submitting attendance:', error);
    });
});

// Event listener for the "Clear" button
document.getElementById('clear-btn').addEventListener('click', function () {
    let radioButtons = document.querySelectorAll('input[type="radio"]');

    // Loop through all radio buttons and uncheck them
    radioButtons.forEach(function (radio) {
        radio.checked = false;
    });
});
