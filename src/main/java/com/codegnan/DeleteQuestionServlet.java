package com.codegnan;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DeleteQuestionServlet")
public class DeleteQuestionServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String idStr = request.getParameter("id");

        try {
            int id = Integer.parseInt(idStr);

            Class.forName("com.mysql.cj.jdbc.Driver");
            String dbUrl = System.getenv("DB_URL") != null ? System.getenv("DB_URL") : "jdbc:mysql://localhost:3306/quiz";
            String dbUser = System.getenv("DB_USERNAME") != null ? System.getenv("DB_USERNAME") : "root";
            String dbPass = System.getenv("DB_PASSWORD") != null ? System.getenv("DB_PASSWORD") : "harivinnu@143";
            Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPass);

            PreparedStatement ps = con.prepareStatement("DELETE FROM questions WHERE id = ?");
            ps.setInt(1, id);
            ps.executeUpdate();

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("manage_questions.jsp"); // Redirect to question list
    }
}
