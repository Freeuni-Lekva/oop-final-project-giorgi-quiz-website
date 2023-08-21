package manipulation;

import com.freeuni.quizwebsite.service.QuizzesInformation;
import com.freeuni.quizwebsite.service.manipulation.QuizManipulation;
import org.junit.Test;

import java.sql.SQLException;
import java.sql.Timestamp;

import static org.junit.Assert.*;

public class QuizManipulationTest {

    @Test
    public void deleteQuizByQuizId() throws SQLException {
        String s = QuizzesInformation.findQuizById(9998).getName();
        QuizManipulation.deleteQuizByQuizId(9998);
        assertEquals(QuizzesInformation.findQuizzesByName(s).size(),0);
    }

    @Test
    public void deleteQuizByName() throws SQLException {
        QuizManipulation.deleteQuizByName("Cars quiz");
        assertEquals(QuizzesInformation.findQuizzesByName("Cars quiz").size(),0);
    }

    @Test
    public void deleteQuizByUserIDAndName() throws SQLException {
        int i =QuizzesInformation.findQuizzesByName("History quiz").size();
        QuizManipulation.deleteQuizByUserIDAndName(1,"History quiz");
        assertEquals(QuizzesInformation.findQuizzesByName("History quiz").size(),i-1);
    }




    @Test
    public void deleteQuizByUserId() throws SQLException {
        QuizManipulation.deleteQuizByUserId(1);
        assertEquals(QuizzesInformation.findQuizzesByUserId(1).size(),0);
    }
    //
    @Test
    public void addQuiz() throws SQLException {
        QuizManipulation.addQuiz(1,"new quizzz","test Quiz",true,false,true,false,"PUBLISHED",2);
        assertEquals(-1,QuizManipulation.addQuiz(10000000,"new quizzz","test Quiz",true,false,true,false,"PUBLISHED",2));

    }



}