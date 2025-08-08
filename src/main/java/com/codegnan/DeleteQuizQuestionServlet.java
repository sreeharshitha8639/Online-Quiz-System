package com.codegnan;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DeleteQuizQuestionServlet")
public class DeleteQuizQuestionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession();
        List<String> quiz = (List<String>) session.getAttribute("quiz");

        String indexStr = request.getParameter("index");
        if (quiz != null && indexStr != null) {
            try {
                int index = Integer.parseInt(indexStr);
                if (index >= 0 && index < quiz.size()) {
                    quiz.remove(index);
                    session.setAttribute("quiz", quiz);
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect("create_quiz.jsp");
    }
}

