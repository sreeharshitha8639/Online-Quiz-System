<!DOCTYPE html>
<html>
<head>
    <title>Select Subject</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background :url('startExam.png');
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            overflow:hidden;
        }
        .box {
            background-color: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            text-align: center;
        }
        select, input[type="submit"] {
            padding: 10px;
            margin-top: 15px;
            font-size: 16px;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="box">
    <h2>Select Subject to Start Exam</h2>
    <form action="quiz.jsp" method="post">
        <select name="subject" required>
            <option value="">--Select Subject--</option>
            <option value="Java">Java</option>
            <option value="Python">Python</option>
            <option value="MySQL">MySQL</option>
            <option value="C">C</option>
            <option value="C++">C++</option>
        </select><br>
        <input type="submit" value="Proceed to Exam">
    </form>
</div>
</body>
</html>
