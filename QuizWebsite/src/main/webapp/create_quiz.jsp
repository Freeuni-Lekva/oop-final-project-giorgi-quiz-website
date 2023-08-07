<!DOCTYPE html>
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

        /* Additional styles for improved aesthetics */
        .form-header {
            text-align: center;
            margin-bottom: 30px;
            font-size: 24px;
        }

        .form-section {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            font-size: 18px;
            margin-bottom: 5px;
        }

        .form-submit-section {
            text-align: center;
        }

        .form-error-message {
            color: red;
            font-size: 14px;
        }
    </style>

</head>
<body>
<div class="form-container">
    <div class="form-header">Create Quiz</div>
    <button class="home-button" onclick="redirectTo('home_page.jsp')">Home</button>
    <br>
    <form id="quizForm" method="post" action="CreateQuiz" onsubmit="return validateForm()">
        <div class="form-section">
            <label class="form-label" for="quizName">Quiz Name:</label>
            <input class="form-input" type="text" name="quizName" id="quizName" placeholder="Quiz Name" required>
        </div>

        <div class="form-section">
            <label class="form-label" for="quizDescription">Quiz Description:</label>
            <textarea class="form-input" name="quizDescription" id="quizDescription" placeholder="Quiz Description"
                      required></textarea>
        </div>

        <div class="checkbox-group form-section">
            <label><input type="checkbox" name="randomQuestions"> Random Questions</label>
            <label><input type="checkbox" name="onePage"> One Page </label>
            <label><input type="checkbox" name="immediateCorrection"> Immediate Correction</label>
            <label><input type="checkbox" name="practiceMode"> Practice Mode</label>
        </div>

        <div class="question-section form-section" id="questionSection">
            <label for="btn-group">Next question type:</label>
            <div class="btn-group" id="btn-group">
                <button type="button" onclick="addQuestion('questionResponse')">Question-Response</button>
                <button type="button" onclick="addQuestion('fillBlank')">Fill in the Blank</button>
                <button type="button" onclick="addQuestion('multipleChoice')">Multiple Choice</button>
                <button type="button" onclick="addQuestion('pictureResponse')">Picture-Response</button>
            </div>
        </div>

        <div class="form-submit-section">
            <input class="submit-button" onclick="freeAnswers()" type="submit" value="Submit Quiz">
        </div>
    </form>

</div>

<script>
    function redirectTo(url) {
        window.location.href = url;
    }

    const answers = [];
    let Qid = 0;

    function freeAnswers() {
        let answers = [];
        let Qid = 0;
    }

    function addQuestion(questionType) {
        var container = document.createElement('div');
        container.classList.add('question-container');
        container.setAttribute('id', Qid);
        container.style.width = "100%";
        container.style.overflow = "hidden";
        container.style.boxSizing = "border-box";
        Qid++;
        var questionTypeField = document.createElement('input');
        questionTypeField.setAttribute('type', 'hidden');
        questionTypeField.setAttribute('name', 'questionTypes[]');
        questionTypeField.setAttribute('value', questionType);

        container.appendChild(questionTypeField);

        var questionField = document.createElement('input');
        questionField.setAttribute('type', 'text');
        questionField.setAttribute('name', 'questions[]');
        questionField.setAttribute('placeholder', 'Enter your ' + questionType);
        questionField.classList.add('form-input');
        questionField.style.maxWidth = "100%";
        questionField.style.boxSizing = "border-box";
        container.appendChild(questionField);


        if (questionType === 'pictureResponse') {
            var pictureUrlField = document.createElement('input');
            pictureUrlField.setAttribute('type', 'text');
            pictureUrlField.setAttribute('placeholder', 'Enter picture URL');
            pictureUrlField.setAttribute('name', 'pictureUrls[]');
            pictureUrlField.classList.add('form-input');
            pictureUrlField.style.maxWidth = "100%";
            pictureUrlField.style.boxSizing = "border-box";
            container.appendChild(pictureUrlField);
        }

        var deleteQuestionBtn = document.createElement('button');
        deleteQuestionBtn.textContent = 'Delete Question';
        deleteQuestionBtn.classList.add('small-button');
        deleteQuestionBtn.addEventListener('click', function (e) {
            e.preventDefault();
            container.remove();
        });
        container.appendChild(deleteQuestionBtn);

        var addAnswerBtn = document.createElement('button');
        addAnswerBtn.textContent = 'Add Answer';
        addAnswerBtn.classList.add('small-button');
        addAnswerBtn.addEventListener('click', function (e) {
            e.preventDefault();
            var answerContainer = document.createElement('div');
            answerContainer.style.display = 'flex';
            answerContainer.style.alignItems = 'center';
            answerContainer.style.justifyContent = 'space-between';

            var answerField = document.createElement('input');
            answerField.setAttribute('type', 'text');
            answerField.setAttribute('placeholder', 'Enter your answer');
            answerField.setAttribute('name', 'answers[' + container.id + '][]');
            answerField.classList.add('form-input');
            answerField.style.flexGrow = '1';
            answerContainer.appendChild(answerField);

            if (questionType === 'multipleChoice') {
                var correctAnswerCheckbox = document.createElement('input');
                correctAnswerCheckbox.setAttribute('type', 'checkbox');
                correctAnswerCheckbox.setAttribute('name', 'correctAnswers[' + container.id + '][]');
                correctAnswerCheckbox.setAttribute('value', 'on');

                var correctAnswerHidden = document.createElement('input');
                correctAnswerHidden.setAttribute('type', 'hidden');
                correctAnswerHidden.setAttribute('name', 'correctAnswers[' + container.id + '][]');
                correctAnswerHidden.setAttribute('value', 'off');
// on->> off on
                var label = document.createElement('label');
                label.textContent = ' Correct';
                label.style.backgroundColor = '#007bff';
                label.style.color = 'white';
                label.style.padding = '5px 10px';
                label.style.borderRadius = '4px';
                label.style.cursor = 'pointer';
                label.insertBefore(correctAnswerCheckbox, label.firstChild);
                answerContainer.appendChild(correctAnswerHidden);
                answerContainer.appendChild(label);
            }


            var deleteAnswerBtn = document.createElement('button');
            deleteAnswerBtn.textContent = 'Delete Answer';
            deleteAnswerBtn.classList.add('small-button');
            deleteAnswerBtn.addEventListener('click', function (e) {
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
        answers.push([]);
    }

    function validateForm() {
        var quizName = document.getElementById("quizName").value.trim();
        var quizDescription = document.getElementById("quizDescription").value.trim();
        var questionContainers = document.getElementsByClassName("question-container");

        if (quizName === "") {
            alert("Please enter a quiz name.");
            return false;
        }

        if (quizDescription === "") {
            alert("Please enter a quiz description.");
            return false;
        }

        if (questionContainers.length === 0) {
            alert("Please add at least one question to the quiz.");
            return false;
        }

        for (var i = 0; i < questionContainers.length; i++) {
            var questionField = questionContainers[i].querySelector('input[name^="question"]');
            var answerFields = questionContainers[i].querySelectorAll('input[name^="answer"]');

            var questionValue = questionField.value.trim();
            if (questionValue === "") {
                alert("Please fill in the question field in all questions.");
                return false;
            }

            var allAnswersEmpty = true;
            for (var j = 0; j < answerFields.length; j++) {
                var answerValue = answerFields[j].value.trim();
                if (answerValue !== "") {
                    allAnswersEmpty = false;
                    break;
                }
            }

            if (allAnswersEmpty) {
                alert("Please fill in at least one answer field in all questions.");
                return false;
            }
        }

        return true;
    }
</script>
</body>
</html>
