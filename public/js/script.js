document.getElementById('search-btn').addEventListener('click', function () { 
    let studentId = document.getElementById('student-id').value;
    if (!studentId || isNaN(studentId)) {
        document.getElementById('error-message').textContent = 'Please enter a valid student ID.';
        return;
    }
    searchStudent(studentId);
});

function searchStudent(studentId) {
    const errorMessage = document.getElementById('error-message');
    const studentDetailsDiv = document.getElementById('student-details');
    const tableBody = document.getElementById('search-table').getElementsByTagName('tbody')[0];

    errorMessage.textContent = '';
    studentDetailsDiv.innerHTML = '';
    tableBody.innerHTML = '';  // Clear existing table rows

    // Fetch attendance data for the calendar
    fetch(`http://localhost:3000/api/get-attendance?student_id=${studentId}`)
        .then(response => response.json())
        .then(data => {
            if (data.message) {
                errorMessage.textContent = data.message;
            } else {
                renderCalendar(data);
            }
        })
        .catch(error => {
            console.error('Error fetching attendance data:', error);
            errorMessage.textContent = 'An error occurred while fetching attendance data.';
        });

    // Fetch student details and populate the table
    fetch(`http://localhost:3000/api/search-student?student_id=${studentId}`)
        .then(response => response.json())
        .then(data => {
            if (data.message) {
                errorMessage.textContent = data.message;
            } else {
                // Display student details if available
                if (data.length > 0) {
                    const student = data[0];
                    studentDetailsDiv.innerHTML = `
                        <p><strong>Student ID:</strong> ${student.student_id}</p>
                        <p><strong>Number:</strong> ${student.number}</p>
                        <p><strong>Name:</strong> ${student.prefix} ${student.first_name} ${student.last_name}</p>
                        <p><strong>Subject:</strong> ${student.subject}</p>
                    `;
                }

                // Populate the table rows
                data.forEach((record) => {
                    let row = tableBody.insertRow();
                    row.id = `row-${record.id}`;
                
                    row.insertCell().innerText = record.id;
                    row.insertCell().innerText = record.student_id;
                    row.insertCell().innerText = record.number;
                    row.insertCell().innerText = record.prefix;
                    row.insertCell().innerText = record.first_name;
                    row.insertCell().innerText = record.last_name;
                    row.insertCell().innerText = record.subject;
                    row.insertCell().innerText = new Date(record.active_date).toLocaleDateString();
                    row.insertCell().innerText = record.status;
                
                    // Edit button column
                    let editCell = row.insertCell();
                    let editButton = document.createElement("button");
                    editButton.innerText = "Edit";
                    editButton.classList.add("btn", "button-35");
                    editButton.onclick = () => editStudent(record.id, record.student_id);
                    editCell.appendChild(editButton);
                
                    // Delete button column
                    let deleteCell = row.insertCell();
                    let deleteButton = document.createElement("button");
                    deleteButton.innerText = "Delete";
                    deleteButton.classList.add("btn", "button-40");
                    deleteButton.onclick = () => deleteStudent(record.id, record.student_id);
                    deleteCell.appendChild(deleteButton);
                });
            }
        })
        .catch(error => {
            console.error('Error fetching student data:', error);
            errorMessage.textContent = 'An error occurred while searching for the student.';
        });
}

// Edit student function - updates row status and refreshes data
function editStudent(rowId, studentId) {
    const newStatus = prompt("Enter new status (P for Present, A for Absent):");
    if (newStatus) {
        fetch(`http://localhost:3000/api/edit-student`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ id: rowId, status: newStatus })
        })
        .then(response => response.json())
        .then(data => {
            alert(data.message);
            searchStudent(studentId);
        })
        .catch(error => console.error('Error updating student:', error));
    }
}

// Delete student function - removes row and refreshes data
function deleteStudent(rowId, studentId) {
    if (confirm("Are you sure you want to delete this student?")) {
        fetch(`http://localhost:3000/api/delete-student?id=${rowId}`, {
            method: 'DELETE'
        })
        .then(response => response.json())
        .then(data => {
            alert(data.message);
            searchStudent(studentId);
        })
        .catch(error => console.error('Error deleting student:', error));
    }
}

// Function to render calendar with color-coded attendance
function renderCalendar(attendanceData) {
    let calendarEl = document.getElementById('calendar');

    let events = attendanceData.map(entry => {
        let trimmedStatus = entry.status.trim();
        let statusTitle = trimmedStatus === 'P' ? 'Present' : 'Absent';
        let colorCode = trimmedStatus === 'P' ? 'green' : 'red';

        return {
            title: statusTitle,
            start: new Date(entry.active_date),
            color: colorCode,
            allDay: false
        };
    });

    let calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        events: events,
        eventDisplay: 'block',
        timeZone: 'local',
        height: 'auto'
    });

    calendar.render();
}
