package manipulation;

import com.freeuni.quizwebsite.service.manipulation.AchievementsManipulation;
import org.junit.jupiter.api.Test;

import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.*;

class AchievementsManipulationTest {

    @Test
    void deleteAchievementsByUserId() throws SQLException {
        AchievementsManipulation.deleteAchievementsByUserId(1);
    }

    @Test
    void deleteAchievementsByUserIdAndAchievement() throws SQLException {
        AchievementsManipulation.deleteAchievementsById(3);
    }

    @Test
    void deleteAchievementsById() throws SQLException {
        AchievementsManipulation.deleteAchievementsByUserIdAndAchievement(2, "QUIZ_MACHINE");
    }

    @Test
    void addAchievementTest() throws SQLException {
        AchievementsManipulation.addAchievement(1, "QUIZ_MACHINE");
    }
}