package com.freeuni.quizwebsite.service.manipulation;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ChallengesManipulation {
    private static final Connection connection = ConnectToDB.getConnection();

    public static void deleteChallengeByReceiverId(int receiverId) throws SQLException {
        connection.prepareStatement("DELETE FROM CHALLENGES WHERE receiver_user = " + receiverId +";").executeUpdate();
    }

    public static void deleteChallengeBySenderId(int senderId) throws SQLException {
        connection.prepareStatement("DELETE FROM CHALLENGES WHERE sender_user = " + senderId +";").executeUpdate();
    }

    public static void deleteChallengeById(int challengeId) throws SQLException {
        connection.prepareStatement("DELETE FROM CHALLENGES WHERE challenge_id = " + challengeId + ";").executeUpdate();
    }

    public static void addChallenge(int senderUserId, int receiverUserId,int quizId, String description) throws SQLException {
        PreparedStatement ps =connection.prepareStatement("INSERT INTO CHALLENGES (sender_user, receiver_user,quiz_id,description) VALUES (?, ?,?,?)");
        ps.setInt(1, senderUserId);
        ps.setInt(2, receiverUserId);
        ps.setInt(3, quizId);
        ps.setString(4, description);
        ps.executeUpdate();
    }
}
