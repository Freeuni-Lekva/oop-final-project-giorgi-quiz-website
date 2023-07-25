package com.freeuni.quizwebsite.service.manipulation;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;
import com.freeuni.quizwebsite.model.db.Question;
import com.freeuni.quizwebsite.service.QuestionsInformation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class QuestionsManipulation {

    private static final Connection connection = ConnectToDB.getConnection();
    private static String QUESTIONS_BASE = "QUESTIONS";
    private static String ANSWERS_BASE_CORRECT = "ANSWERS";
    private static String ANSWERS_BASE_MULTIPLE = "POSSIBLE_ANSWERS";

    //deletes a question having a given id (that is passed as an argument), deletes everything associated with it, including all possible and correct answers
    public static void deleteQuestionById(int questionId) throws SQLException {
        connection.prepareStatement("DELETE FROM " + ANSWERS_BASE_CORRECT + "WHERE question_id = " + questionId).executeUpdate();
        connection.prepareStatement("DELETE FROM " + ANSWERS_BASE_MULTIPLE + "WHERE question_id = " + questionId).executeUpdate();
        connection.prepareStatement("DELETE FROM " + QUESTIONS_BASE + "WHERE question_id = " + questionId).executeUpdate();
    }

    //deletes all the questions (their characteristics and answers) that are part of the specified quiz
    public static void deleteQuestionByQuizId(int quizId) throws SQLException {
        List<Question> questions = QuestionsInformation.getQuestionsInQuiz(quizId);
        for (Question question: questions) {
            deleteQuestionById(question.getQuestionId());
        }
    }

    //needs to return the id, so answers tables can be filled
    public static int addQuestion(int quizId, String pictureUrl, String questionType, String question, int sortOrder) throws SQLException {
        String update = "INSERT INTO " + QUESTIONS_BASE + "QUESTIONS (quiz_id, picture_url, question_type, question, sort_order) " +
                "VALUES (" + quizId + ", '" + pictureUrl + "', '" + questionType + "', '" + question + "', " + sortOrder + ")";
        PreparedStatement preparedStatement = connection.prepareStatement(update);
        preparedStatement.executeUpdate();
        ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
        if(generatedKeys.next()) {
            return generatedKeys.getInt(1);
        } else {
            throw new SQLException("Failed to get the generated question_id.");
        }
    }

    public static int addQuestion(int quizId, String questionType, String question, int sortOrder) throws SQLException {
        return addQuestion(quizId, "", questionType, question, sortOrder);
    }

    public static int addQuestion(int quizId, String questionType, String question) throws SQLException {
        return addQuestion(quizId, "", questionType, question, 0);
    }

    public static void addPossibleAnswer(int questionId, String answer) throws SQLException {
        connection.prepareStatement("INSERT INTO " + ANSWERS_BASE_MULTIPLE + " question_id, possible_answer) " +
                "VALUES (" + questionId + ", '" + answer + "')").executeUpdate();
    }

    public static void addCorrectAnswer(int questionId, String answer) throws SQLException {
        connection.prepareStatement("INSERT INTO " + ANSWERS_BASE_CORRECT + " question_id, answer) " +
                "VALUES (" + questionId + ", '" + answer + "')").executeUpdate();
    }
}
