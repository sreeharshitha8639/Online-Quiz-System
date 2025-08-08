<%@ page import="java.util.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>  
    <meta charset="UTF-8">
    <title>Create Quiz</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f2f5f9;
            padding: 40px;
        }
        h2 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 30px;
        }
        form {
            background: #fff;
            padding: 25px;
            border-radius: 10px;
            max-width: 600px;
            margin: 0 auto 40px auto;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-top: 8px;
            margin-bottom: 16px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }
        label {
            font-weight: bold;
            color: #333;
        }
        input[type="submit"] {
            background-color: #3498db;
            color: white;
            font-weight: bold;
            border: none;
            padding: 12px 20px;
            border-radius: 6px;
            cursor: pointer;
            width: 100%;
        }
        input[type="submit"]:hover {
            background-color: #2980b9;
        }
        .question-box {
            background-color: #ffffff;
            padding: 15px;
            border-left: 6px solid #2ecc71;
            margin: 10px auto;
            max-width: 600px;
            border-radius: 6px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            position: relative;
        }
        .delete-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 5px 10px;
            font-size: 12px;
            border-radius: 4px;
            cursor: pointer;
        }
        .no-questions {
            color: red;
            text-align: center;
            font-size: 16px;
        }
        hr {
            border: none;
            border-top: 1px solid #ccc;
            margin: 40px 0;
        }
    </style>
</head>
<body>

    <h2>Create Quiz </h2>

    <form action="CreateQuizServlet" method="post">
        <label>Subject:</label>
        <input type="text" name="subject" placeholder="Enter the Subject Name" required />

        <label>Question:</label>
        <input type="text" name="question" placeholder="Type your question" required />

        <label>Option A:</label>
        <input type="text" name="optionA" required />

        <label>Option B:</label>
        <input type="text" name="optionB" required />

        <label>Option C:</label>
        <input type="text" name="optionC" required />

        <label>Option D:</label>
        <input type="text" name="optionD" required />

        <label>Correct Option (A/B/C/D):</label>
        <input type="text" name="correct" placeholder="A, B, C, or D" required />

        <input type="submit" value="Add Question" />
    </form>

    <hr>

    <h2 style="margin-top: 0;">Current Quiz Questions</h2>
    <%
        List<String> questions = (List<String>) session.getAttribute("quiz");
        if (questions != null && !questions.isEmpty()) {
            for (int i = 0; i < questions.size(); i++) {
    %>
        <div class="question-box">
            <%= questions.get(i) %>
            <form action="DeleteQuizQuestionServlet" method="post" style="display:inline;">
                <input type="hidden" name="index" value="<%= i %>"/>
                <button type="submit" class="delete-btn">Delete</button>
            </form>
        </div>
    <%
            }
        } else {
    %>
        <p class="no-questions">No questions added yet.</p>
    <%
        }
    %>

</body>
</html>
