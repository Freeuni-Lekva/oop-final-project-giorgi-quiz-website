package com.freeuni.quizwebsite.service;

import com.freeuni.quizwebsite.model.Achievements;
import com.freeuni.quizwebsite.model.db.Achievement;
import org.junit.jupiter.api.Test;

import java.sql.SQLException;
import java.util.List;
import java.util.Set;

import static org.junit.jupiter.api.Assertions.*;

class AchievementsInformationTest {

    @Test
    void findAchivementsByUserId() throws SQLException {
        //test 0
        Set<Achievement> achlist = AchievementsInformation.findAchievementsByUserId(1);
        assertTrue(achlist.stream().anyMatch(e->e.getUserId()==1&& e.getAchivementName().equals(Achievements.AMATEUR_AUTHOR.name())));

        //test 1
        Set<Achievement>  achlist1 = AchievementsInformation.findAchievementsByUserId(100);
        assertEquals(0,achlist1.size());

    }

    @Test
    void findAchievementsByAchievementName() throws SQLException {
        //test0
        List<Achievement>  achlist = AchievementsInformation.findAchievementsByAchievementName(Achievements.AMATEUR_AUTHOR.name());
        assertTrue(achlist.stream().anyMatch(e->e.getUserId()==1&& e.getAchivementName().equals(Achievements.AMATEUR_AUTHOR.name())));

        //test1
        List<Achievement>  achlist1 = AchievementsInformation.findAchievementsByAchievementName("NONEXISTENT_ACHIEVEMENT");
        assertEquals(0, achlist1.size());
    }

    @Test
    void findAchievementsById() throws SQLException {
        Achievement a = AchievementsInformation.findAchievementsById(6);
        assertEquals(a.getUserId(), 10001);
        assertEquals(a.getAchivementName(), "PROLIFIC_AUTHOR");
    }

    @Test
    void findAchievementsNull() throws SQLException {
        Achievement a = AchievementsInformation.findAchievementsById(6900990);
        assertNull(a);
    }
}