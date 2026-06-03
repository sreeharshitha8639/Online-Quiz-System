<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Subjects</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            padding: 30px;
        }
        h2 {
            text-align: center;
            color: #2c3e50;
        }
        form {
            background: #fff;
            padding: 20px;
            margin: 0 auto 30px auto;
            max-width: 400px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0 20px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            background: #27ae60;
            color: white;
            padding: 10px;
            width: 100%;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        table {
            width: 80%;
            margin: auto;
            border-collapse: collapse;
            background: white;
        }
        th, td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ccc;
        }
        th {
            background: #2c3e50;
            color: white;
        }
        a.delete-link {
            color: red;
            text-decoration: none;
            font-weight: bold;
        }
        a.delete-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<h2>Manage Subjects</h2>

<form action="AddSubjectServlet" method="post">
    <input type="text" name="subject" placeholder="Enter Subject Name" required>
    <input type="submit" value="Add Subject">
</form>

<h2>Available Subjects</h2>
<table>
    <tr>
        <th>Subject Name</th>
        <th>Action</th>
    </tr>
<%
    try {
    	Class.forName("com.mysql.cj.jdbc.Driver");

    	String dbUrl = System.getenv("DB_URL") != null 
    	    ? System.getenv("DB_URL") 
    	    : "jdbc:mysql://localhost:3306/quiz";
    	String dbUser = System.getenv("DB_USERNAME") != null 
    	    ? System.getenv("DB_USERNAME") 
    	    : "root";
    	String dbPass = System.getenv("DB_PASSWORD") != null 
    	    ? System.getenv("DB_PASSWORD") 
    	    : "harivinnu@123";
    	Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM subjects");

        while (rs.next()) {
            int id = rs.getInt("id");
            String name = rs.getString("name");
%>
    <tr>
        <td><%= name %></td>
        <td>
            <a class="delete-link" href="DeleteSubjectServlet?id=<%= id %>" onclick="return confirm('Are you sure you want to delete this subject?');">
                Delete
            </a>
        </td>
    </tr>
<%
        }
        con.close();
    } catch (Exception e) {
        out.println("<tr><td colspan='2'>Error: " + e.getMessage() + "</td></tr>");
    }
%>
</table>

</body>
</html>
