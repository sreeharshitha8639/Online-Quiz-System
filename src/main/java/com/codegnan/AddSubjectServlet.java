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
