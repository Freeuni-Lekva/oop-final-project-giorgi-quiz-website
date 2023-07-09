package com.freeuni.quizwebsite.service;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;
import com.freeuni.quizwebsite.model.QuizStates;
import com.freeuni.quizwebsite.model.db.Quiz;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class QuizzesInformation {
    private static final Connection connection = ConnectToDB.getConnection();

    public static Quiz findQuizById(int id) throws SQLException {
        ResultSet resultSet;

        resultSet = connection.prepareStatement("SELECT * FROM Quizes WHERE quiz_id = " + id).executeQuery();
        if (!resultSet.next()) {
            return null;
        }
        return new Quiz(resultSet.getInt("quiz_id"),
                resultSet.getInt("user_id"),
                resultSet.getString("name"),
                resultSet.getString("description"),
                resultSet.getBoolean("sorted"),
                resultSet.getBoolean("one_or_multiple"),
                resultSet.getBoolean("instant_feedback"),
                resultSet.getBoolean("practice_mode"),
                resultSet.getString("quiz_state"),
                resultSet.getInt("view_count"),
                resultSet.getTimestamp("creation_date"));
    }


    //this method finds all except deleted ones quizzes of user id
    public static List<Quiz> findQuizzesByUserId(int id) throws SQLException {
        ResultSet resultSet;
        resultSet = connection.prepareStatement("SELECT * FROM Quizes WHERE user_id = " + id
                + " AND NOT quiz_state = \"" + QuizStates.DELETED + "\"").executeQuery();
        List<Quiz> quizzes = new ArrayList<>();

        while (resultSet.next()) {
            Quiz quiz = new Quiz(
                    resultSet.getInt("quiz_id"),
                    resultSet.getInt("user_id"),
                    resultSet.getString("name"),
                    resultSet.getString("description"),
                    resultSet.getBoolean("sorted"),
                    resultSet.getBoolean("one_or_multiple"),
                    resultSet.getBoolean("instant_feedback"),
                    resultSet.getBoolean("practice_mode"),
                    resultSet.getString("quiz_state"),
                    resultSet.getInt("view_count"),
                    resultSet.getTimestamp("creation_date")
            );
            quizzes.add(quiz);
        }

        return quizzes;
    }

    public static List<Quiz> findQuizzesByName(String name) throws SQLException {
        ResultSet resultSet;
        resultSet = connection.prepareStatement("SELECT * FROM Quizes WHERE lower(name) like \"" + "%" +
                name.toLowerCase() + "%" + "\""
                + " AND NOT quiz_state = \"" + QuizStates.DELETED + "\"").executeQuery();
        List<Quiz> quizzes = new ArrayList<>();

        while (resultSet.next()) {
            Quiz quiz = new Quiz(
                    resultSet.getInt("quiz_id"),
                    resultSet.getInt("user_id"),
                    resultSet.getString("name"),
                    resultSet.getString("description"),
                    resultSet.getBoolean("sorted"),
                    resultSet.getBoolean("one_or_multiple"),
                    resultSet.getBoolean("instant_feedback"),
                    resultSet.getBoolean("practice_mode"),
                    resultSet.getString("quiz_state"),
                    resultSet.getInt("view_count"),
                    resultSet.getTimestamp("creation_date")
            );
            quizzes.add(quiz);
        }

        return quizzes;
    }

    public static List<Quiz> findQuizzesByDescription(String description) throws SQLException {
        ResultSet resultSet;
        resultSet = connection.prepareStatement("SELECT * FROM Quizes WHERE lower(description) like \"" + "%" +
                description.toLowerCase() + "%" + "\""
                + " AND NOT quiz_state = \"" + QuizStates.DELETED + "\"").executeQuery();
        List<Quiz> quizzes = new ArrayList<>();
        while (resultSet.next()) {
            Quiz quiz = new Quiz(
                    resultSet.getInt("quiz_id"),
                    resultSet.getInt("user_id"),
                    resultSet.getString("name"),
                    resultSet.getString("description"),
                    resultSet.getBoolean("sorted"),
                    resultSet.getBoolean("one_or_multiple"),
                    resultSet.getBoolean("instant_feedback"),
                    resultSet.getBoolean("practice_mode"),
                    resultSet.getString("quiz_state"),
                    resultSet.getInt("view_count"),
                    resultSet.getTimestamp("creation_date")
            );
            quizzes.add(quiz);
        }

        return quizzes;
    }

    public static List<Quiz> getPublicQuizzesOrderedByViews() throws SQLException {
        ResultSet resultSet;
        resultSet = connection.prepareStatement("SELECT * FROM Quizes WHERE  quiz_state = \"" + QuizStates.PUBLISHED + "\" " +
                " ORDER BY view_count DESC ").executeQuery();
        List<Quiz> quizzes = new ArrayList<>();
        while (resultSet.next()) {
            Quiz quiz = new Quiz(
                    resultSet.getInt("quiz_id"),
                    resultSet.getInt("user_id"),
                    resultSet.getString("name"),
                    resultSet.getString("description"),
                    resultSet.getBoolean("sorted"),
                    resultSet.getBoolean("one_or_multiple"),
                    resultSet.getBoolean("instant_feedback"),
                    resultSet.getBoolean("practice_mode"),
                    resultSet.getString("quiz_state"),
                    resultSet.getInt("view_count"),
                    resultSet.getTimestamp("creation_date")
            );
            quizzes.add(quiz);
        }

        return quizzes;
    }


}
