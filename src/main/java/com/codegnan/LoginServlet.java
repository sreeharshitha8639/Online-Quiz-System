package com.codegnan;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("id"); // from form input
        String password = request.getParameter("password");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Load driver & connect
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz", "root", "harivinnu@143");

            
            
            // Admin login check (hardcoded)
            if (email.equals("admin@quiz.com") && password.equals("admin123")) {
                HttpSession session = request.getSession();
                session.setAttribute("id", email);
                session.setAttribute("role", "admin");
                response.sendRedirect("admin_login.jsp");
                return;
            }

            // Regular user login
            String sql = "SELECT name, password FROM users WHERE emailid = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, email);
            rs = ps.executeQuery();

            if (rs.next()) {
                String dbPassword = rs.getString("password");
                String name = rs.getString("name");

                if (dbPassword.equals(password)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("id", email);
                    session.setAttribute("userName", name);
                    session.setAttribute("role", "user");
                    response.sendRedirect("welcome.jsp");
                } else {
                    request.setAttribute("errorMessage", "Invalid email or password.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("msg", "User not registered. Please register first.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Internal server error: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
