package com.freeuni.quizwebsite.service;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;
import com.freeuni.quizwebsite.model.QuestionType;
import com.freeuni.quizwebsite.model.QuizStates;
import com.freeuni.quizwebsite.model.db.Question;
import com.freeuni.quizwebsite.model.db.Quiz;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class QuestionsInformation {
    private static final Connection connection = ConnectToDB.getConnection();
    private static String QUESTIONS_BASE = "QUESTIONS";
    private static String ANSWERS_BASE_CORRECT = "ANSWERS";
    private static String ANSWERS_BASE_MULTIPLE = "POSSIBLE_ANSWERS";

    private static List<Question> getQuestions(String query) throws SQLException {
        ResultSet resultSet = connection.prepareStatement(query).executeQuery();
        List<Question> questions = new ArrayList<>();

        while (resultSet.next()) {
            Question question = new Question(
                    resultSet.getInt("question_id"),
                    resultSet.getString("question"),
                    resultSet.getObject("name", QuestionType.class),
                    resultSet.getInt("quiz_id")
            );
            questions.add(question);
        }

        return questions;
    }

    public static Question getQuestion(int id) throws SQLException {
        String query = "SELECT * FROM "+ QUESTIONS_BASE +" WHERE question_id = " + id;
        ResultSet resultSet = connection.prepareStatement(query).executeQuery();
        List<Question> question = getQuestions("query");

        if(question.isEmpty()) return null;
        return question.get(0);
    }

    public static List<Question> getQuestionsInQuiz(int quiz_id) throws SQLException {
        String query = "SELECT * FROM "+ QUESTIONS_BASE +" WHERE quiz_id = " + quiz_id;
        return getQuestions(query);
    }

    private static List<String> getAnswers(int question_id, boolean correct) throws SQLException {
        String query = correct ? "SELECT answer FROM " + ANSWERS_BASE_CORRECT + " WHERE question_id = " + question_id
                                :
                                 "SELECT possible_answer FROM " + ANSWERS_BASE_MULTIPLE + " WHERE question_id = " + question_id;
        ResultSet resultSet = connection.prepareStatement(query).executeQuery();
        List<String> correctAnswers = new ArrayList<>();
        while (resultSet.next()) {
            String ans = resultSet.getString("answer");
            correctAnswers.add(ans);
        }
        return correctAnswers;
    }
    public static List<String> getCorrectAnswers(int question_id) throws SQLException {
        return getAnswers(question_id, true);
    }

    public static List<String> getPossibleAnswers(int question_id) throws SQLException {
        return getAnswers(question_id, false);
    }

}
