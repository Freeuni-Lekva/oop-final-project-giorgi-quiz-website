package com.freeuni.quizwebsite.service;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;
import com.freeuni.quizwebsite.model.db.Achievement;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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
    public static Set<Achievement> findAchievementsByUserId(int id) throws SQLException {
        ResultSet resultSet;
        resultSet = connection.prepareStatement("SELECT * FROM ACHIEVEMENTS WHERE user_id = " + id).executeQuery();
        Set<Achievement> achievementList = new HashSet<>();
        Set<String> achievementListString = new HashSet<>();
        while (resultSet.next()) {
            Achievement achievement = new Achievement(
                    resultSet.getInt("achievement_id"),
                    resultSet.getInt("user_id"),
                    resultSet.getString("achievement")
            );
            if(!achievementListString.contains(achievement.getAchivementName())){
                achievementList.add(achievement);
                achievementListString.add(achievement.getAchivementName());

            }

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
