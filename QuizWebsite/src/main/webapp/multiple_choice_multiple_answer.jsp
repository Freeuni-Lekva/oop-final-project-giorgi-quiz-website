<%@ page import="com.freeuni.quizwebsite.model.db.Question" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.freeuni.quizwebsite.service.QuestionInformation" %>
<%@ page import="java.util.List" %>
<%@ page import="com.freeuni.quizwebsite.service.QuizzesInformation" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 8/14/2023
  Time: 11:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <style>
        #question-info {
            border: 1px solid #cccccc;
            color: #333333;
            background-color: #f2f2f2;
            border-radius: 4px;
            width: 100%;
            margin-bottom: 10px;
            position: absolute;
            top: 25%;
        }

        .answer-container {
            padding: 50px;
            padding-top: 4px;

        }

        body {
            font-family: Arial, sans-serif;
            background-color: #B0C4DE;
            color: darkslateblue;
        }

        h1 {
            color: #00008B;
            margin-top: 5%;
            text-align: center;
        }

        #question-info h1 {
            color: #00008B;
            text-align: initial;
            margin: 0;
            margin-top: 3%;
            margin-left: 50px;
        }

        h2 {
            color: #0000CD;
            margin: 10px 0;
        }

        p {
            color: darkslateblue;
            margin-bottom: 10px;
        }

        .next-button {
            background-color: #1976D2;
            color: white;
            font-size: 18px;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            display: block;
            position: absolute;
            bottom: 15%;
        }

        .next-button:hover {
            background-color: #0056b3;
        }

        label {
            color: darkslateblue;
        }

        .check-button {
            background-color: #00008B;
            color: lightcyan;
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 19px;
            margin: 0;
            margin-top: 3%;
            margin-right: 50px;
        }

        .check-button:hover {
            background-color: #0056b3;
        }

        .center {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

    </style>
    <title>Question <%=(int)request.getSession().getAttribute("queue") +1%></title>
</head>
<body>
    <H1>Quiz: <%=QuizzesInformation.findQuizById((int)request.getSession().getAttribute("quizId")).getName()%></H1>
    <form method="post" action="transition">
        <div id="question-info">
            <div class="center">
                <% int cnt = (int) request.getSession().getAttribute("queue"); %>
                <h1>Question <%=cnt+1%></h1>
                <h1 id="ifChecked" name="ifChecked"></h1>
                <%
                    if(QuizzesInformation.findQuizById((int)request.getSession().getAttribute("quizId")).isInstantFeedback()) {
                %>
                <input type="button" class="check-button" onclick="checkAnswer()" value="Check"/>
                <%
                    }
                %>
            </div>
            <% ArrayList<Question> questions = (ArrayList<Question>) request.getSession().getAttribute("questions");
                String question = questions.get(cnt).getQuestion();
            %>
            <div class="answer-container">
                <p><%=question%></p>
                <p> possible answers: </p>
                <%
                    List<String> possibleAnswers = QuestionInformation.getPossibleAnswers(questions.get(cnt).getQuestionId());
                    for (int j = 0; j < possibleAnswers.size(); j++) {
                %>
                <input type="checkbox" id="ans_<%= j %>" name="<%=cnt%>guess<%=cnt%>" value="<%=possibleAnswers.get(j)%>">
                <label for="ans_<%= j %>"> <%=possibleAnswers.get(j)%> </label>
                <input type="hidden" name="guess<%=cnt%>" value="" />
                <br>
                <%  }
                    cnt++;
                    request.getSession().setAttribute("queue", cnt);
                %>
                <div class="hidden-container">
                    <%
                        ArrayList<String> correctAns = (ArrayList<String>) QuestionInformation.getCorrectAnswers(questions.get(cnt-1).getQuestionId());
                        for (int i = 0; i < correctAns.size(); i++) {
                    %>
                    <p style="display: none" class="hidden-correct-answer"> <%= correctAns.get(i)%>
                    </p>
                    <% } %>
                </div>
            </div>
        </div>
        <input class="next-button" type="submit" id="next" value="Next" onclick="getGuessed()"/>
    </form>
</body>
</html>
<script>
    function getGuessed() {
        const cnt = <%= cnt-1 %>;
        const nameOfCheckBoxCluster = cnt + "guess" + cnt;
        var userGuesses = [];
        const checkboxOptions = document.querySelectorAll('input[name="' + nameOfCheckBoxCluster + '"]:checked');
        checkboxOptions.forEach(checkbox => {
            userGuesses.push(checkbox.value);
        });
        const nameOfAnses= "guess" + cnt;
        var i = 0;
        const readyAnses = document.querySelectorAll('input[name="' + nameOfAnses + '"]');
        readyAnses.forEach(ans => {
            if(i<userGuesses.length) {
                ans.value = userGuesses[i];
                i++;
            }
        });
    }

    function checkAnswer() {
        const cnt = <%= cnt-1 %>;
        const nameOfCheckBoxCluster = cnt + "guess" + cnt;
        const checkBoxOptions = document.querySelectorAll('input[name="' + nameOfCheckBoxCluster + '"]');
        checkBoxOptions.forEach(checkBox => {
            checkBox.disabled = true;
        });
        var userGuesses = [];
        const checkedBoxes = document.querySelectorAll('input[name="' + nameOfCheckBoxCluster + '"]:checked');
        checkedBoxes.forEach(checkedBox => {
            userGuesses.push(checkedBox.value);
        });
        document.getElementById('ifChecked').textContent = "Wrong!";
        const correctAnses = document.querySelectorAll(".hidden-correct-answer");
        var correctos = [];
        correctAnses.forEach(ans => {
            correctos.push(ans.textContent.trim());
        });
        var correct = true;
        const correctAll = correctos.sort();
        const guessedAll = userGuesses.sort();
        if (correctAll.length === guessedAll.length) {
            for (let i = 0; i < correctAll.length; i++) {
                if (correctAll[i] !== guessedAll[i]) {
                    correct = false;
                }
            }
        } else correct = false;
        if (correct) {
            document.getElementById('ifChecked').textContent = "Correct!";
        } else {
            document.getElementById('ifChecked').textContent = "Wrong!";
        }
    }
</script>
