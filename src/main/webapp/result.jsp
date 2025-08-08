<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String subject = (String) request.getAttribute("subject");
    int totalQuestions = (Integer) request.getAttribute("total");
    int correct = (Integer) request.getAttribute("correct");
    int incorrect = totalQuestions - correct;
    int scorePercent = totalQuestions > 0 ? (correct * 100 / totalQuestions) : 0;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Quiz Result</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f9ff;
            color: #333;
            margin: 0;
            padding: 0;
        }
        .result-box {
            max-width: 700px;
            margin: 60px auto;
            background: #ffffff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        h2 {
            color: #0066cc;
            margin-bottom: 20px;
        }
        .result-details {
            font-size: 18px;
            margin: 10px 0;
        }
        .score {
            font-size: 24px;
            font-weight: bold;
            margin-top: 20px;
            color: #28a745;
        }
        .btn {
            display: inline-block;
            margin-top: 25px;
            padding: 10px 20px;
            font-size: 16px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            transition: background 0.3s ease;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        #chartContainer {
            max-width: 400px;
            margin: 30px auto;
        }
    </style>
</head>
<body>

<div class="result-box">
    <h2>Quiz Result</h2>
    <div class="result-details">📘 <strong>Subject:</strong> <%= subject %></div>
    <div class="result-details">❓ <strong>Total Questions:</strong> <%= totalQuestions %></div>
    <div class="result-details">✅ <strong>Correct Answers:</strong> <%= correct %></div>
    <div class="result-details">❌ <strong>Incorrect Answers:</strong> <%= incorrect %></div>
    <div class="score">🎯 Your Score: <%= scorePercent %>%</div>

    <!-- 🎯 Pie Chart -->
    <div id="chartContainer">
        <canvas id="resultChart"></canvas>
    </div>

    <a class="btn" href="selectSubject.jsp">Take Another Quiz</a>
</div>

<script>
    const ctx = document.getElementById('resultChart').getContext('2d');
    new Chart(ctx, {
        type: 'pie',
        data: {
            labels: ['Correct', 'Incorrect'],
            datasets: [{
                data: [<%= correct %>, <%= incorrect %>],
                backgroundColor: ['#28a745', '#dc3545'],
                borderColor: ['#fff', '#fff'],
                borderWidth: 1
            }]
        },
        options: {
            plugins: {
                legend: {
                    position: 'bottom'
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            const label = context.label || '';
                            const value = context.raw || 0;
                            return `${label}: ${value}`;
                        }
                    }
                }
            }
        }
    });
</script>

</body>
</html>
	