<%@ page import="com.freeuni.quizwebsite.service.UsersInformation" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Create Quiz</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f5f5f5;
      margin: 0;
      padding: 0;
      color: #333333;
    }

    /* Container for form */
    .form-container {
      max-width: 800px;
      margin: 0 auto;
      padding: 20px;
    }

    /* Form input style */
    .form-input {
      width: 100%;
      padding: 15px;
      margin: 10px 0;
      border: 1px solid #cccccc;
      border-radius: 4px;
    }

    /* Submit button style */
    .submit-button {
      background-color: #007bff;
      color: white;
      padding: 10px 20px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 16px;
    }

    .submit-button:hover {
      background-color: #0056b3;
    }

    /* Home button style */
    .home-button {
      background-color: #007bff;
      color: white;
      padding: 10px 20px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 16px;
      margin-top: 20px;
    }

    .home-button:hover {
      background-color: #0056b3;
    }

    /* Button group style */
    .btn-group {
      display: flex;
      justify-content: space-between;
      margin-bottom: 20px;
    }

    .btn-group button {
      flex: 1;
      margin: 0 10px;
      padding: 10px 0;
      color: white;
      background-color: #007bff;
      border: none;
      cursor: pointer;
      border-radius: 4px;
      text-align: center;
    }

    .btn-group button:hover {
      background-color: #0056b3;
    }

    /* Checkbox group style */
    .checkbox-group {
      display: flex;
      justify-content: space-between;
      margin: 10px 0;
    }

    .checkbox-group label {
      display: flex;
      align-items: center;
      color: white;
      background-color: #007bff;
      padding: 5px 10px;
      border-radius: 4px;
      cursor: pointer;
    }

    .checkbox-group label:hover {
      background-color: #0056b3;
    }

    .checkbox-group input {
      margin-right: 10px;
    }
    /* Style for the question container */
    .question-container {
      border: 1px solid #cccccc;
      border-radius: 4px;
      padding: 15px;
      margin-bottom: 10px;
    }
       /* Other styles remain unchanged */

       /* Small button style */
     .small-button {
       flex: 1;
       margin: 0 10px;
       padding: 5px 0; /* smaller padding */
       color: white;
       background-color: #007bff;
       border: none;
       cursor: pointer;
       border-radius: 4px;
       text-align: center;
       font-size: 14px; /* smaller font size */
     }

    .small-button:hover {
      background-color: #0056b3;
    }

  </style>

</head>
<body>
<div class="form-container">
  <h1 style="text-align: center; margin-bottom: 30px;">Create Quiz</h1>
  <button class="home-button" onclick="redirectTo('home_page.jsp')">Home</button>
  <form id="quizForm" method="post" action="CreateQuiz">
    <input class="form-input" type="text" name="quizName" placeholder="Quiz Name" required>
    <div class="checkbox-group">
      <label><input type="checkbox" name="randomQuestions"> Random Questions</label>
      <label><input type="checkbox" name="onePage"> One page vs. Multiple Pages</label>
      <label><input type="checkbox" name="immediateCorrection"> Immediate Correction</label>
      <label><input type="checkbox" name="practiceMode"> Practice Mode</label>
    </div>
    <div id="questionSection">  <!-- Wrapper div -->
      <label for="btn-group" style="display: block; margin-top: 20px;">Next question type</label>
      <div class="btn-group" id="btn-group">
        <button type="button" onclick="addQuestion('questionResponse')">Question-Response</button>
        <button type="button" onclick="addQuestion('fillBlank')">Fill in the Blank</button>
        <button type="button" onclick="addQuestion('multipleChoice')">Multiple Choice</button>
        <button type="button" onclick="addQuestion('pictureResponse')">Picture-Response</button>
      </div>
    </div>
    <input class="submit-button" type="submit" value="Submit Quiz">
  </form>

</div><script>
  function redirectTo(url) {
    window.location.href = url;
  }
  function addQuestion(questionType) {
    var container = document.createElement('div');
    container.classList.add('question-container');

    var questionField = document.createElement('input');
    questionField.setAttribute('type', 'text');
    questionField.setAttribute('name', questionType);
    questionField.setAttribute('placeholder', 'Enter your ' + questionType);
    questionField.setAttribute('name', 'questions[]');
    questionField.classList.add('form-input');
    container.appendChild(questionField);


    if (questionType === 'pictureResponse') {
      var pictureUrlField = document.createElement('input');
      pictureUrlField.setAttribute('type', 'text');
      pictureUrlField.setAttribute('name', 'pictureUrl');
      pictureUrlField.setAttribute('placeholder', 'Enter picture URL');
      pictureUrlField.setAttribute('name', 'pictureUrls[]');
      pictureUrlField.classList.add('form-input');
      container.appendChild(pictureUrlField);
    }

    var deleteQuestionBtn = document.createElement('button');
    deleteQuestionBtn.textContent = 'Delete Question';
    deleteQuestionBtn.classList.add('small-button');
    deleteQuestionBtn.addEventListener('click', function(e) {
      e.preventDefault();
      container.remove();
    });
    container.appendChild(deleteQuestionBtn);

    var addAnswerBtn = document.createElement('button');
    addAnswerBtn.textContent = 'Add Answer';
    addAnswerBtn.classList.add('small-button');
    addAnswerBtn.addEventListener('click', function(e) {
      e.preventDefault();
      var answerContainer = document.createElement('div');
      answerContainer.style.display = 'flex';
      answerContainer.style.alignItems = 'center';
      answerContainer.style.justifyContent = 'space-between';

      var answerField = document.createElement('input');
      answerField.setAttribute('type', 'text');
      answerField.setAttribute('name', 'answer');
      answerField.setAttribute('placeholder', 'Enter your answer');
      answerField.setAttribute('name','answers[]');
      answerField.classList.add('form-input');
      answerField.style.flexGrow = '1';
      answerContainer.appendChild(answerField);

      if (questionType === 'multipleChoice') {
        var correctAnswerCheckbox = document.createElement('input');
        correctAnswerCheckbox.setAttribute('type', 'checkbox');
        correctAnswerCheckbox.setAttribute('name', 'correctAnswer');
        correctAnswerCheckbox.setAttribute('name','answers[]');
        var label = document.createElement('label');
        label.textContent = ' Correct';
        label.style.backgroundColor = '#007bff';
        label.style.color = 'white';
        label.style.padding = '5px 10px';
        label.style.borderRadius = '4px';
        label.style.cursor = 'pointer';
        label.insertBefore(correctAnswerCheckbox, label.firstChild);

        answerContainer.appendChild(label);
      }

      var deleteAnswerBtn = document.createElement('button');
      deleteAnswerBtn.textContent = 'Delete Answer';
      deleteAnswerBtn.classList.add('small-button');
      deleteAnswerBtn.addEventListener('click', function(e) {
        e.preventDefault();
        answerContainer.remove();
      });
      answerContainer.appendChild(deleteAnswerBtn);

      container.appendChild(answerContainer);
    });
    container.appendChild(addAnswerBtn);

    var questionSection = document.getElementById('questionSection');
    var btnGroup = document.getElementById('btn-group');
    questionSection.insertBefore(container, btnGroup);
  }
</script>
</body>
</html>
