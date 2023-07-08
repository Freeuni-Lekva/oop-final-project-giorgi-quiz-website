package com.freeuni.quizwebsite.service;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;
import com.freeuni.quizwebsite.model.db.User;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsersInformation {

    private static Connection connection = ConnectToDB.getConnection();

    public static User findUserById(int id) throws SQLException {
        ResultSet resultSet;

        resultSet = connection.prepareStatement("SELECT * FROM USERS WHERE USER_ID = " + id).executeQuery();
        if(!resultSet.next()){
            return null;
        }
        return new User(resultSet.getInt("user_id"),
                resultSet.getString("first_name"), resultSet.getString("last_name"),
                resultSet.getString("username"), resultSet.getString("bio"),
                resultSet.getString("password"), resultSet.getTimestamp("creation_date"),
                resultSet.getBoolean("is_admin"));
    }
}
