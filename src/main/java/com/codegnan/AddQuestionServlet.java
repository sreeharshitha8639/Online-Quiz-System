package com.codegnan;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/AddQuestionServlet")
public class AddQuestionServlet extends HttpServlet {
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        String subject = req.getParameter("subject");
        String question = req.getParameter("question");
        String option1 = req.getParameter("option1");
        String option2 = req.getParameter("option2");
        String option3 = req.getParameter("option3");
        String option4 = req.getParameter("option4");
        int answer = Integer.parseInt(req.getParameter("answer"));

        try {
            String dbUrl = System.getenv("DB_URL") != null 
                ? System.getenv("DB_URL") 
                : "jdbc:mysql://localhost:3306/quiz";
            String dbUser = System.getenv("DB_USERNAME") != null 
                ? System.getenv("DB_USERNAME") 
                : "root";
            String dbPass = System.getenv("DB_PASSWORD") != null 
                ? System.getenv("DB_PASSWORD") 
                : "harivinnu@143";
            
            Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
            
            String sql = "INSERT INTO questions(subject, question, option1, option2, option3, option4, answer) VALUES(?,?,?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, subject);
            ps.setString(2, question);
            ps.setString(3, option1);
            ps.setString(4, option2);
            ps.setString(5, option3);
            ps.setString(6, option4);
            ps.setInt(7, answer);
            
            ps.executeUpdate();
            res.sendRedirect("view_questions.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            res.getWriter().println("Error: " + e.getMessage());
        }
    }
}
