package manipulation;

import com.freeuni.quizwebsite.service.ChallengesInformation;
import com.freeuni.quizwebsite.service.manipulation.ChallengesManipulation;
import org.junit.Test;

import java.sql.SQLException;

import static org.junit.Assert.*;

public class ChallengesManipulationTest {

    @Test
    public void deleteChallengeByReceiverId() throws SQLException {
        ChallengesManipulation.deleteChallengeByReceiverId(9999);
        assertEquals(ChallengesInformation.getUserReceivedChallenges(9999).size(),0);
    }

    @Test
    public void deleteChallengeBySenderId() throws SQLException {
        ChallengesManipulation.deleteChallengeBySenderId(9999);
        assertEquals(ChallengesInformation.getUserSentChallenges(9999).size(),0);
    }

    @Test
    public void deleteChallengeById() throws SQLException {
        int before = ChallengesInformation.getUserReceivedChallenges(1).size();
        ChallengesManipulation.deleteChallengeById(1);
        assertEquals(ChallengesInformation.getUserReceivedChallenges(1).size(),before-1);
    }

    @Test
    public void addChallenge() throws SQLException {
        int before = ChallengesInformation.getUserReceivedChallenges(3).size();
        ChallengesManipulation.addChallenge(1,3,1,"midi midi aba");
        assertEquals(ChallengesInformation.getUserReceivedChallenges(3).size(),before+1);
    }
}