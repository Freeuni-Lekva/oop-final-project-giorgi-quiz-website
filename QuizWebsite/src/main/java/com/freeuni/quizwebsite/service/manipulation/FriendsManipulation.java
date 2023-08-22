package com.freeuni.quizwebsite.service.manipulation;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;
import com.freeuni.quizwebsite.model.db.Friend;
import com.freeuni.quizwebsite.model.db.User;

import java.sql.Connection;
import java.sql.SQLException;

public class FriendsManipulation {

    private static final Connection connection = ConnectToDB.getConnection();

    public static void addFriendByIds(int user1id, int user2id) throws SQLException {
        String update = String.format("INSERT INTO FRIENDS (user_one, user_two) " +
                                      "VALUES (%s, %s);",
                    user1id, user2id);
        connection.prepareStatement(update).executeUpdate();
    }

    public static void deleteFriend(Friend friendship) throws SQLException {
        String update = String.format("DELETE FROM FRIENDS " +
                        "WHERE (user_one = %1$s AND user_two = %2$s) " +
                        "OR (user_one = %2$s AND user_two = %1$s);",
                            friendship.getUserOneId(), friendship.getUserTwoId());
        connection.prepareStatement(update).executeUpdate();
    }

    public static void deleteFriendByIds(int user1id, int user2id) throws SQLException {
        String update = String.format("DELETE FROM FRIENDS " +
                        "WHERE (user_one = %1$s AND user_two = %2$s) " +
                        "OR (user_one = %2$s AND user_two = %1$s);",
                    user1id, user2id);
        connection.prepareStatement(update).executeUpdate();
    }

    public static void deleteAllFriends(User user) throws SQLException {
        String update = "DELETE FROM FRIENDS " +
                        "WHERE user_one = " + user.getUserId() + " OR " +
                        "user_two = " + user.getUserId() + ";";
        connection.prepareStatement(update).executeUpdate();
    }

    public static void deleteAllFriendsById(int userId) throws SQLException {
        String update = "DELETE FROM FRIENDS " +
                        "WHERE user_one = " + userId + " OR " +
                        "user_two = " + userId + ";";
        connection.prepareStatement(update).executeUpdate();
    }

}
