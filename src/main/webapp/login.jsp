<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String msg = (String) request.getAttribute("message");
    if (msg != null) {
%>
    <div style="color: green; text-align: center; margin-bottom: 30px;">
        <%= msg %>
    </div>
<%
    }
%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Login</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: url('background.jpg');
            background-size: cover;
        }

        .login-box {
            background: rgba(255, 255, 255, 0.1); 
            border: 1px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            border-radius: 15px;
            padding: 40px;
            width: 350px;
            margin: 100px auto;
            color: #fff;
        }

        .login-box h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #fff;
        }

        .login-box input[type="text"],
        .login-box input[type="password"] {
            width: 100%;
            padding: 12px;
            margin: 10px 0 20px;
            border: none;
            border-radius: 5px;
            background: rgba(255,255,255,0.2);
            color: #fff;
            font-size: 16px;
        }

        .login-box input::placeholder {
            color: #ddd;
        }

        .login-box button {
            width: 100%;
            padding: 12px;
            background-color: #ffc107;
            border: none;
            border-radius: 5px;
            color: black;
            font-size: 16px;
            cursor: pointer;
        }

        .login-box button:hover {
            background-color: #e0a800;
        }

        .login-box .link {
            text-align: center;
            margin-top: 15px;
        }

        .login-box .link a {
            color: #ffc107;
            text-decoration: none;
        }
    </style>
</head>
<body>
   
<div class="login-box">
    <h2>Student Login</h2>
     <!-- Show error message -->
   <%

    String errorMsg = (String) request.getAttribute("errorMessage");
    if (errorMsg != null) {
%>
    <div style="color: red; text-align: center; margin-bottom: 10px;">
        <%= errorMsg %>
    </div>
<%
    }
%>
    <form action="LoginServlet" method="post">
        <input type="text" name="id" placeholder="Email Id" required>
        <input type="password" name="password" placeholder="Password" required>
        
        <button type="submit">Login</button>
        <div class="link">
            <p><a href="registration.jsp">Don't have an account?</a></p>
        </div>
    </form>
</div>
</body>
</html>
