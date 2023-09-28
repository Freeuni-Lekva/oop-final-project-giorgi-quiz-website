package com.freeuni.quizwebsite.service;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;

import java.sql.*;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.Map;

public class AdminInformation {
    private static final Connection connection = ConnectToDB.getConnection();
    public static int userAmount() throws SQLException {
        String script = "SELECT count(*) as cnt FROM USERS";
        ResultSet resultSet = null;
        int result = 0;

        try {
            resultSet = connection.prepareStatement(script).executeQuery();

            if (resultSet.next()) {
                result = resultSet.getInt("cnt");
            }
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
        }

        return result;
    }

    public static int usersAddedToday() throws SQLException {
        String script = "SELECT count(*) as cnt FROM USERS WHERE DAY(creation_date) = ?";
        ResultSet resultSet = null;
        int result = 0;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(script);
            preparedStatement.setInt(1, LocalDate.now().getDayOfMonth());
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                result = resultSet.getInt("cnt");
            }
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
        }

        return result;
    }

    public static Map<LocalDate, Integer> usersAddedLastSevenDays() throws SQLException {
        String script = "SELECT DATE(creation_date) as creation_date, count(*) as cnt FROM USERS " +
                "WHERE creation_date >= ? " +
                "GROUP BY DATE(creation_date)";
        ResultSet resultSet = null;
        Map<LocalDate, Integer> resultMap = new HashMap<>();

        // Initialize the resultMap with 0 counts for the last seven days
        LocalDate currentDate = LocalDate.now();
        for (int i = 0; i < 7; i++) {
            resultMap.put(currentDate.minus(i, ChronoUnit.DAYS), 0);
        }

        try {
            PreparedStatement preparedStatement = connection.prepareStatement(script);
            LocalDate lastSevenDays = LocalDate.now().minus(6, ChronoUnit.DAYS);
            preparedStatement.setDate(1, Date.valueOf(lastSevenDays));
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                LocalDate date = resultSet.getDate("creation_date").toLocalDate();
                int count = resultSet.getInt("cnt");
                resultMap.put(date, count);
            }
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
        }

        return resultMap;
    }

    public static int quizAmount() throws SQLException {
        String script = "SELECT count(*) as cnt FROM Quizes";
        ResultSet resultSet = null;
        int result = 0;

        try {
            resultSet = connection.prepareStatement(script).executeQuery();

            if (resultSet.next()) {
                result = resultSet.getInt("cnt");
            }
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
        }

        return result;
    }

    public static Map<LocalDate, Integer> quizzesAddedLastSevenDays() throws SQLException {
        String script = "SELECT DATE(creation_date) as creation_date, count(*) as cnt FROM Quizes " +
                "WHERE creation_date >= ? " +
                "GROUP BY DATE(creation_date)";
        ResultSet resultSet = null;
        Map<LocalDate, Integer> resultMap = new HashMap<>();

        // Initialize the resultMap with 0 counts for the last seven days
        LocalDate currentDate = LocalDate.now();
        for (int i = 0; i < 7; i++) {
            resultMap.put(currentDate.minus(i, ChronoUnit.DAYS), 0);
        }

        try {
            PreparedStatement preparedStatement = connection.prepareStatement(script);
            LocalDate lastSevenDays = LocalDate.now().minus(6, ChronoUnit.DAYS);
            preparedStatement.setDate(1, Date.valueOf(lastSevenDays));
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                LocalDate date = resultSet.getDate("creation_date").toLocalDate();
                int count = resultSet.getInt("cnt");
                resultMap.put(date, count);
            }
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
        }

        return resultMap;
    }

    public static int totalViews() throws SQLException {
        String script = "SELECT sum(view_count) as cnt FROM Quizes";
        ResultSet resultSet = null;
        int result = 0;

        try {
            resultSet = connection.prepareStatement(script).executeQuery();

            if (resultSet.next()) {
                result = resultSet.getInt("cnt");
            }
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
        }

        return result;
    }

    public static int totalChallenges() throws SQLException {
        String script = "SELECT count(*) as cnt FROM Challenges";
        ResultSet resultSet = null;
        int result = 0;

        try {
            resultSet = connection.prepareStatement(script).executeQuery();

            if (resultSet.next()) {
                result = resultSet.getInt("cnt");
            }
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
        }

        return result;
    }

    public static int totalMails() throws SQLException {
        String script = "SELECT count(*) as cnt FROM note_mail";
        ResultSet resultSet = null;
        int result = 0;
        try {
            resultSet = connection.prepareStatement(script).executeQuery();

            if (resultSet.next()) {
                result = resultSet.getInt("cnt");
            }
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
        }

        return result;
    }

    public static int totalQuizTake() throws SQLException {
        String script = "SELECT count(*) as cnt FROM quiz_history";
        ResultSet resultSet = null;
        int result = 0;

        try {
            resultSet = connection.prepareStatement(script).executeQuery();

            if (resultSet.next()) {
                result = resultSet.getInt("cnt");
            }
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
        }

        return result;
    }

    public static Map<LocalDate, Integer> quizHistoriesTakenLastSevenDays() throws SQLException {
        String script = "SELECT DATE(take_date) as take_date, count(*) as cnt FROM quiz_history " +
                "WHERE take_date >= ? " +
                "GROUP BY DATE(take_date)";
        ResultSet resultSet = null;
        Map<LocalDate, Integer> resultMap = new HashMap<>();

        // Initialize the resultMap with 0 counts for the last seven days
        LocalDate currentDate = LocalDate.now();
        for (int i = 0; i < 7; i++) {
            resultMap.put(currentDate.minusDays(i), 0);
        }

        try {
            PreparedStatement preparedStatement = connection.prepareStatement(script);
            LocalDate lastSevenDays = LocalDate.now().minusDays(6);
            preparedStatement.setDate(1, Date.valueOf(lastSevenDays));
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                LocalDate date = resultSet.getDate("take_date").toLocalDate();
                int count = resultSet.getInt("cnt");
                resultMap.put(date, count);
            }
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
        }

        return resultMap;
    }

}