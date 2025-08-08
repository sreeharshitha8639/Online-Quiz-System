<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String role = request.getParameter("role");
    if (role != null) {
        if ("admin".equals(role)) {
            response.sendRedirect("admin_login.jsp");
            return;
        } else if ("user".equals(role)) {
            response.sendRedirect("login.jsp");
            return;
        } else {
%>
            <p style="color:red; text-align:center;">Invalid role selected!</p>
<%
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Select Role</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f7f9fb;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background: white;
            padding: 40px 60px;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
            text-align: center;
        }
        h2 {
            margin-bottom: 20px;
        }
        select, input[type="submit"] {
            padding: 12px;
            font-size: 16px;
            width: 100%;
            margin-top: 15px;
            border-radius: 8px;
            border: 1px solid #ccc;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Select Your Role to Login</h2>
    <form method="post" action="">
        <select name="role" required>
            <option value="">-- Choose Role --</option>
            <option value="user">User</option>
            <option value="admin">Admin</option>
        </select>
        <input type="submit" value="Continue">
    </form>
</div>

</body>
</html>
