package manipulation;

import com.freeuni.quizwebsite.service.AchievementsInformation;
import com.freeuni.quizwebsite.service.manipulation.AchievementsManipulation;
import org.junit.jupiter.api.Test;

import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.*;

class AchievementsManipulationTest {

    @Test
    void deleteAchievementsByUserId() throws SQLException {

        AchievementsManipulation.deleteAchievementsByUserId(1);
        assertEquals(AchievementsInformation.findAchievementsByUserId(1).size(),0);

    }

    @Test
    void deleteAchievementsByUserIdAndAchievement() throws SQLException {
        int before = AchievementsInformation.findAchievementsByUserId(2).size();
        AchievementsManipulation.deleteAchievementsByUserIdAndAchievement(2,"QUIZ_MACHINE");
        assertEquals(AchievementsInformation.findAchievementsByUserId(2).size(),before-1);
    }

    @Test
    void deleteAchievementsById() throws SQLException {
        int before = AchievementsInformation.findAchievementsByUserId(10001).size();
        AchievementsManipulation.deleteAchievementsById(6);
        assertEquals(AchievementsInformation.findAchievementsByUserId(10001).size(),before-1);
    }

    @Test
    void addAchievementTest() throws SQLException {
        int before = AchievementsInformation.findAchievementsByUserId(9999).size();
        AchievementsManipulation.addAchievement(9999, "QUIZ_MACHINE");

        assertEquals(AchievementsInformation.findAchievementsByUserId(9999).size(),before+1);
    }
}