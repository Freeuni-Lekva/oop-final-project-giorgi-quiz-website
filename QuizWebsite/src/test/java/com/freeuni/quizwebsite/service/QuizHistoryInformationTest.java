package com.freeuni.quizwebsite.service;

import com.freeuni.quizwebsite.model.db.QuizHistory;
import org.junit.Test;

import java.sql.SQLException;
import java.util.List;

import static org.junit.Assert.*;

public class QuizHistoryInformationTest {

    @Test
    public void getQuizzesHistoryByQuizId() throws SQLException {
        List<QuizHistory> quizHistoryList = QuizHistoryInformation.getQuizzesHistoryByQuizId(1);
        assertTrue(quizHistoryList.stream().anyMatch(e->e.getUserId()==1));
        assertTrue(quizHistoryList.stream().noneMatch(e -> e.getUserId() == -1));
    }

    @Test
    public void getQuizzesHistoryByUserId() throws SQLException {
        List<QuizHistory> quizHistoryList = QuizHistoryInformation.getQuizzesHistoryByUserId(1);
        assertTrue(quizHistoryList.stream().anyMatch(e->e.getQuizId()==1));
        assertTrue(quizHistoryList.stream().allMatch(e->e.getUserId()==1));
        assertTrue(quizHistoryList.stream().noneMatch(e -> e.getQuizId() == -1));
    }

    @Test
    public void getMaxResultedHistoryOfQuiz() throws SQLException {
        List<QuizHistory> quizHistoryList = QuizHistoryInformation.getMaxResultedHistoryOfQuiz(1);
        assertEquals(95.75,quizHistoryList.get(0).getScore(),0.01);
    }

    @Test
    public void getOrderedByScoreQuizzesHistoryByQuizIdTest() throws SQLException {
        List<QuizHistory> quizHistoryList = QuizHistoryInformation.getOrderedByScoreQuizzesHistoryByQuizId(1);
        assertEquals(4, quizHistoryList.size());
    }
}