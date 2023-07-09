package com.freeuni.quizwebsite.service;

import com.freeuni.quizwebsite.model.QuizStates;
import com.freeuni.quizwebsite.model.db.Quiz;
import org.junit.Test;

import java.sql.SQLException;
import java.util.List;

import static org.junit.Assert.*;

public class QuizesInformationTest {

    @Test
    public void findQuizById() throws SQLException {

        Quiz quiz = QuizzesInformation.findQuizById(1);
        assert quiz != null;

        assertEquals(quiz.getName(),"Cars quiz");
        assertEquals(quiz.getUserId(),1);
    }

    @Test
    public void findQuizzesByUserId() throws SQLException {
        List<Quiz> quizzes = QuizzesInformation.findQuizzesByUserId(1);
        assert quizzes !=null;
        assertEquals(quizzes.size(),2);
    }


    @Test
    public void findQuizzesByName() throws SQLException {
        List<Quiz> quizzes1 = QuizzesInformation.findQuizzesByName("math");
        List<Quiz> quizzes2 = QuizzesInformation.findQuizzesByName("car");
        List<Quiz> quizzes3 = QuizzesInformation.findQuizzesByName("");
        assertEquals(0,quizzes1.size());
        assertEquals(1,quizzes2.size());
    }

    @Test
    public void findQuizzesByDescription() throws SQLException {
        List<Quiz> quizzes1 = QuizzesInformation.findQuizzesByDescription("math");
        List<Quiz> quizzes2 = QuizzesInformation.findQuizzesByDescription("education");
        List<Quiz> quizzes3 = QuizzesInformation.findQuizzesByDescription("");
        assertEquals(0,quizzes1.size());
        assertEquals(1,quizzes2.size());
    }

    @Test
    public void getPublicQuizzesByViews() throws SQLException {
        List<Quiz> quizzes = QuizzesInformation.getPublicQuizzesOrderedByViews();
        if(quizzes.size()>=2) {
            assertTrue(quizzes.get(0).getViewCount()>=quizzes.get(1).getViewCount());
        }
    }
}