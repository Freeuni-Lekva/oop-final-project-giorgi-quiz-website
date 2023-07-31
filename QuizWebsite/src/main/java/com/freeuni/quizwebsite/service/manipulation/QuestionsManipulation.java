package com.freeuni.quizwebsite.service.manipulation;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;
import com.freeuni.quizwebsite.model.db.Question;
import com.freeuni.quizwebsite.service.QuestionInformation;

import java.sql.*;
import java.util.List;

public class QuestionsManipulation {

    private static final Connection connection = ConnectToDB.getConnection();

    private static String QUESTIONS_BASE = "QUESTIONS";

    private static String ANSWERS_BASE_CORRECT = "ANSWERS";

    private static String ANSWERS_BASE_MULTIPLE = "POSSIBLE_ANSWERS";

    //deletes a question having a given id (that is passed as an argument), deletes everything associated with it, including all possible and correct answers
    public static void deleteQuestionById(int questionId) throws SQLException {
        connection.prepareStatement("DELETE FROM " + ANSWERS_BASE_CORRECT + " WHERE question_id = " + questionId).executeUpdate();
        connection.prepareStatement("DELETE FROM " + ANSWERS_BASE_MULTIPLE + " WHERE question_id = " + questionId).executeUpdate();
        connection.prepareStatement("DELETE FROM " + QUESTIONS_BASE + " WHERE question_id = " + questionId).executeUpdate();
    }

    //deletes all the questions (their characteristics and answers) that are part of the specified quiz
    public static void deleteQuestionByQuizId(int quizId) throws SQLException {
        List<Question> questions = QuestionInformation.getQuestionsInQuiz(quizId);
        for (Question question: questions) {
            deleteQuestionById(question.getQuestionId());
        }
    }

    //adds a question given its characteristics, returns the id, so answers tables can be filled..
    public static int addQuestion(int quizId, String pictureUrl, String questionType, String question, int sortOrder) throws SQLException {
        String update = "INSERT INTO " + QUESTIONS_BASE + " (quiz_id, picture_url, question_type, question, sort_order) " +
                "VALUES (" + quizId + ", '" + pictureUrl + "', '" + questionType + "', '" + question + "', " + sortOrder + ")";
        PreparedStatement preparedStatement = connection.prepareStatement(update, Statement.RETURN_GENERATED_KEYS);
        preparedStatement.executeUpdate();
        ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
        if(generatedKeys.next()) {
            return generatedKeys.getInt(1);
        } else {
            throw new SQLException("Failed to get the generated question_id."); //this is the line that is not covered in the tests
        }
        //return generatedKeys.next() ? generatedKeys.getInt(1) : -1;
    }

    //has the same name as the method above but different number of arguments (one argument is given a default value internally and the above method is called)
    public static int addQuestion(int quizId, String questionType, String question, int sortOrder) throws SQLException {
        return addQuestion(quizId, "", questionType, question, sortOrder);
    }

    //has the same name as the method above but different number of arguments (two arguments are given default values internally and the above (up up) method is called)
    public static int addQuestion(int quizId, String questionType, String question) throws SQLException {
        return addQuestion(quizId, "", questionType, question, 0);
    }

    //adds a possible answer with question id specified
    public static void addPossibleAnswer(int questionId, String answer) throws SQLException {
        connection.prepareStatement("INSERT INTO " + ANSWERS_BASE_MULTIPLE + " (question_id, possible_answer) " +
                "VALUES (" + questionId + ", '" + answer + "')").executeUpdate();
    }

    //adds a correct answer with question id specified
    public static void addCorrectAnswer(int questionId, String answer) throws SQLException {
        connection.prepareStatement("INSERT INTO " + ANSWERS_BASE_CORRECT + " (question_id, answer) " +
                "VALUES (" + questionId + ", '" + answer + "')").executeUpdate();
    }
}
