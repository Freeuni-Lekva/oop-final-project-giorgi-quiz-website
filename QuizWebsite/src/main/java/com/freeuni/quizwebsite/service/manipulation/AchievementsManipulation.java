package com.freeuni.quizwebsite.service.manipulation;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AchievementsManipulation {

    private static final Connection connection = ConnectToDB.getConnection();

    public static void deleteAchievementsByUserId(int userId) throws SQLException {
        connection.prepareStatement("DELETE FROM ACHIEVEMENTS WHERE user_id = " + userId + ";").executeUpdate();
    }

    public static void deleteAchievementsByUserIdAndAchievement(int userId, String achievement) throws SQLException {
        connection.prepareStatement("DELETE FROM ACHIEVEMENTS WHERE user_id = " + userId +
                " AND achievement = \"" + achievement + "\";").executeUpdate();
    }

    public static void deleteAchievementsById(int achievementId) throws SQLException {
        connection.prepareStatement("DELETE FROM ACHIEVEMENTS WHERE achievement_id = " + achievementId + ";").executeUpdate();
    }

    public static void addAchievement(int userId, String achievement) throws SQLException {
        PreparedStatement ps =connection.prepareStatement("INSERT INTO ACHIEVEMENTS (user_id, achievement) VALUES (?, ?)");
        ps.setInt(1, userId);
        ps.setString(2, achievement);
        ps.executeUpdate();
    }
}
