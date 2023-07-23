package com.freeuni.quizwebsite.service.manipulation;

import org.junit.Test;

import java.sql.SQLException;

public class AnnouncementManipulationTest {

    @Test
    public void addAnnouncement() throws SQLException {
        AnnouncementManipulation.addAnnouncement(1,"vau vau vau");
    }
    @Test
    public void deleteAnnouncementById() throws SQLException {
        AnnouncementManipulation.deleteUserAnnouncementById(1,1);
    }
    @Test
    public void deleteUserAllAnnouncement() throws SQLException {
        AnnouncementManipulation.deleteUsersAllAnnouncement(1);
    }
}