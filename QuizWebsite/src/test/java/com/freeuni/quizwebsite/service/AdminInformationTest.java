package com.freeuni.quizwebsite.service;

import org.junit.jupiter.api.Test;

import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.*;

class AdminInformationTest {

    @Test
    void userAmount() throws SQLException {
        System.out.println(AdminInformation.userAmount());
    }

    @Test
    void quizAmount() throws SQLException {
        System.out.println(AdminInformation.quizAmount());
    }

    @Test
    void totalViews() throws SQLException {
        System.out.println(AdminInformation.totalViews());
    }

    @Test
    void totalChallenges() throws SQLException {
        System.out.println(AdminInformation.totalChallenges());
    }



    @Test
    void usersAddedToday() throws SQLException {
        System.out.println(AdminInformation.usersAddedToday());
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
        System.out.println(AdminInformation.totalQuizTake());
    }

    @Test
    void quizHistoriesTakenLastSevenDays() throws SQLException {
        System.out.println(AdminInformation.quizHistoriesTakenLastSevenDays());
    }
}