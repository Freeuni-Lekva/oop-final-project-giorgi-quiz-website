package com.freeuni.quizwebsite.service;


import com.freeuni.quizwebsite.db_connection.ConnectToDB;
import com.freeuni.quizwebsite.model.db.User;
import com.freeuni.quizwebsite.service.manipulation.UsersManipulation;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class UsersInformation {

    private static final Connection connection = ConnectToDB.getConnection();

    public static User findUserById(int id) throws SQLException {
        ResultSet resultSet;

        resultSet = connection.prepareStatement("SELECT * FROM USERS WHERE USER_ID = " + id).executeQuery();
        if(!resultSet.next()){
            return null;
        }
        return new User(resultSet.getInt("user_id"),
                resultSet.getString("first_name"),
                resultSet.getString("last_name"),
                resultSet.getString("username"),
                resultSet.getString("bio"),
                resultSet.getString("password"),
                resultSet.getTimestamp("creation_date"),
                resultSet.getBoolean("is_admin"));
    }

    public static User findUserByUserName(String userName) throws SQLException {
        ResultSet resultSet;

        resultSet = connection.prepareStatement("SELECT * FROM USERS WHERE username = \"" + userName+"\"").executeQuery();
        if(!resultSet.next()){
            return null;
        }
        return new User(resultSet.getInt("user_id"),
                resultSet.getString("first_name"),
                resultSet.getString("last_name"),
                resultSet.getString("username"),
                resultSet.getString("bio"),
                resultSet.getString("password"),
                resultSet.getTimestamp("creation_date"),
                resultSet.getBoolean("is_admin"));
    }

    // creation_date < T
    public static List<User> CreatedBefore(Timestamp T) throws SQLException {
        ResultSet resultSet;
        resultSet = connection.prepareStatement("SELECT * FROM USERS u " +
                "WHERE u.creation_date<  \"" + T+"\"").executeQuery();
        List<User> userlist = new ArrayList<>();
        while (resultSet.next()) {
            User curUser = new User(
                    resultSet.getInt("user_id"),
                    resultSet.getString("first_name"),
                    resultSet.getString("last_name"),
                    resultSet.getString("username"),
                    resultSet.getString("bio"),
                    resultSet.getString("password"),
                    resultSet.getTimestamp("creation_date"),
                    resultSet.getBoolean("is_admin"));
            userlist.add(curUser);
        }
        return userlist;
    }

    // creation_date > = T
    public static List<User> CreatedAfter(Timestamp T) throws SQLException {
        ResultSet resultSet;
        resultSet = connection.prepareStatement("SELECT * FROM USERS u " +
                "WHERE u.creation_date>= \"" + T+"\"").executeQuery();
        List<User> userlist = new ArrayList<>();
        while (resultSet.next()) {
            User curUser = new User(
                    resultSet.getInt("user_id"),
                    resultSet.getString("first_name"),
                    resultSet.getString("last_name"),
                    resultSet.getString("username"),
                    resultSet.getString("bio"),
                    resultSet.getString("password"),
                    resultSet.getTimestamp("creation_date"),
                    resultSet.getBoolean("is_admin"));
            userlist.add(curUser);
        }
        return userlist;
    }
//returns admins user list
    public static List<User> findAdmins() throws SQLException {
        ResultSet resultSet;
        resultSet = connection.prepareStatement("SELECT * FROM USERS u " +
                "WHERE u.is_admin= 1 ").executeQuery();
        List<User> userlist = new ArrayList<>();
        while (resultSet.next()) {
            User curUser = new User(
                    resultSet.getInt("user_id"),
                    resultSet.getString("first_name"),
                    resultSet.getString("last_name"),
                    resultSet.getString("username"),
                    resultSet.getString("bio"),
                    resultSet.getString("password"),
                    resultSet.getTimestamp("creation_date"),
                    resultSet.getBoolean("is_admin"));
            userlist.add(curUser);
        }
        return userlist;
    }

    //returns all users exept admins
    public static List<User> exceptAdmins() throws SQLException {
        ResultSet resultSet;
        resultSet = connection.prepareStatement("SELECT * FROM USERS u " +
                "WHERE u.is_admin= 0 ").executeQuery();
        List<User> userlist = new ArrayList<>();
        while (resultSet.next()) {
            User curUser = new User(
                    resultSet.getInt("user_id"),
                    resultSet.getString("first_name"),
                    resultSet.getString("last_name"),
                    resultSet.getString("username"),
                    resultSet.getString("bio"),
                    resultSet.getString("password"),
                    resultSet.getTimestamp("creation_date"),
                    resultSet.getBoolean("is_admin"));
            userlist.add(curUser);
        }
        return userlist;
    }
    public static boolean verifyPassword(int userId, String password) throws SQLException {
        User user = findUserById(userId);
        if (user == null) {
            // User not found
            return false;
        }

        String hashedPassword = UsersManipulation.hashPassword(password);
        if (hashedPassword == null) {
            // Hashing failed
            return false;
        }

        return hashedPassword.equals(user.getPassword());
    }

}

