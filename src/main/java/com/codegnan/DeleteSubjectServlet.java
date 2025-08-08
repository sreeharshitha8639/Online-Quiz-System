package com.codegnan;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DeleteSubjectServlet")
public class DeleteSubjectServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");
        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz", "root", "harivinnu@143");

            String sql = "DELETE FROM subjects WHERE id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(id));
            int rows = ps.executeUpdate();

            // Redirect to the same page after deletion
            response.sendRedirect("manage_subjects.jsp");

        } catch (Exception e) {
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}
