<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(to right, #74ebd5, #9face6);
            font-family: 'Segoe UI', sans-serif;
        }

        .dashboard-container {
            max-width: 600px;
            margin: 100px auto;
            background-color: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        h2 {
            color: #333;
            margin-bottom: 30px;
        }

        a {
            display: block;
            margin: 15px 0;
            text-decoration: none;
            font-size: 18px;
            padding: 10px 20px;
            border-radius: 8px;
            background-color: #007bff;
            color: white;
            transition: background 0.3s;
        }

        a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="dashboard-container">
    <h2>Welcome, Admin 👨‍💼</h2>
    
    <a href="add_questions.jsp">➕ Add Quiz Question</a>
    <a href="view_questions.jsp">📋 View Questions</a>
    <a href="manage_subjects.jsp">🗂️ Manage Subjects</a>
    <a href="create_quiz.jsp">📝 Create Quiz Questions</a>
    <a href="logout.jsp">🚪 Logout</a>
</div>

</body>
</html>
