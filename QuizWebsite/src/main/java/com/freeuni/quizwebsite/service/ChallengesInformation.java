package com.freeuni.quizwebsite.service;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;
import com.freeuni.quizwebsite.model.db.Challenge;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ChallengesInformation {

    private static final Connection connection = ConnectToDB.getConnection();

    public static Challenge getChallengeByChallengeId(int challengeId) throws SQLException {
        ResultSet resultSet;

        resultSet = connection.prepareStatement("SELECT * FROM CHALLENGES WHERE challenge_id = "
                + challengeId + " ORDER BY send_time DESC").executeQuery();
        resultSet.next();
        Challenge challenge = new Challenge(resultSet.getInt("challenge_id"),resultSet.getInt("sender_user"), resultSet.getInt("receiver_user"),
                resultSet.getInt("quiz_id"), resultSet.getString("description"),
                resultSet.getTimestamp("send_time"));
        return challenge;
    }

    public static ArrayList<Challenge> getUserSentChallenges(int senderId) throws SQLException {
        ArrayList<Challenge> result = new ArrayList<>();
        ResultSet resultSet;

        resultSet = connection.prepareStatement("SELECT * FROM CHALLENGES WHERE SENDER_USER = "
                + senderId).executeQuery();
        Challenge challenge;
        while (resultSet.next()) {
            challenge = new Challenge(resultSet.getInt("challenge_id"),resultSet.getInt("sender_user"), resultSet.getInt("receiver_user"),
                    resultSet.getInt("quiz_id"), resultSet.getString("description"),
                    resultSet.getTimestamp("send_time"));
            result.add(challenge);
        }
        return result;
    }

    public static ArrayList<Challenge> getUserReceivedChallenges(int receiverId) throws SQLException {
        ArrayList<Challenge> result = new ArrayList<>();
        ResultSet resultSet;

        resultSet = connection.prepareStatement("SELECT * FROM CHALLENGES WHERE RECEIVER_USER = "
                + receiverId).executeQuery();
        Challenge challenge;
        while (resultSet.next()) {
            challenge = new Challenge(resultSet.getInt("challenge_id"),resultSet.getInt("sender_user"), resultSet.getInt("receiver_user"),
                    resultSet.getInt("quiz_id"), resultSet.getString("description"),
                    resultSet.getTimestamp("send_time"));
            result.add(challenge);
        }
        return result;
    }
}
