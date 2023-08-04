package com.freeuni.quizwebsite.service;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TagsInformation {
    private static final Connection connection = ConnectToDB.getConnection();

    public static List<String> AllTagNames() throws SQLException {
        List<String> result = new ArrayList<>();
        ResultSet resultSet;

        resultSet = connection.prepareStatement("SELECT distinct(tag_name) FROM TAGS").executeQuery();
        while (resultSet.next()) {
            String s = resultSet.getString("tag_name");
            result.add(s);
        }
        return result;
    }

    public static List<Integer> getQuizzesIdByTagName(String tagName) throws SQLException {
        List<Integer> result = new ArrayList<>();
        ResultSet resultSet;

        resultSet = connection.prepareStatement("SELECT distinct(quiz_id) FROM TAGS WHERE tag_name = "+ "\"" + tagName+"\"").executeQuery();
        while (resultSet.next()) {
            Integer quiz_id = resultSet.getInt("quiz_id");
            result.add(quiz_id);
        }
        return result;
    }


}
