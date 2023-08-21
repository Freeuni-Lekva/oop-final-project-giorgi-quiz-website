package manipulation;

import com.freeuni.quizwebsite.service.QuizHistoryInformation;
import com.freeuni.quizwebsite.service.manipulation.QuizHistoryManipulation;
import org.junit.Test;

import java.sql.SQLException;
import java.sql.Timestamp;

import static org.junit.Assert.*;

public class QuizHistoryManipulationTest {

    @Test
    public void deleteFromQuizHistoryByQuizId() throws SQLException {
        QuizHistoryManipulation.deleteFromQuizHistoryByQuizId(1);
        assertEquals(QuizHistoryInformation.getQuizzesHistoryByQuizId(1).size(),0);
    }

    @Test
    public void deleteFromQuizHistoryByUserId() throws SQLException {
        QuizHistoryManipulation.deleteFromQuizHistoryByUserId(1);
        assertEquals(QuizHistoryInformation.getQuizzesHistoryByUserId(1).size(),0);
    }


    @Test
    public void addQuizHistory() throws SQLException {
        assertEquals(0,QuizHistoryManipulation.addQuizHistory(1,3,1));
        assertEquals(-1,QuizHistoryManipulation.addQuizHistory(1000000000,3,1));
    }


}