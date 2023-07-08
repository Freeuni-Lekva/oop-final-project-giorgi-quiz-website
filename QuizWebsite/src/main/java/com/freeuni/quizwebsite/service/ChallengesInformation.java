package com.freeuni.quizwebsite.service;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;
import com.freeuni.quizwebsite.model.db.Challenge;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ChallengesInformation {

    private static final Connection connection = ConnectToDB.getConnection();

    public static ArrayList<Challenge> getUserSentChallenges(int senderId) throws SQLException {
        ArrayList<Challenge> result = new ArrayList<>();
        ResultSet resultSet;

        resultSet = connection.prepareStatement("SELECT * FROM CHALLENGES WHERE SENDER_USER = "
                + senderId).executeQuery();
        if (!resultSet.next()) {
            return null;
        }
        Challenge challenge;
        while (resultSet.next()) {
            challenge = new Challenge(resultSet.getInt("sender_user"), resultSet.getInt("receiver_user"),
                    resultSet.getInt("quiz_id"), resultSet.getString("description"),
                    resultSet.getTimestamp("send_time"));
            result.add(challenge);
        }
        return result;
    }
}
