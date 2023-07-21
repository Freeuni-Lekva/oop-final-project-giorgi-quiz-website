package com.freeuni.quizwebsite.service.manipulation;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class FriendshipManipulation {

    private static final Connection connection = ConnectToDB.getConnection();

    public static void deleteFriendRequest(int senderId, int receiverId) throws SQLException {
        connection.prepareStatement("DELETE FROM FRIEND_REQUESTS WHERE user_one = " + senderId + " AND " +
                "user_two = " + receiverId + ";").executeUpdate();
    }

    public static void addFriendRequest(int senderId, int receiverId) throws SQLException {
        PreparedStatement ps =connection.prepareStatement("INSERT INTO FRIEND_REQUESTS (user_one, user_two) VALUES (?, ?)");
        ps.setInt(1, senderId);
        ps.setInt(2, receiverId);
        ps.executeUpdate();
    }
}
