package com.freeuni.quizwebsite.service;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;
import com.freeuni.quizwebsite.model.db.Quiz;
import com.freeuni.quizwebsite.model.db.QuizHistory;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class QuizHistoryInformation {

    private static final Connection connection = ConnectToDB.getConnection();

    private static List<QuizHistory> findQuizzesHistory(String script) throws SQLException {
        ResultSet resultSet;
        resultSet = connection.prepareStatement(script).executeQuery();
        List<QuizHistory> quizHistories = new ArrayList<>();

        while (resultSet.next()) {
            QuizHistory quizHistory = new QuizHistory(
                    resultSet.getInt("user_id"),
                    resultSet.getInt("quiz_id"),
                    resultSet.getDouble("score"),
                    resultSet.getTimestamp("take_date")

            );
            quizHistories.add(quizHistory);
        }

        return quizHistories;
    }

    public static List<QuizHistory> getQuizzesHistoryByQuizId(int id) throws SQLException {
        String script = "SELECT * FROM QUIZ_HISTORY WHERE quiz_id = " + id + "" +
                " order by take_date";
        return findQuizzesHistory(script);
    }
    public static List<QuizHistory> getOrderedByScoreQuizzesHistoryByQuizId(int id) throws SQLException {
        String script = "SELECT * FROM QUIZ_HISTORY WHERE quiz_id = " + id + "" +
                " order by score desc limit 5";
        return findQuizzesHistory(script);
    }

    public static List<QuizHistory> getQuizzesHistoryByUserId(int id) throws SQLException {
        String script = "SELECT * FROM QUIZ_HISTORY WHERE user_id = " + id + "" +
                " order by take_date";
        return findQuizzesHistory(script);
    }

    public static List<QuizHistory> getMaxResultedHistoryOfQuiz(int id) throws SQLException {
        String script = "SELECT * FROM QUIZ_HISTORY qh1 WHERE qh1.quiz_id = " + id +" AND" +
                " qh1.score = (SELECT max(qh2.score) from QUIZ_HISTORY qh2 where " +
                "qh1.quiz_id = qh2.quiz_id)" + " order by take_date";
        return findQuizzesHistory(script);
    }
}
