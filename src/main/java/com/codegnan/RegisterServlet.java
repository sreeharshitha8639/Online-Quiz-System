package com.codegnan;

import java.io.IOException;
import java.sql.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String mobile = request.getParameter("mobile");

        // Input validations
        if (!email.endsWith("@gmail.com")) {
            request.setAttribute("message", "Email must end with '@gmail.com'");
        } else if (!mobile.matches("\\d{10}")) {
            request.setAttribute("message", "Mobile number must be exactly 10 digits.");
        } else if (!(password.matches("[a-zA-Z]+") || password.matches("\\d+"))) {
            request.setAttribute("message", "Password must contain only letters or only numbers (not both).");
        }

        if (request.getAttribute("message") != null) {
            RequestDispatcher rd = request.getRequestDispatcher("registration.jsp");
            rd.forward(request, response);
            return;
        }

        Connection conn = null;
        PreparedStatement checkStmt = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz", "root", "harivinnu@143");

            checkStmt = conn.prepareStatement("SELECT * FROM users WHERE emailid = ?");
            checkStmt.setString(1, email);
            rs = checkStmt.executeQuery();

            if (rs.next()) {
                request.setAttribute("message", "User already registered. Please login.");
                RequestDispatcher rd = request.getRequestDispatcher("registration.jsp");
                rd.forward(request, response);
            } else {
                pst = conn.prepareStatement("INSERT INTO users(emailid, password, name, phone) VALUES (?, ?, ?, ?)");
                pst.setString(1, email);
                pst.setString(2, password);
                pst.setString(3, name);
                pst.setString(4, mobile);

                int rowCount = pst.executeUpdate();
                if (rowCount > 0) {
                    request.setAttribute("message", "Registration successful. Please login.");
                    RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                    rd.forward(request, response);
                } else {
                    request.setAttribute("message", "Registration failed. Please try again.");
                    RequestDispatcher rd = request.getRequestDispatcher("registration.jsp");
                    rd.forward(request, response);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error occurred: " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("registration.jsp");
            rd.forward(request, response);
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (checkStmt != null) checkStmt.close(); } catch (Exception e) {}
            try { if (pst != null) pst.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
