package com.codegnan;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/SubmitQuizServlet")
public class SubmitQuizServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String subject = request.getParameter("subject");
        int total = 0, correct = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/quiz", "root", "harivinnu@143");

            String sql = "SELECT id, correct_answer FROM questions WHERE subject = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, subject);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                total++;
                int qid = rs.getInt("id");
                int correctAnswer = rs.getInt("correct_answer");

                String userAnswer = request.getParameter("q" + qid);
                if (userAnswer != null && Integer.parseInt(userAnswer) == correctAnswer) {
                    correct++;
                }
            }

            rs.close();
            ps.close();
            con.close();

            request.setAttribute("subject", subject);
            request.setAttribute("total", total);
            request.setAttribute("correct", correct);

            request.getRequestDispatcher("result.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        }
    }
}
