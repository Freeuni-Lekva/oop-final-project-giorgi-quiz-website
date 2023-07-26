package com.freeuni.quizwebsite.service;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;
import com.freeuni.quizwebsite.model.db.Friend;
import com.freeuni.quizwebsite.model.db.User;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class FriendsInformation {
    private static final Connection connection = ConnectToDB.getConnection();

    public static ArrayList<Friend> getPeopleOfStatus(int userId, String status, int order) throws SQLException {
        ArrayList<Friend> friendsOrSo = new ArrayList<>();
        String script = "SELECT * FROM FRIENDS WHERE (user_one = " + userId + " OR user_two = " + userId + ") AND relationship_status = '" + status + "'";
        if (order == 1) script += " ORDER BY add_date DESC";
        if (order == -1) script += " ORDER BY add_date ASC";
        ResultSet resultSet = connection.prepareStatement(script).executeQuery();
        while (resultSet.next()) {
            int userOne = resultSet.getInt("user_one");
            int userTwo = resultSet.getInt("user_two");
            if (userOne != userId) {
                userTwo = userOne;
                userOne = userId;
            }
            friendsOrSo.add(new Friend(userOne, userTwo,
                    resultSet.getString("relationship_status"), resultSet.getTimestamp("add_date")));
        }
        return friendsOrSo;
    }

    public static ArrayList<User> getAllFriends(int userId) throws SQLException {
        ArrayList<User> friends = new ArrayList<>();
        String script = "SELECT * FROM FRIENDS WHERE (user_one = " + userId + " OR user_two = " + userId + ");";

        ResultSet resultSet = connection.prepareStatement(script).executeQuery();

        while (resultSet.next()) {
            int userOne = resultSet.getInt("user_one");
            int userTwo = resultSet.getInt("user_two");
            if (userOne != userId) {
                friends.add(UsersInformation.findUserById(userOne));
            } else {
                friends.add(UsersInformation.findUserById(userTwo));
            }
        }
        return friends;
    }

    public static ArrayList<Friend> getNewestPeopleOfStatus(int userId, String status) throws SQLException {
        return getPeopleOfStatus(userId, status, 1);
    }

    public static ArrayList<Friend> getOldestPeopleOfStatus(int userId, String status) throws SQLException {
        return getPeopleOfStatus(userId, status, -1);
    }

    //since it will be commonly used, I made a separate method to get list of friends, even though upper method can do it to (but requires additional argument)
    public static ArrayList<Friend> getFriends(int userId) throws SQLException {
        return getPeopleOfStatus(userId, "FRIENDS", 0);
    }

    public static ArrayList<Friend> getNewestFriends(int userId) throws SQLException {
        return getNewestPeopleOfStatus(userId, "FRIENDS");
    }

    public static ArrayList<Friend> getOldestFriends(int userId) throws SQLException {
        return getOldestPeopleOfStatus(userId, "FRIENDS");
    }

    public static boolean areOfStatus(int userOne, int userTwo, String status) throws SQLException {
        String script = "SELECT * FROM FRIENDS WHERE (user_one = " + userOne + " AND user_two = " + userTwo + " AND relationship_status = '" + status + "') OR (" +
                "user_one = " + userTwo + " AND user_two = " + userOne + " AND relationship_status = '" + status + "')";
        ResultSet resultSet = connection.prepareStatement(script).executeQuery();
        return resultSet.next();
    }

    public static boolean areFriends(int userOne, int userTwo) throws SQLException {
        return areOfStatus(userOne, userTwo, "FRIENDS");
    }

}
