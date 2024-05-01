<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>College Website</title>
    <link rel="stylesheet" href="c.css">
    <style>
        /* Highlighted row styles */
        .highlight {
            background-color: #ffc107; /* Yellow background color */
        }

        /* Responsive design */
        @media screen and (max-width: 600px) {
            table {
                width: 100%;
            }
            table, th, td {
                border: 1px solid black;
                border-collapse: collapse;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Course Information</h1>
        <input type="text" id="searchInput" placeholder="Search by Student ID,Name">
        <table id="courseTable">
            <thead>
                <tr>
                    <th>Student ID</th>
                    <th>Student Name</th>
                    <th>Hours Assigned</th>
                    <th>GPA</th>
                    <th>Department Name</th>
                    <th>Department Code</th>
                    <th>Course 1</th>
                    <th>Course 2</th>
                    <th>Course 3</th>
                    <th>Course 4</th>
                    <th>Course 5</th>
                </tr>
            </thead>
            <tbody>
                <?php
                    // Establish a connection to the MySQL database
                    $servername = "localhost";
                    $username   = "root";
                    $password   = "217200";
                    $dbname     = "Cloud";
                    
                    // Create connection
                    $conn = new mysqli($servername, $username, $password, $dbname);
                    
                    // Check connection
                    if ($conn->connect_error) {
                        die("Connection failed: " . $conn->connect_error);
                    }
                    
                    // Execute the SQL query
                    $sql = "SELECT 
                                S.student_id,
                                CONCAT(S.first_name, ' ', S.last_name) AS student_name,
                                S.hours_assigned,
                                S.c_gpa,
                                D.department_name,
                                D.department_code,
                                MAX(CASE WHEN C.rn = 1 THEN C.course_name END) AS course_1,
                                MAX(CASE WHEN C.rn = 2 THEN C.course_name END) AS course_2,
                                MAX(CASE WHEN C.rn = 3 THEN C.course_name END) AS course_3,
                                MAX(CASE WHEN C.rn = 4 THEN C.course_name END) AS course_4,
                                MAX(CASE WHEN C.rn = 5 THEN C.course_name END) AS course_5
                            FROM 
                                students S
                            JOIN 
                                departments D ON S.department_code = D.department_code
                            LEFT JOIN (
                                SELECT 
                                    e.student_id,
                                    c.course_name,
                                    ROW_NUMBER() OVER (PARTITION BY e.student_id ORDER BY c.course_name) AS rn
                                FROM 
                                    enrollment e
                                JOIN 
                                    courses c ON e.course_code = c.course_code
                            ) AS C ON S.student_id = C.student_id
                            GROUP BY 
                                S.student_id, S.first_name, S.last_name, S.hours_assigned, S.c_gpa, D.department_name, D.department_code";
                    $result = $conn->query($sql);
                    
                    // Check if there are any results
                    if ($result->num_rows > 0) {
                        // Output data of each row
                        while($row = $result->fetch_assoc()) {
                            echo "<tr>";
                            echo "<td>" . $row["student_id"] . "</td>";
                            echo "<td>" . $row["student_name"] . "</td>";
                            echo "<td>" . $row["hours_assigned"] . "</td>";
                            echo "<td>" . $row["c_gpa"] . "</td>";
                            echo "<td>" . $row["department_name"] . "</td>";
                            echo "<td>" . $row["department_code"] . "</td>";
                            // Display "none" for empty course names
                            echo "<td>" . ($row["course_1"] ? $row["course_1"] : "none") . "</td>";
                            echo "<td>" . ($row["course_2"] ? $row["course_2"] : "none") . "</td>";
                            echo "<td>" . ($row["course_3"] ? $row["course_3"] : "none") . "</td>";
                            echo "<td>" . ($row["course_4"] ? $row["course_4"] : "none") . "</td>";
                            echo "<td>" . ($row["course_5"] ? $row["course_5"] : "none") . "</td>";
                            echo "</tr>";
                        }
                    } else {
                        echo "<tr><td colspan='11'>0 results</td></tr>";
                    }
                    
                    // Close the connection
                    $conn->close();
                ?>
            </tbody>
        </table>
        <p id="noResults" style="display: none;">No results found</p>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // Get all table rows
            const rows = document.querySelectorAll('#courseTable tbody tr');

            // Add click event listener to each row
            rows.forEach(row => {
                row.addEventListener('click', () => {
                    // Toggle highlight class on the clicked row
                    row.classList.toggle('highlight');
                });
            });

            // Search functionality
            const searchInput = document.getElementById('searchInput');
            const noResults = document.getElementById('noResults');

            searchInput.addEventListener('input', function() {
                const searchTerm = this.value.trim().toLowerCase();

                rows.forEach(row => {
                    const studentID = row.cells[0].textContent.trim().toLowerCase();
                    const studentName = row.cells[1].textContent.trim().toLowerCase();

                    if (studentID.includes(searchTerm) || studentName.includes(searchTerm)) {
                        row.style.display = '';
                        noResults.style.display = 'none';
                    } else {
                        row.style.display = 'none';
                        noResults.style.display = '';
                    }
                });
            });
        });
    </script>
</body>
</html>
