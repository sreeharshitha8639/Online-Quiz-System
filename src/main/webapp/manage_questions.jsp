<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Questions</title>
    <style>
        body { font-family: Arial; background: #f9f9f9; padding: 20px; }
        table { border-collapse: collapse; width: 90%; margin: auto; background: white; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: center; }
        th { background-color: #4CAF50; color: white; }
        a { color: red; text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>
    <h2 style="text-align:center;">All Quiz Questions</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Subject</th>
            <th>Question</th>
            <th>Answer</th>
            <th>Action</th>
        </tr>

<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

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

        con = DriverManager.getConnection(dbUrl, dbUser, dbPass);

        String sql = "SELECT id, subject, question, answer FROM questions ORDER BY id DESC";
        ps = con.prepareStatement(sql);
        rs = ps.executeQuery();

        while (rs.next()) {
%>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("subject") %></td>
            <td><%= rs.getString("question") %></td>
            <td><%= rs.getString("answer") %></td>
            <td>
                <a href="DeleteQuestionServlet?id=<%= rs.getInt("id") %>" 
                   onclick="return confirm('Are you sure you want to delete this question?');">
                    Delete
                </a>
            </td>
        </tr>
<%
        }
    } catch (Exception e) {
%>
        <tr>
            <td colspan="5" style="color:red;">Error loading questions: <%= e.getMessage() %></td>
        </tr>
<%
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (con != null) con.close(); } catch (Exception e) {}
    }
%>
    </table>
</body>
</html>
