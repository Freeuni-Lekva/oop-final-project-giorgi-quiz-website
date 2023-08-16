package com.freeuni.quizwebsite.service;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;
import com.freeuni.quizwebsite.model.db.Challenge;
import com.freeuni.quizwebsite.model.db.Friend;
import com.freeuni.quizwebsite.model.db.User;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ImageInformation {
    private static final Connection connection = ConnectToDB.getConnection();
    public static String getImageDataByName(String s) throws SQLException {
        ResultSet resultSet;
        resultSet = connection.prepareStatement("SELECT * FROM IMAGES WHERE name = \"" + s+"\"" ).executeQuery();
        if(!resultSet.next()){
            return null;
        }
        return resultSet.getString("data");
    }


}
