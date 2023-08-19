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

        /*input[type="checkbox"][aria-disabled="true"] {*/
        /*    background-color: #B0C4DE;*/
        /*    pointer-events: none;*/
        /*}*/
        /*input[type="radio"][aria-disabled="true"] {*/
        /*    background-color: #B0C4DE;*/
        /*    pointer-events: none;*/
        /*}*/
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
                <%
                    if(multipleResponse!=null) {
                        for (int j = 0; j < multipleResponse.size(); j++) {
                            if(multipleResponse.get(j)!=null) ans = multipleResponse.get(j);
                %>
                                <div class="answer-container" id="text-field_question<%= i %>">
                                    <input class="answer-input" type="text" name="guess<%= i %>" value="<%=ans%>" readonly />
                                </div>
                    <%  }
                        if(multipleResponse.size()==0) {
                    %>
                            <div class="answer-container" id="text-field_question<%= i %>">
                                <input class="answer-input" type="text" name="guess<%= i %>" value="" readonly />
                            </div>
                    <%  }
                    } else { %>
                        <div class="answer-container" id="text-field_question<%= i %>">
                            <input class="answer-input" type="text" name="guess<%= i %>" value="" readonly />
                        </div>
                    <% } %>
            </div>
            <% } else if (question.getQuestionType().equals(QuestionType.PICTURE_RESPONSE.name())) { %>
            <div class="<%=container%>">
                <div class="center">
                    <h2> Question <%= i + 1 %> </h2> <h3> <%=resultStatus%></h3>
                </div>
                <p> <%= questionText %> </p>
                <img src="<%=question.getPicURL()%>" alt="pic for question <%= i + 1 %>" width="500" height="600">
                <br>
                <%
                    String picAns = "";
                    if(answers.get(question.getQuestionId())!=null) picAns = answers.get(question.getQuestionId()).get(0);
                %>
                <input class="answer-input" type="text" name="guess<%= i %>" value="<%=picAns%>" readonly />
            </div>
            <% } else if (question.getQuestionType().equals(QuestionType.FILL_IN_BLANK.name())) {
                StringTokenizer questionTokens = new StringTokenizer(questionText, "_");
            %>
            <div class="<%=container%>">
                <div class="center">
                    <h2> Question <%= i + 1 %> </h2> <h3> <%=resultStatus%></h3>
                </div>
                <p> Fill in the blanks: </p>
                <p><%=questionTokens.nextToken()%>
                    <%
                        ArrayList<String> fillInAnswers = answers.get(question.getQuestionId());
                        int iterCount = 0;
                        String currentFill = " ";
                        while (questionTokens.hasMoreTokens()) {
                            if(fillInAnswers!=null) currentFill = fillInAnswers.get(iterCount);
                    %>          <input type="text" name="guess<%= i %>" value="<%=currentFill%>" readonly /><%=questionTokens.nextToken()%>
                    <%      iterCount++;
                        } %>
                </p>
            </div>
            <% } else if (question.getQuestionType().equals(QuestionType.MULTIPLE_CHOICE.name())) { %>
            <div class="<%=container%>">
                <div class="center">
                    <h2> Question <%= i + 1 %> </h2> <h3> <%=resultStatus%></h3>
                </div>
                <p> <%= questionText %> </p>
                <p> possible answers: </p>
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
            <% } else if (question.getQuestionType().equals(QuestionType.MULTIPLE_CHOICE_MULTIPLE_ANSWER.name())) { %>
            <div class="<%=container%>">
                <div class="center">
                    <h2> Question <%= i + 1 %> </h2> <h3> <%=resultStatus%></h3>
                </div>
                <p> <%= questionText %> </p>
                <p> possible answers: </p>
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
            <% }
            }
            %>
            <input type="hidden" name="numQuestions" value="<%= questions.size() %>"/>
    </div>
<script>
    function redirectToHome() {
        window.location.href = "home_page.jsp";
    }
</script>
</body>
</html>
