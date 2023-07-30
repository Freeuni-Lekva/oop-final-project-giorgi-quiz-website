package com.freeuni.quizwebsite.service.manipulation;

import org.junit.Test;

import java.sql.SQLException;
import java.sql.Timestamp;

import static org.junit.Assert.*;

public class QuizManipulationTest {

    @Test
    public void deleteQuizByQuizId() throws SQLException {
        QuizManipulation.deleteQuizByQuizId(1);
    }

    @Test
    public void deleteQuizByName() throws SQLException {
        QuizManipulation.deleteQuizByName("Cars quiz");
    }

    @Test
    public void deleteQuizByUserIDAndName() throws SQLException {
        QuizManipulation.deleteQuizByUserIDAndName(1,"History quiz");
    }



    @Test
    public void deleteQuizesBeforeT() throws SQLException {

        Timestamp T = new Timestamp(120, 6, 11, 10, 30, 0, 0);
        QuizManipulation.deleteQuizesBeforeT(T);
    }

    @Test
    public void deleteUserIDsQuizesBeforeT() throws SQLException {
        Timestamp T = new Timestamp(120, 6, 11, 10, 30, 0, 0);
        QuizManipulation.deleteUserIDsQuizesBeforeT(1,T);
    }

    @Test
    public void deleteQuizesAfterT() throws SQLException {
        Timestamp T = new Timestamp(120, 6, 11, 10, 30, 0, 0);
        QuizManipulation.deleteQuizesAfterT(T);
    }

    @Test
    public void deleteUserIDsQuizesAfterT() throws SQLException {
        Timestamp T = new Timestamp(120, 6, 11, 10, 30, 0, 0);
        QuizManipulation.deleteUserIDsQuizesAfterT(1,T);
    }
    @Test
    public void deleteQuizByUserId() throws SQLException {
        QuizManipulation.deleteQuizByUserId(1);
    }
    //
    @Test
    public void addQuiz() throws SQLException {
        assertEquals(0,QuizManipulation.addQuiz(1,"new quizzz","test Quiz",true,false,true,false,"PUBLISHED",2));
        assertEquals(-1,QuizManipulation.addQuiz(10000000,"new quizzz","test Quiz",true,false,true,false,"PUBLISHED",2));

    }



}