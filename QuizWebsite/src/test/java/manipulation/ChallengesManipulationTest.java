package manipulation;

import com.freeuni.quizwebsite.service.manipulation.ChallengesManipulation;
import org.junit.Test;

import java.sql.SQLException;

import static org.junit.Assert.*;

public class ChallengesManipulationTest {

    @Test
    public void deleteChallengeByReceiverId() throws SQLException {
        ChallengesManipulation.deleteChallengeByReceiverId(1);
    }

    @Test
    public void deleteChallengeBySenderId() throws SQLException {
        ChallengesManipulation.deleteChallengeBySenderId(1);
    }

    @Test
    public void deleteChallengeById() throws SQLException {
        ChallengesManipulation.deleteChallengeById(1);
    }

    @Test
    public void addChallenge() throws SQLException {
        ChallengesManipulation.addChallenge(1,3,1,"midi midi aba");
    }
}