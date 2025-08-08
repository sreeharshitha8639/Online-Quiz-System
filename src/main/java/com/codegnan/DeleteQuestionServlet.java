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
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz", "root", "harivinnu@143");

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
