package com.codegnan;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteSubjectServlet")
public class DeleteSubjectServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, 
                         HttpServletResponse response) 
                         throws ServletException, IOException {

        String id = request.getParameter("id");
        Connection con = null;
        PreparedStatement ps = null;

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

            String sql = "DELETE FROM subjects WHERE id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(id));
            ps.executeUpdate();

            response.sendRedirect("manage_subjects.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}