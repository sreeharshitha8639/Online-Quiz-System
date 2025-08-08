<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Question</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #43cea2, #185a9d);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .form-container {
            background-color: #ffffff;
            padding: 40px 50px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 500px;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #333;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #444;
        }

        select, input[type="text"], input[type="number"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 18px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
        }

        input[type="submit"] {
            width: 100%;
            background-color: #007bff;
            color: white;
            border: none;
            padding: 12px;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .dropdown {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<div class="form-container">
    <form action="AddQuestionServlet" method="post">

        <div class="dropdown">
            <label for="subject">Subject:</label>
            <select name="subject" id="subject" required>
                <option value="">-- Select Subject --</option>
<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz", "root", "harivinnu@143");

        String sql = "SELECT name FROM subjects ORDER BY name";
        ps = con.prepareStatement(sql);
        rs = ps.executeQuery();

        while (rs.next()) {
            String subjectName = rs.getString("name");
%>
                <option value="<%= subjectName %>"><%= subjectName %></option>
<%
        }
    } catch (Exception e) {
%>
                <option disabled>Error: <%= e.getMessage() %></option>
<%
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (ps != null) try { ps.close(); } catch (Exception e) {}
        if (con != null) try { con.close(); } catch (Exception e) {}
    }
%>
            </select>
        </div>

        <h2>Add New Question</h2>

        <label for="question">Question:</label>
        <input type="text" name="question" id="question" required>

        <label>Option 1:</label>
        <input type="text" name="option1" required>

        <label>Option 2:</label>
        <input type="text" name="option2" required>

        <label>Option 3:</label>
        <input type="text" name="option3" required>

        <label>Option 4:</label>
        <input type="text" name="option4" required>

        <label>Answer (1-4):</label>
        <input type="number" name="answer" min="1" max="4" required>

        <input type="submit" value="Add Question">
    </form>
</div>

</body>
</html>
