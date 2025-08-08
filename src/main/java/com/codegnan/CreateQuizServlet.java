package com.codegnan;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/CreateQuizServlet")
public class CreateQuizServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String subject = request.getParameter("subject");
        String question = request.getParameter("question");
        String optionA = request.getParameter("optionA");
        String optionB = request.getParameter("optionB");
        String optionC = request.getParameter("optionC");
        String optionD = request.getParameter("optionD");
        String correct = request.getParameter("correct");

        String fullQuestion = "Subject: " + subject + " | Q: " + question +
                " | A: " + optionA + " | B: " + optionB +
                " | C: " + optionC + " | D: " + optionD +
                " | Correct: " + correct;

        HttpSession session = request.getSession();
        List<String> quiz = (List<String>) session.getAttribute("quiz");

        if (quiz == null) {
            quiz = new ArrayList<>();
        }

        quiz.add(fullQuestion);
        session.setAttribute("quiz", quiz);

        response.sendRedirect("create_quiz.jsp");
    }
}
