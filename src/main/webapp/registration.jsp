<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registration Form</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-image: url("registration.png");
            background-size: cover;
            background-position: center;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .form-table {
            background: rgba(255, 255, 255, 0.1); 
            border: 1px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            backdrop-filter: blur(15px);
            border-radius: 15px;
            padding: 40px;
            width: 380px;
            color: black;
        }

        table {
            width: 100%;
        }

        td {
            padding: 10px;
        }

        input[type="text"], input[type="password"], select {
            width: 100%;
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .register-btn {
            width: 100%;
            padding: 10px;
            background-color: #28a745;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        .register-btn:hover {
            background-color: #218838;
        }

        .login-link {
            text-align: center;
            margin-top: 15px;
            color: purple;
            display: block;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .message {
            text-align: center;
            color: red;
            margin-bottom: 10px;
        }

        .success-message {
            text-align: center;
            color: green;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="form-table">
        <h2>Register Here</h2>

        <!-- JSP Scriptlet for message display -->
        <%
            String message = (String) request.getAttribute("message");
            if (message != null) {
                if ("Registration successful!".equals(message)) {
        %>
                    <div class="success-message"><%= message %></div>
        <%
                } else {
        %>
                    <div class="message"><%= message %></div>
        <%
                }
            }
        %>

        <form action="RegisterServlet" method="post">
            <table>
                <tr>
                    <td>Email-ID:</td>
                    <td>
                        <input type="text" name="email" required
                               pattern="^[a-zA-Z0-9._%+-]+@gmail\\.com$"
                               title="Email must end with @gmail.com">
                    </td>
                </tr>
                <tr>
                    <td>Password:</td>
                    <td>
                        <input type="password" name="password" required
                               pattern="^[a-zA-Z]+$|^[0-9]+$"
                               title="Password must contain only letters or only numbers (no mix)">
                    </td>
                </tr>
                <tr>
                    <td>Name:</td>
                    <td><input type="text" name="name" required></td>
                </tr>
                <tr>
                    <td>Mobile:</td>
                    <td>
                        <input type="text" name="mobile" required
                               pattern="^[0-9]{10}$"
                               title="Mobile number must be exactly 10 digits">
                    </td>
                </tr>
                <tr>
                    <td>Role:</td>
                    <td>
                        <select name="role" required>
                            <option value="">--Select Role--</option>
                            <option value="user">User</option>
                            <option value="admin">Admin</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <button type="submit" class="register-btn">Register</button>
                    </td>
                </tr>
            </table>
        </form>
        <a href="login.jsp" class="login-link">Already registered? Login here</a>
    </div>
</body>
</html>
