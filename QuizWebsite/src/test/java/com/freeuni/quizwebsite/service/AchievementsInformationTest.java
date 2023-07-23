package com.freeuni.quizwebsite.service;

import com.freeuni.quizwebsite.model.Achievements;
import com.freeuni.quizwebsite.model.db.Achievement;
import org.junit.jupiter.api.Test;

import java.sql.SQLException;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class AchievementsInformationTest {

    @Test
    void findAchivementsByUserId() throws SQLException {
        //test 0
        List<Achievement>  achlist = AchievementsInformation.findAchievementsByUserId(1);
        //System.out.println(achlist.size());
        assertTrue(achlist.stream().anyMatch(e->e.getUserId()==1&& e.getAchivementName().equals(Achievements.AMATEUR_AUTHOR.name())));

        //test 1
        List<Achievement>  achlist1 = AchievementsInformation.findAchievementsByUserId(100);
        assertEquals(0,achlist1.size());

    }

    @Test
    void findAchivementsByUserName() throws SQLException {
        //test0
        List<Achievement>  achlist = AchievementsInformation.findAchievementsByUserName("Neimar");
        //System.out.println(achlist.size());
        assertTrue(achlist.stream().anyMatch(e->e.getUserId()==1&& e.getAchivementName().equals(Achievements.AMATEUR_AUTHOR.name())));

        //test1
        List<Achievement>  achlist1 = AchievementsInformation.findAchievementsByUserName("Manana");
        assertEquals(0,achlist1.size());
    }
    @Test
    void findAchivementsByAchivementName() throws SQLException {
        //test0
        List<Achievement>  achlist = AchievementsInformation.findAchievementsByAchievementName(Achievements.AMATEUR_AUTHOR.name());
        //System.out.println(achlist.size());
        assertTrue(achlist.stream().anyMatch(e->e.getUserId()==1&& e.getAchivementName().equals(Achievements.AMATEUR_AUTHOR.name())));

        //test1
        List<Achievement>  achlist1 = AchievementsInformation.findAchievementsByUserName(Achievements.QUIZ_MACHINE.name());
        assertEquals(0,achlist1.size());
    }

    @Test
    void findAchievementsById() throws SQLException {
        Achievement a = AchievementsInformation.findAchievementsById(6);
        assertEquals(a.getUserId(), 1);
        assertEquals(a.getAchivementName(), "QUIZ_MACHINE");
    }
}