package com.freeuni.quizwebsite.service;

import com.freeuni.quizwebsite.model.Achievements;
import com.freeuni.quizwebsite.model.db.Friend;
import org.junit.jupiter.api.Test;

import java.sql.SQLException;
import java.util.ArrayList;

import static org.junit.jupiter.api.Assertions.*;

class ImageTest {
    @Test
    void getPeopleOfStatus() throws SQLException {
        String img = Image.GetImage(Achievements.AMATEUR_AUTHOR.name());
        assertNotNull(img);
        String img2 = Image.GetImage("racxa");
        assertNull(img2);
    }

}