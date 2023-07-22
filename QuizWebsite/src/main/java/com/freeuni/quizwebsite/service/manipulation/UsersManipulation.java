package com.freeuni.quizwebsite.service.manipulation;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;
import com.freeuni.quizwebsite.service.UsersInformation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.SQLException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;


public class UsersManipulation {
    private static final Connection connection = ConnectToDB.getConnection();
    public static String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            // Handle the exception or log an error
            e.printStackTrace();
        }
        return null;
    }
    public static int addUser(String firstName, String lastName, String userName, String bio, String password) throws SQLException {
        String hashedPassword = hashPassword(password);
        if (hashedPassword == null) {
            // Handle the error, hashing failed
            return -1;
        }
        if(UsersInformation.findUserByUserName(userName)!=null){
            return -1;
        }
        String insertQuery = "INSERT INTO USERS (first_name, last_name, username, bio, password) " +
                "VALUES (?, ?, ?, ?, ?)";

        PreparedStatement preparedStatement = connection.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS);
        preparedStatement.setString(1, firstName);
        preparedStatement.setString(2, lastName);
        preparedStatement.setString(3, userName);
        preparedStatement.setString(4, bio);
        preparedStatement.setString(5, hashedPassword);

        preparedStatement.executeUpdate();

        ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
        if (generatedKeys.next()) {
            return generatedKeys.getInt(1); // Return the auto-generated user_id
        } else {
            // Handle the error, user_id not generated
            return -1;
        }
    }

    public static void deleteUserById(int userId) throws SQLException {
        String deleteQuery = "DELETE FROM USERS WHERE user_id = ?";
        PreparedStatement preparedStatement = connection.prepareStatement(deleteQuery);
        preparedStatement.setInt(1, userId);
        preparedStatement.executeUpdate();
    }



}
