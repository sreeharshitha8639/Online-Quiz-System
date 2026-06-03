<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String subject = request.getParameter("subject");
    if (subject == null || subject.trim().equals("")) {
        response.sendRedirect("selectSubject.jsp");
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Quiz - <%= subject %></title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #74ebd5, #ACB6E5);
            margin: 0;
            padding: 0;
        }

        .quiz-container {
            max-width: 900px;
            margin: 50px auto;
            background: #ffffff;
            padding: 40px 30px;
            border-radius: 16px;
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.2);
            overflow-y: auto;
            max-height: 90vh;
        }

        h2 {
            text-align: center;
            color: #1a1a1a;
            margin-bottom: 30px;
        }

        .question-block {
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .question-block p {
            font-weight: 600;
            color: #222;
            margin-bottom: 10px;
        }

        label {
            display: block;
            margin: 6px 0;
            font-size: 15px;
            cursor: pointer;
            padding: 6px 10px;
            border-radius: 6px;
            transition: background-color 0.2s ease;
        }

        label:hover {
            background-color: #f1f1f1;
        }

        input[type="radio"] {
            margin-right: 10px;
        }

        input[type="submit"] {
            padding: 14px 28px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 18px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            display: block;
            margin: 30px auto 0;
        }

        input[type="submit"]:hover {
            background-color: #218838;
        }

        #timerBox {
            position: fixed;
            top: 20px;
            right: 30px;
            background-color: #343a40;
            color: #fff;
            padding: 12px 20px;
            border-radius: 10px;
            font-size: 18px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
            z-index: 1000;
        }

        .no-questions {
            color: #c00;
            text-align: center;
            font-weight: bold;
            font-size: 18px;
        }
    </style>
</head>
<body>

<!-- Timer -->
<div id="timerBox">
    ⏳ Time Left: <span id="timer">10:00</span>
</div>

<div class="quiz-container">
    <h2>Quiz on <%= subject %></h2>

<%
    try {
    	Class.forName("com.mysql.cj.jdbc.Driver");

        String dbUrl = System.getenv("DB_URL") != null
            ? System.getenv("DB_URL")
            : "jdbc:mysql://localhost:3306/quiz";
        String dbUser = System.getenv("DB_USERNAME") != null
            ? System.getenv("DB_USERNAME")
            : "root";
        String dbPass = System.getenv("DB_PASSWORD") != null
            ? System.getenv("DB_PASSWORD")
            : "harivinnu@123";

        con = DriverManager.getConnection(dbUrl, dbUser, dbPass);

        String sql = "SELECT * FROM questions WHERE subject = ?";
        ps = con.prepareStatement(sql);
        ps.setString(1, subject);
        rs = ps.executeQuery();

        boolean found = false;
%>
    <form action="SubmitQuizServlet" method="post" id="quizForm">
        <input type="hidden" name="subject" value="<%= subject %>">
<%
        int qNo = 1;
        while (rs.next()) {
            found = true;
            int qid = rs.getInt("id");
%>
        <div class="question-block">
            <p>Q<%= qNo++ %>: <%= rs.getString("question") %></p>
            <label><input type="radio" name="q<%= qid %>" value="1"> <%= rs.getString("option1") %></label>
            <label><input type="radio" name="q<%= qid %>" value="2"> <%= rs.getString("option2") %></label>
            <label><input type="radio" name="q<%= qid %>" value="3"> <%= rs.getString("option3") %></label>
            <label><input type="radio" name="q<%= qid %>" value="4"> <%= rs.getString("option4") %></label>
        </div>
<%
        }

        if (found) {
%>
        <input type="submit" value="Submit Quiz">
<%
        } else {
%>
        <p class="no-questions">No questions found for subject: <%= subject %></p>
<%
        }
%>
    </form>
<%
    } catch (Exception e) {
%>
    <p class="no-questions">Error: <%= e.getMessage() %></p>
<%
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (ps != null) try { ps.close(); } catch (Exception e) {}
        if (con != null) try { con.close(); } catch (Exception e) {}
    }
%>
</div>

<!-- Timer & Auto-submit -->
<script>
    window.onload = function () {
        let duration = 10 * 60; // 10 minutes
        const display = document.getElementById("timer");
        const quizForm = document.getElementById("quizForm");
        let submitted = false;

        function updateTimer() {
            const minutes = Math.floor(duration / 60);
            const seconds = duration % 60;
            display.textContent = 
                (minutes < 10 ? "0" + minutes : minutes) + ":" + 
                (seconds < 10 ? "0" + seconds : seconds);
        }

        const timerInterval = setInterval(() => {
            if (duration <= 0) {
                clearInterval(timerInterval);
                submitIfNotSubmitted("⏰ Time's up! Submitting your quiz.");
            } else {
                updateTimer();
                duration--;
            }
        }, 1000);

        function submitIfNotSubmitted(msg) {
            if (!submitted) {
                submitted = true;
                if (msg) alert(msg);
                quizForm.submit();
            }
        }

        // Submit on reload or close
        window.addEventListener("beforeunload", function (e) {
            submitIfNotSubmitted();
        });

        // Submit on back button
        history.pushState(null, null, location.href);
        window.onpopstate = function () {
            submitIfNotSubmitted("🚫 Back navigation detected. Submitting quiz.");
        };

        // Submit on tab switch
        document.addEventListener("visibilitychange", function () {
            if (document.visibilityState === "hidden") {
                submitIfNotSubmitted("🚨 Tab switch detected. Submitting quiz.");
            }
        });
    };
</script>

</body>
</html>
