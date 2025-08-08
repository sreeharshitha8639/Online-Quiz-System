<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%
    // Redirect to login if user is not logged in
    if (session.getAttribute("id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: violet;
            background: url('welcom image.png');
            background-size: cover;
            background-repeat: no-repeat;
            margin: 0;
            overflow: hidden;
            padding: 0;
        }
        .logout-btn {
            position: absolute;
            top: 20px;
            right: 30px;
            text-decoration: none;
            color: white;
            background-color: #dc3545;
            padding: 10px 20px;
            border-radius: 5px;
        }
        .logout-btn:hover {
            background-color: #c82333;
        }
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 90vh;
            margin-top:100px;
        }
        .welcome-box {
            background: white;
            padding: 40px 60px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }
        .welcome-box h2 {
            margin-bottom: 20px;
            color: #333;
        }
        .start-exam-btn {
            background-color: #28a745;
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            text-decoration: none;
        }
        .start-exam-btn:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

    <a href="logout.jsp" class="logout-btn">Logout</a>

    <div class="container">
        <div class="welcome-box">
            <h2>Welcome, <%= session.getAttribute("userName") %>!</h2>
            <p>You are now logged in to the Online Quiz System.</p>
            <br>
             <form action=SelectSubjectServlet method="post">
            <input type="submit" value="Start Exam" />
        </div>
    </div>

</body>
</html>
