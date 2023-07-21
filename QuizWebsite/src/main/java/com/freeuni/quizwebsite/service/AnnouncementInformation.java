package com.freeuni.quizwebsite.service;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;
import com.freeuni.quizwebsite.model.db.Announcement;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class AnnouncementInformation {
    private static final Connection connection = ConnectToDB.getConnection();

    //unordered announcements from specific user
    public static ArrayList<Announcement> getCreatedAnnouncementsById(int user) throws SQLException, SQLException {
        return getAnnouncements(user, false);
    }

    //unordered announcements from all users
    public static ArrayList<Announcement> getCreatedAnnouncements() throws SQLException, SQLException {
        return getCreatedAnnouncementsById(-1);
    }

    //get latest announcements from specific user
    public static ArrayList<Announcement> getLatestAnnouncementsById(int user) throws SQLException {
       return getAnnouncements(user, true);
    }

    //get latest announcement from all users
    public static ArrayList<Announcement> getLatestAnnouncements() throws SQLException {
        return getLatestAnnouncementsById(-1);
    }

    private static ArrayList<Announcement> getAnnouncements(int user, boolean latest) throws SQLException {
        ArrayList<Announcement> announcements = new ArrayList<>();
        String script = "";
        if(user==-1) {
            script = "SELECT * FROM ANNOUNCEMENTS";
        } else {
            script = "SELECT * FROM ANNOUNCEMENTS WHERE user_id = " + user;
        }
        if(latest) script+=" ORDER BY creation_date DESC";
        ResultSet resultSet = connection.prepareStatement(script).executeQuery();
        while(resultSet.next()) {
            announcements.add(new Announcement(resultSet.getInt("user_id"), resultSet.getString("announcement"),
                    resultSet.getTimestamp("creation_date")));
        }
        return announcements;
    }

    public static Announcement getAnnouncementCreator(String text) throws SQLException {
        ResultSet resultSet = connection.prepareStatement("SELECT * FROM ANNOUNCEMENTS WHERE announcement = '" + text + "'").executeQuery();
        resultSet.next();
        return new Announcement(resultSet.getInt("user_id"), resultSet.getString("announcement"), resultSet.getTimestamp("creation_date"));
    }
}
