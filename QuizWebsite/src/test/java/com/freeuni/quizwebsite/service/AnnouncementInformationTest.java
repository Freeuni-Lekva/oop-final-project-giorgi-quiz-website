package com.freeuni.quizwebsite.service;

import com.freeuni.quizwebsite.model.db.Announcement;
import org.junit.jupiter.api.Test;

import java.sql.SQLException;
import java.util.ArrayList;

import static org.junit.jupiter.api.Assertions.*;

class AnnouncementInformationTest {
    @Test
    void getCreatedAnnouncements() throws SQLException {
        ArrayList<Announcement> announcements = AnnouncementInformation.getCreatedAnnouncements();
        assertEquals(4, announcements.size());
        assertEquals("England has won under21 european championship", announcements.get(3).getAnnouncement());
        assertEquals("Luis Enrique has become main coach of PSG", announcements.get(0).getAnnouncement());
    }

    @Test
    void getCreatedAnnouncementsById() throws SQLException {
        ArrayList<Announcement> announcements = AnnouncementInformation.getCreatedAnnouncementsById(1);
        assertEquals(2, announcements.size());
        assertEquals("Luis Enrique has become main coach of PSG", announcements.get(0).getAnnouncement());
        assertEquals("England has won under21 european championship", announcements.get(1).getAnnouncement());
    }


    @Test
    void getLatestAnnouncements() throws SQLException {
        ArrayList<Announcement> announcements = AnnouncementInformation.getLatestAnnouncements();
        assertEquals(4, announcements.size());
        assertEquals("England has won under21 european championship", announcements.get(0).getAnnouncement());
        assertEquals("Luis Enrique has become main coach of PSG", announcements.get(3).getAnnouncement());
    }

    @Test
    void getLatestAnnouncementsById() throws SQLException {
        ArrayList<Announcement> announcements = AnnouncementInformation.getLatestAnnouncementsById(1);
        assertEquals(2, announcements.size());
        assertEquals("Luis Enrique has become main coach of PSG", announcements.get(1).getAnnouncement());
        assertEquals("England has won under21 european championship", announcements.get(0).getAnnouncement());
    }
    @Test
    void getAnnouncementCreator() throws SQLException {
        Announcement announcement = AnnouncementInformation.getAnnouncementCreator("Luis Enrique has become main coach of PSG");
        assertEquals(1, announcement.getUserId());
    }

    @Test
    void getAnnouncementById() throws SQLException {
        System.out.println(AnnouncementInformation.getAnnouncementById(2).getAnnouncement());
    }


}