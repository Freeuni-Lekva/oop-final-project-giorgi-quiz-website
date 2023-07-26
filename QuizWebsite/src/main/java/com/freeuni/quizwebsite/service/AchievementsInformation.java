package com.freeuni.quizwebsite.service;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;
import com.freeuni.quizwebsite.model.db.Achievement;
import com.freeuni.quizwebsite.model.db.User;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AchievementsInformation {

    private static final Connection connection = ConnectToDB.getConnection();

    public static Achievement findAchievementsById(int id) throws SQLException {
        ResultSet resultSet;
        resultSet = connection.prepareStatement("SELECT * FROM ACHIEVEMENTS WHERE achievement_id = " + id).executeQuery();
        if(!resultSet.next()){
            return null;
        }
        return new Achievement(resultSet.getInt("achievement_id"),
                resultSet.getInt("user_id"),
                resultSet.getString("achievement")
                );
    }

    //this method finds all Achievements of user id
    public static List<Achievement> findAchievementsByUserId(int id) throws SQLException {
        ResultSet resultSet;
        resultSet = connection.prepareStatement("SELECT * FROM ACHIEVEMENTS WHERE user_id = " + id).executeQuery();
        List<Achievement> achievementList = new ArrayList<>();
        while (resultSet.next()) {
            Achievement achievement = new Achievement(
                    resultSet.getInt("achievement_id"),
                    resultSet.getInt("user_id"),
                    resultSet.getString("achievement")
            );
            achievementList.add(achievement);
        }
        return achievementList;
    }

    public static List<Achievement> findAchievementsByUserName(String name) throws SQLException {
        ResultSet resultSet;
        resultSet = connection.prepareStatement("SELECT * FROM ACHIEVEMENTS A left join users u on A.user_id=u.user_id " +
                "WHERE u.username=  \"" + name+"\"").executeQuery();
        List<Achievement> achievementList = new ArrayList<>();
        while (resultSet.next()) {
            Achievement achievement = new Achievement(
                    resultSet.getInt("achievement_id"),
                    resultSet.getInt("user_id"),
                    resultSet.getString("achievement"));
            achievementList.add(achievement);
        }
        return achievementList;
    }

    public static List<Achievement> findAchievementsByAchievementName(String achievementName) throws SQLException {
        ResultSet resultSet;
        resultSet = connection.prepareStatement("SELECT * FROM ACHIEVEMENTS A " +
                "WHERE A.achievement=  \"" + achievementName +"\"").executeQuery();
        List<Achievement> achievementList = new ArrayList<>();
        while (resultSet.next()) {
            Achievement achievement = new Achievement(
                    resultSet.getInt("achievement_id"),
                    resultSet.getInt("user_id"),
                    resultSet.getString("achievement"));
            achievementList.add(achievement);
        }
        return achievementList;
    }
}
