package com.freeuni.quizwebsite.service.manipulation;

import org.junit.Test;

import java.sql.SQLException;
import java.sql.Timestamp;

import static org.junit.Assert.*;

public class QuizHistoryManipulationTest {

    @Test
    public void deleteFromQuizHistoryByQuizId() throws SQLException {
        QuizHistoryManipulation.deleteFromQuizHistoryByQuizId(1);
    }

    @Test
    public void deleteFromQuizHistoryByUserId() throws SQLException {
        QuizHistoryManipulation.deleteFromQuizHistoryByUserId(1);
    }

    @Test
    public void deleteFromQuizHistoryBeforeT() throws SQLException {
        Timestamp T = new Timestamp(120, 6, 11, 10, 30, 0, 0);
        QuizHistoryManipulation.deleteFromQuizHistoryBeforeT(T);
    }

    @Test
    public void deleteUserIDsQuizesHistoryBeforeT() throws SQLException {
        Timestamp T = new Timestamp(120, 6, 11, 10, 30, 0, 0);
        QuizHistoryManipulation.deleteUserIDsQuizesHistoryBeforeT(1,T);
    }
    //

    @Test
    public void deleteFromQuizHistoryAfterT() throws SQLException {
        Timestamp T = new Timestamp(120, 6, 11, 10, 30, 0, 0);
        QuizHistoryManipulation.deleteFromQuizHistoryAfterT(T);
    }

    @Test
    public void deleteUserIDsQuizesHistoryAfterT() throws SQLException {
        Timestamp T = new Timestamp(120, 6, 11, 10, 30, 0, 0);
        QuizHistoryManipulation.deleteUserIDsQuizesHistoryAfterT(1,T);
    }

    @Test
    public void deleteLowScores() throws SQLException {
        QuizHistoryManipulation.deleteLowScores(0.25);
    }

    @Test
    public void deleteUsersLowScores() throws SQLException {
        QuizHistoryManipulation.deleteUsersLowScores(0.45,1);
    }

    @Test
    public void deleteHighScores() throws SQLException {
        QuizHistoryManipulation.deleteHighScores(0.86);
    }

    @Test
    public void deleteUsersHighScores() throws SQLException {
        QuizHistoryManipulation.deleteUsersHighScores(0.5,1);
    }

    @Test
    public void addQuizHistory() throws SQLException {
        assertEquals(0,QuizHistoryManipulation.addQuizHistory(1,3,1));
        assertEquals(-1,QuizHistoryManipulation.addQuizHistory(1000000000,3,1));
    }


}