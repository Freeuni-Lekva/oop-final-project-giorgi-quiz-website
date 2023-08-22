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
    void usersAddedLastSevenDays() throws SQLException {
        System.out.println(AdminInformation.usersAddedLastSevenDays());
    }

    @Test
    void quizHistoriesTakenLastSevenDays() throws SQLException {
        System.out.println(AdminInformation.quizHistoriesTakenLastSevenDays());
    }

}