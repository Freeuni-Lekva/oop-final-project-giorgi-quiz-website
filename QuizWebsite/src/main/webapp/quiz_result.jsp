<%@ page import="com.freeuni.quizwebsite.model.db.Question" %>
<%@ page import="com.freeuni.quizwebsite.service.QuestionInformation" %>
<%@ page import="java.util.List" %>
<%@ page import="com.freeuni.quizwebsite.model.QuestionType" %>
<%@ page import="java.util.StringTokenizer" %>
<%@ page import="com.freeuni.quizwebsite.service.QuizzesInformation" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<%
    int quizId = (int) request.getSession().getAttribute("quizId");
%>
<head>
    <title>Quiz Result</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #B0C4DE;
            margin: 0;
            padding: 0;
            color: #333333;
        }

        h1 {
            color: #00008B;
            padding-left: 10px;
        }

        .question-container h3 {
            text-align: right;
        }

        .question-container h2 {
            text-align: left;
        }

        .quiz-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        .question-container {
            border: 1px solid #cccccc;
            color: #333333;
            background-color: #f2f2f2;
            border-radius: 4px;
            padding: 15px;
            padding-top: 0;
            margin-bottom: 10px;
        }

        /*.question-container-wrong {*/
        /*    border: 1px solid #cccccc;*/
        /*    color: indianred;*/
        /*    background-color: moccasin;*/
        /*    border-radius: 4px;*/
        /*    padding: 15px;*/
        /*    margin-bottom: 10px;*/
        /*}*/

        /*.question-container-right {*/
        /*    border: 1px solid #cccccc;*/
        /*    color: darkgreen;*/
        /*    background-color: #cccccc;*/
        /*    border-radius: 4px;*/
        /*    padding: 15px;*/
        /*    margin-bottom: 10px;*/
        /*}*/

        .question-text {
            font-size: 18px;
            margin-bottom: 16px;
            margin-top: 0;
        }

        .center {
            padding: 10px;
            padding-bottom: 0;
            padding-left: 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .answer-container {
            margin-top: 10px;
        }

        .answer-label {
            display: block;
            margin: 5px 0;
        }

        .answer-input {
            padding: 5px;
            border: 1px solid #cccccc;
            border-radius: 4px;
            width: 100%;
            box-sizing: border-box;
        }

        .home-button {
            background-color: #00008B;
            color: lightcyan;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        .home-button:hover {
            background-color: #0056b3;
        }

        .fun-button {
            background-color: #00008B;
            color: lightcyan;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }

        .fun-button:hover {
            background-color: #0056b3;
        }

    </style>
</head>
<body>
    <div class="quiz-container">
        <%List<Question> questions = QuestionInformation.getQuestionsInQuiz(quizId);%>
        <div class="center">
            <h1> <%=QuizzesInformation.findQuizById(quizId).getName() %> </h1>
            <h1> Result <%=(int)request.getSession().getAttribute("result")%>/<%=questions.size()%></h1>
            <input type="button" class="home-button" onclick="redirectToHome()" value="Home"/>
        </div>
            <%
                HashMap<Integer, ArrayList<String>> answers = (HashMap<Integer, ArrayList<String>>) request.getSession().getAttribute("answers");

                for (int i = 0; i < questions.size(); i++) {
                    Question question = questions.get(i);
                    String questionText = question.getQuestion();
                    String container = "question-container";
                    String resultStatus = "Wrong!";
                    HashMap<Integer, String> resultPerQuestion = (HashMap<Integer, String>) request.getSession().getAttribute("resultAns");
                    if(resultPerQuestion.get(question.getQuestionId()).equals("Correct!")) resultStatus = "Correct!";
            %>
            <input type="hidden" name="questionId<%= i %>" value="<%= question.getQuestionId() %>"/>
            <%
                if (question.getQuestionType().equals(QuestionType.QUESTION_RESPONSE.name())
                    || question.getQuestionType().equals(QuestionType.QUESTION_RESPONSE_MULTIPLE_ANSWER_UNORDERED.name())
                    || question.getQuestionType().equals(QuestionType.QUESTION_RESPONSE_MULTIPLE_ANSWER_ORDERED.name())) {
                ArrayList<String> multipleResponse = answers.get(question.getQuestionId());
                String ans = "";
            %>
            <div class="<%=container%>" id="question<%= i %>">
                <div class="center">
                    <h2> Question <%= i + 1 %> </h2><h3> <%=resultStatus%></h3>
                </div>
                <p class="question-text"> <%= questionText %> </p>
                <div class="tabs">
                    <button id="<%=i%>0" onclick="chooseTab(0, <%=i%>)" class="fun-button">your answers</button>
                    <button id="<%=i%>1" onclick="chooseTab(1, <%=i%>)" class="fun-button">correct answers</button>
                </div>
                <div id="userAnswers<%=i%>">
                    <%
                        if(multipleResponse!=null) {
                            for (int j = 0; j < multipleResponse.size(); j++) {
                                if(multipleResponse.get(j)!=null) ans = multipleResponse.get(j);
                    %>
                    <div class="answer-container" id="text-field_question<%= i %>">
                        <input class="answer-input" type="text" name="guess<%= i %>" value="<%=ans%>" disabled />
                    </div>
                    <%  }
                        if(multipleResponse.isEmpty()) {
                    %>
                    <div class="answer-container" id="text-field_question<%= i %>">
                        <input class="answer-input" type="text" name="guess<%= i %>" value="" disabled />
                    </div>
                    <%  }
                    } else { %>
                    <div class="answer-container" id="text-field_question<%= i %>">
                        <input class="answer-input" type="text" name="guess<%= i %>" value="" disabled />
                    </div>
                    <% } %>
                </div>
                <div id="correctAnswers<%=i%>" style="display: none">
                    <%
                        ArrayList<String> correctAns = (ArrayList<String>) QuestionInformation.getCorrectAnswers(question.getQuestionId());
                        for (int j = 0; j < correctAns.size(); j++) {
                    %>
                        <div class="answer-container">
                            <input class="answer-input" type="text" value="<%= correctAns.get(j)%>" disabled />
                        </div>
                    <% } %>
                </div>
            </div>
            <% } else if (question.getQuestionType().equals(QuestionType.PICTURE_RESPONSE.name())) { %>
            <div class="<%=container%>">
                <div class="center">
                    <h2> Question <%= i + 1 %> </h2> <h3> <%=resultStatus%></h3>
                </div>
                <p> <%= questionText %> </p>
                <div class="tabs">
                    <button id="<%=i%>0" onclick="chooseTab(0, <%=i%>)" class="fun-button">your answers</button>
                    <button id="<%=i%>1" onclick="chooseTab(1, <%=i%>)" class="fun-button">correct answers</button>
                </div>
                <div id="userAnswers<%=i%>">
                    <br>
                    <img src="<%=question.getPicURL()%>" alt="pic for question <%= i + 1 %>" width="600" height="500">
                    <br>
                    <%
                        String picAns = "";
                        if(answers.get(question.getQuestionId())!=null) picAns = answers.get(question.getQuestionId()).get(0);
                    %>
                    <br>
                    <input class="answer-input" type="text" name="guess<%= i %>" value="<%=picAns%>" disabled />
                </div>
                <div id="correctAnswers<%=i%>" style="display: none">
                    <%
                        ArrayList<String> correctAns = (ArrayList<String>) QuestionInformation.getCorrectAnswers(question.getQuestionId());
                        for (int j = 0; j < correctAns.size(); j++) {
                    %>
                    <div class="answer-container">
                        <input class="answer-input" type="text" value="<%= correctAns.get(j)%>" disabled />
                    </div>
                    <% } %>
                </div>
            </div>
            <% } else if (question.getQuestionType().equals(QuestionType.FILL_IN_BLANK.name())) {
                StringTokenizer questionTokens = new StringTokenizer(questionText, "_");
            %>
            <div class="<%=container%>">
                <div class="center">
                    <h2> Question <%= i + 1 %> </h2> <h3> <%=resultStatus%></h3>
                </div>
                <p> Fill in the blanks: </p>
                <div class="tabs">
                    <button id="<%= i %>0" onclick="chooseTab(0, <%= i %>)" class="fun-button">your answers</button>
                    <button id="<%= i %>1" onclick="chooseTab(1, <%= i %>)" class="fun-button">correct answers</button>
                </div>
                <div id="userAnswers<%= i %>">
                    <p> <%
                        ArrayList<String> fillInAnswers = answers.get(question.getQuestionId());
                        int iterCount = 0;
                        String currentFill = "";
                        if(fillInAnswers != null) {
                            currentFill = fillInAnswers.get(iterCount);
                        }
                        if(questionText.startsWith("_")) { %>
                        <input type="text"  value="<%=currentFill%>" disabled />
                        <% iterCount++;
                        } %>
                        <%=questionTokens.nextToken()%>
                        <%
                            while (questionTokens.hasMoreTokens()) {
                                currentFill = fillInAnswers.get(iterCount);
                        %>      <input type="text"  value="<%=currentFill%>" disabled /><%=questionTokens.nextToken()%>
                        <%      iterCount++;
                            } %>
                        <% if(questionText.endsWith("_")) { %>
                        <input type="text"  value="<%= fillInAnswers.get(fillInAnswers.size() - 1) %>" disabled />
                        <% } %>
                    </p>
                </div>
                <div id="correctAnswers<%=i%>" style="display: none">
                    <%StringTokenizer questionTokensForCorrect = new StringTokenizer(questionText, "_");%>
                    <p><%
                        List<String> correctFillInAnswers = QuestionInformation.getCorrectAnswers(question.getQuestionId());
                        int correctIterCount = 0;
                        String correctCurrentFill = "";
                        if(fillInAnswers != null) {
                            correctCurrentFill = correctFillInAnswers.get(correctIterCount);
                        }
                        if(questionText.startsWith("_")) { %>
                        <input type="text"  value="<%=correctCurrentFill%>" disabled />
                        <% correctIterCount++;;
                        } %>
                        <%=questionTokensForCorrect.nextToken()%>
                        <%
                            while (questionTokensForCorrect.hasMoreTokens()) {
                                correctCurrentFill = correctFillInAnswers.get(correctIterCount);
                        %>      <input type="text"  value="<%=correctCurrentFill%>" disabled /><%=questionTokensForCorrect.nextToken()%>
                        <%      correctIterCount++;
                        } %>
                        <% if(questionText.endsWith("_")) { %>
                        <input type="text"  value="<%= correctFillInAnswers.get(correctFillInAnswers.size() - 1) %>" disabled />
                        <% } %>
                    </p>
                </div>
            </div>
            <% } else if (question.getQuestionType().equals(QuestionType.MULTIPLE_CHOICE.name())) { %>
            <div class="<%=container%>">
                <div class="center">
                    <h2> Question <%= i + 1 %> </h2> <h3> <%=resultStatus%></h3>
                </div>
                <p> <%= questionText %> </p>
                <p> possible answers: </p>
                <div class="tabs">
                    <button id="<%=i%>0" onclick="chooseTab(0, <%=i%>)" class="fun-button">your answers</button>
                    <button id="<%=i%>1" onclick="chooseTab(1, <%=i%>)" class="fun-button">correct answers</button>
                </div>
                <div id="userAnswers<%=i%>">
                    <br>
                    <%
                        List<String> possibleAnswers = QuestionInformation.getPossibleAnswers(question.getQuestionId());
                        ArrayList<String> radioAns = answers.get(question.getQuestionId());
                        for (int j = 0; j < possibleAnswers.size(); j++) {
                            String state = "";
                            if(radioAns!=null && possibleAnswers.get(j).equals(radioAns.get(0))) state = "checked=\"checked\"";
                    %>
                    <input type="radio" id="ans_<%= i %>_<%= j %>" name="guess<%= i %>" value="<%= possibleAnswers.get(j) %>" disabled <%=state%> >
                    <label class="answer-label" for="ans_<%= i %>_<%= j %>"> <%= possibleAnswers.get(j) %> </label>
                    <br>
                    <% } %>
                </div>
                <div id="correctAnswers<%=i%>" style="display: none">
                    <%
                        ArrayList<String> correctAns = (ArrayList<String>) QuestionInformation.getCorrectAnswers(question.getQuestionId());
                        for (int j = 0; j < correctAns.size(); j++) {
                    %>
                    <div class="answer-container">
                        <input class="answer-input" type="text" value="<%= correctAns.get(j)%>" disabled />
                    </div>
                    <% } %>
                </div>
            </div>
            <% } else if (question.getQuestionType().equals(QuestionType.MULTIPLE_CHOICE_MULTIPLE_ANSWER.name())) { %>
            <div class="<%=container%>">
                <div class="center">
                    <h2> Question <%= i + 1 %> </h2> <h3> <%=resultStatus%></h3>
                </div>
                <p> <%= questionText %> </p>
                <p> possible answers: </p>
                <div class="tabs">
                    <button id="<%=i%>0" onclick="chooseTab(0, <%=i%>)" class="fun-button">your answers</button>
                    <button id="<%=i%>1" onclick="chooseTab(1, <%=i%>)" class="fun-button">correct answers</button>
                </div>
                <br>
                <div id="userAnswers<%=i%>">
                    <%
                        List<String> possibleAnswers = QuestionInformation.getPossibleAnswers(question.getQuestionId());
                        ArrayList<String> multipleAns = answers.get(question.getQuestionId());
                        for (int j = 0; j < possibleAnswers.size(); j++) {
                            String state = "";
                            if(multipleAns!=null && multipleAns.contains(possibleAnswers.get(j))) state = "checked=\"checked\"";
                    %>
                    <input type="checkbox" id="ans_<%= i %>_<%= j %>" name="guess<%= i %>" value="<%= possibleAnswers.get(j) %>" disabled <%=state%>>
                    <label class="answer-label" for="ans_<%= i %>_<%= j %>"> <%= possibleAnswers.get(j) %> </label>
                    <br>
                    <% } %>
                </div>
                <div id="correctAnswers<%=i%>" style="display: none">
                    <%
                        ArrayList<String> correctAns = (ArrayList<String>) QuestionInformation.getCorrectAnswers(question.getQuestionId());
                        for (int j = 0; j < correctAns.size(); j++) {
                    %>
                    <input type="checkbox" name="ans_<%= i %>_<%= j %>_<%= j %>" value="<%= correctAns.get(j) %>" disabled checked>
                    <label class="answer-label" for="ans_<%= i %>_<%= j %>_<%= j %>"> <%= correctAns.get(j) %> </label>
                    <% } %>
                </div>
            </div>
            <% }
            }
            %>
            <input type="hidden" name="numQuestions" value="<%= questions.size() %>"/>
    </div>
<script>
    function redirectToHome() {
        window.location.href = "home_page.jsp";
    }

    function chooseTab(tabIdx, i) {
        const userAns = document.getElementById('userAnswers' + i);
        const correctAns = document.getElementById('correctAnswers' + i);
        const userButton = document.getElementById(i +''+ 0);
        const correctButton = document.getElementById(i +''+ 1);

        userAns.style.display = 'none';
        correctAns.style.display = 'none';

        switch (tabIdx) {
            case 0:
                userAns.style.display = 'block';
                userButton.style.background = "#0056b3";
                correctButton.style.background = "#00008B";
                break;
            case 1:
                correctAns.style.display = 'block';
                userButton.style.background = "#00008B";
                correctButton.style.background = "#0056b3";
                break;
        }

    }
</script>
</body>
</html>
