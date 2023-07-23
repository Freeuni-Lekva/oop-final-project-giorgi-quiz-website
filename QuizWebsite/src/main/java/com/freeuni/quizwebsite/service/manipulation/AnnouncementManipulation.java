package com.freeuni.quizwebsite.service.manipulation;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AnnouncementManipulation {

    private static final Connection connection = ConnectToDB.getConnection();

    public static void deleteUserAnnouncementById(int userId,int AnnouncementId) throws SQLException {
        connection.prepareStatement("DELETE FROM ANNOUNCEMENTS WHERE user_id = " + userId + " AND " +
                "announcement_id = " + AnnouncementId + ";").executeUpdate();
    }

    public static void deleteUsersAllAnnouncement(int userId) throws SQLException {
        connection.prepareStatement("DELETE FROM ANNOUNCEMENTS WHERE user_id = " + userId + ";").executeUpdate();
    }



    public static void addAnnouncement(int userId, String announcement) throws SQLException {
        PreparedStatement ps =connection.prepareStatement("INSERT INTO ANNOUNCEMENTS (user_id, announcement) VALUES (?, ?)");
        ps.setInt(1, userId);
        ps.setString(2, announcement);
        ps.executeUpdate();
    }

}
