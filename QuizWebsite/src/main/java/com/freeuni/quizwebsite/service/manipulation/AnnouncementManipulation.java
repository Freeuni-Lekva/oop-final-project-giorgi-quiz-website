package com.freeuni.quizwebsite.service.manipulation;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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



    public static int addAnnouncement(int userId, String announcement) throws SQLException {
        PreparedStatement ps = connection.prepareStatement("INSERT INTO ANNOUNCEMENTS (user_id, announcement) VALUES (?, ?)", PreparedStatement.RETURN_GENERATED_KEYS);
        ps.setInt(1, userId);
        ps.setString(2, announcement);
        ps.executeUpdate();

        // Retrieve the auto-generated key (announcement_id) after the insert
        ResultSet generatedKeys = ps.getGeneratedKeys();
        if (generatedKeys.next()) {
            int announcementId = generatedKeys.getInt(1);
            return announcementId;
        } else {
            // If no key was generated, handle the error or return -1 (indicating failure)
            throw new SQLException("Failed to get the generated announcement_id.");
        }
    }


}
