package com.codegnan;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AddSubjectServlet")
public class AddSubjectServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String subjectName = request.getParameter("subject");
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/quiz", "root", "harivinnu@143");

            PreparedStatement pst = con.prepareStatement("INSERT INTO subjects(name) VALUES (?)");
            pst.setString(1, subjectName);
            int rowCount = pst.executeUpdate();

            con.close();

            // Redirect back to manage_subjects.jsp
            response.sendRedirect("manage_subjects.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
        }
    }
}
