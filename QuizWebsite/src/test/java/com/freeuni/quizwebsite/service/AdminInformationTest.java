package com.freeuni.quizwebsite.service;

import org.junit.jupiter.api.Test;

import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.*;

class AdminInformationTest {

    @Test
    void userAmount() throws SQLException {
        assertEquals(AdminInformation.userAmount(), 6);
    }

    @Test
    void quizAmount() throws SQLException {
        assertEquals(AdminInformation.quizAmount(), 8);
    }

    @Test
    void totalViews() throws SQLException {
        assertEquals(AdminInformation.totalViews(), 12);
    }

    @Test
    void totalChallenges() throws SQLException {
        assertEquals(AdminInformation.totalChallenges(), 5);
    }



    @Test
    void usersAddedToday() throws SQLException {
        assertEquals(AdminInformation.usersAddedToday(), 6);
    }

    @Test
    void usersAddedLastSevenDays() throws SQLException {
        System.out.println(AdminInformation.usersAddedLastSevenDays());
    }

    @Test
    void quizzesAddedLastSevenDays() throws SQLException {
        System.out.println(AdminInformation.quizzesAddedLastSevenDays());
    }

    @Test
    void totalQuizTake() throws SQLException {
        assertEquals(AdminInformation.totalQuizTake(), 4);
    }

    @Test
    void quizHistoriesTakenLastSevenDays() throws SQLException {
        System.out.println(AdminInformation.quizHistoriesTakenLastSevenDays());
    }

    @Test
    void quizTotalMailsTest() throws SQLException {
        assertEquals(AdminInformation.totalMails(), 5);
    }
}