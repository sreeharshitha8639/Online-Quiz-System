<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Logout Page</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
           background-color: pink;
        }
        .container {
            text-align: center;
            background-color: white;
            padding: 30px 50px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            border-radius: 10px;
        }
        a {
            display: inline-block;
            margin-top: 15px;
            text-decoration: none;
            color: #0066cc;
            font-weight: bold;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>You have been logged out successfully!!</h2>
        <a href="login.jsp">Log In</a>
    </div>
</body>
</html>
