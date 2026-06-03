<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("admin_login.jsp");
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>
<html>
<head><title>View Questions</title></head>
<body>
    <h2>All Quiz Questions</h2>
    <table border="1">
        <tr>
            <th>ID</th><th>Subject</th><th>Question</th><th>Answer</th><th>Action</th>
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

        con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
        ps = con.prepareStatement("SELECT * FROM questions");
        rs = ps.executeQuery();

        while (rs.next()) {
%>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("subject") %></td>
            <td><%= rs.getString("question") %></td>
            <td><%= rs.getInt("answer") %></td>
            <td><a href="DeleteQuestionServlet?id=<%= rs.getInt("id") %>">Delete</a></td>
        </tr>
<%
        }
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
    </table>
</body>
</html>
