package com.freeuni.quizwebsite.service;

import com.freeuni.quizwebsite.model.db.User;
import org.junit.jupiter.api.Test;

import java.sql.SQLException;

import static org.junit.Assert.assertEquals;

class UsersInformationTest {

    @Test
    public void findUserById() throws SQLException {
        User tazuka = UsersInformation.findUserById(2);
        assertEquals(tazuka.getFirstName(), "Tamazi");
    }
}