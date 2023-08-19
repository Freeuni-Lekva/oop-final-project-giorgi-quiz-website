package com.freeuni.quizwebsite.service;

import com.freeuni.quizwebsite.model.QuestionType;
import com.freeuni.quizwebsite.model.db.Question;
import org.junit.jupiter.api.Test;

import java.sql.SQLException;
import java.util.List;

import static com.freeuni.quizwebsite.model.QuestionType.MULTIPLE_CHOICE;
import static com.freeuni.quizwebsite.service.QuestionInformation.getQuestionsInQuiz;
import static org.junit.jupiter.api.Assertions.*;

class QuestionInformationTest {

    @Test
    void getQuestionTest() throws SQLException {
        Question question1 = QuestionInformation.getQuestion(1);
        assert question1 != null;

        Question question2 = QuestionInformation.getQuestion(2);
        assert question2 != null;
    }

    @Test
    void getQuestionsInQuizTest() throws SQLException {
        List<Question> questions1 = QuestionInformation.getQuestionsInQuiz(1);
        assertEquals(questions1.size(), 1);

        List<Question> questions2 = QuestionInformation.getQuestionsInQuiz(2);
        assertTrue(questions2.isEmpty());
    }

    @Test
    void getCorrectAnswersTest() throws SQLException {
        List<String> answers1 = QuestionInformation.getCorrectAnswers(1);
        assertTrue(answers1.contains("Giorgi"));
        assertTrue(answers1.contains("Gio"));
        assertEquals(answers1.size(), 2);

        List<String> answers2 = QuestionInformation.getCorrectAnswers(2);
        assertFalse(answers2.contains("deda"));
        assertEquals(answers2.size(), 2);

        List<String> answers3 = QuestionInformation.getCorrectAnswers(3);
        assertFalse(answers3.isEmpty());
    }

    @Test
    void getPossibleAnswersTest() throws SQLException {
        List<String> answers = QuestionInformation.getPossibleAnswers(2);
        assertFalse(answers.contains("deda"));

        List<String> answers1 = QuestionInformation.getPossibleAnswers(1);
        assertTrue(answers1.isEmpty());
    }
    @Test
    void getQuestionsForQuiz10000() throws SQLException {
        List<Question> questions = QuestionInformation.getQuestionsInQuiz(10000);
        assertEquals(questions.size(), 9);
    }

}