<%@ page import="com.freeuni.quizwebsite.model.db.Question" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.freeuni.quizwebsite.service.QuizzesInformation" %>
<%@ page import="com.freeuni.quizwebsite.service.QuestionInformation" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 8/15/2023
  Time: 12:00 AM
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
            padding-bottom: 25px;
            padding-top: 20px;
        }

        .mini-container {
            display: flex;
            justify-content: left;
            margin-bottom: 10px;
            margin-left: 0;
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

        .answer-input {
            padding: 5px;
            border: 1px solid #cccccc;
            border-radius: 4px;
            width: 100%;
            box-sizing: border-box;
        }

        .next-button {
            background-color: #00008B;
            color: lightcyan;
            font-size: 18px;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            display: block;
            position: fixed;
            bottom: 15%;
        }

        .next-button:hover {
            background-color: #0056b3;
        }

        .add-field-button {
            background-color: #00008B;
            color: lightcyan;
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-top: 5px;
            margin-left: 12px;
        }

        .add-field-button:hover {
            background-color: #0056b3;
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
                <div class="mini-container">
                    <p><%=question%></p> <button class="add-field-button" id="newTextField" type="button" onclick="addTextField(<%=cnt%>)">Add New Text Field</button>
                </div>
                <div id="text-field_question<%=cnt%>">
                    <input class="answer-input" type="text" name="<%=cnt%>guess<%=cnt%>"/>
                    <input type="hidden" name="guess<%=cnt%>" value="" />
                </div>
                <%
                    cnt++;
                    request.getSession().setAttribute("queue", cnt);
                %>
            </div>
        </div>
        <div class="hidden-container">
            <%
                ArrayList<String> correctAns = (ArrayList<String>) QuestionInformation.getCorrectAnswers(questions.get(cnt-1).getQuestionId());
                for (int i = 0; i < correctAns.size(); i++) {
            %>
            <p style="display: none" class="hidden-correct-answer"> <%= correctAns.get(i)%>
            </p>
            <% } %>
        </div>
        <input class="next-button" type="submit" id="next" value="Next" onclick="getGuessed()"/>
    </form>
</body>
</html>
<script>
    function addTextField(guessIdx) {
        const container = document.getElementById("text-field_question"+guessIdx);
        const newTextField = document.createElement("input");
        newTextField.className = "answer-input";
        newTextField.type = "text";
        newTextField.name = guessIdx + "guess"+guessIdx;
        container.appendChild(document.createElement("br"));
        container.appendChild(newTextField);
        const newHiddenAns = document.createElement("input");
        newHiddenAns.type = "hidden";
        newHiddenAns.name = "guess"+guessIdx;
        newHiddenAns.value = "";
        container.appendChild(newHiddenAns);
    }

    function getGuessed() {
        const cnt = <%= cnt-1 %>;
        const nameOfGuessesCluster = cnt + "guess" + cnt;
        var userGuesses = [];
        const guesses = document.querySelectorAll('input[name="' + nameOfGuessesCluster + '"]');
        guesses.forEach(guess => {
            userGuesses.push(guess.value);
        });
        const nameOfAnses= "guess" + cnt;
        var i = 0;
        const readyAnses = document.querySelectorAll('input[name="' + nameOfAnses + '"]');
        readyAnses.forEach(ans => {
            ans.value = userGuesses[i];
            i++;
        });
    }

    function checkAnswer() {
        const cnt = <%= cnt-1 %>;
        document.getElementById("newTextField").setAttribute("disabled", true);
        const nameOfGuessesCluster = cnt + "guess" + cnt;
        var userGuesses = [];
        const guesses = document.querySelectorAll('input[name="' + nameOfGuessesCluster + '"]');
        guesses.forEach(guess => {
            userGuesses.push(guess.value);
            guess.disabled = true;
        });
        document.getElementById('ifChecked').textContent = "Wrong!";
        const correctAnses = document.querySelectorAll(".hidden-correct-answer");
        var correctos = [];
        correctAnses.forEach(ans => {
            correctos.push(ans.textContent.trim());
        });
        var type = "<%=questions.get(cnt-1).getQuestionType()%>";
        var typeOrdered = "QUESTION_RESPONSE_MULTIPLE_ANSWER_ORDERED";
        var correct = true;
        var correctAll = correctos;
        var guessedAll = userGuesses;
        if(type!== typeOrdered) {
            correctAll = correctos.sort();
            guessedAll = userGuesses.sort();
        }

        var guessedAllFiltered = [];
        for(let i = 0; i < userGuesses.length; i++) {
            if(userGuesses[i] !== '') {
                guessedAllFiltered.push(userGuesses[i]);
            }
        }

        if (correctAll.length === guessedAllFiltered.length) {
            for (let i = 0; i < correctAll.length; i++) {
                if (correctAll[i] !== guessedAllFiltered[i]) {
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