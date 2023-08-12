package com.freeuni.quizwebsite.service;

import com.freeuni.quizwebsite.model.QuestionType;
import com.freeuni.quizwebsite.model.db.Question;
import org.junit.jupiter.api.Test;

import java.sql.SQLException;
import java.util.List;

import static com.freeuni.quizwebsite.service.QuestionInformation.getQuestionsInQuiz;
import static org.junit.jupiter.api.Assertions.*;

class QuestionInformationTest {

//    @Test
//    void getQuestionTest() throws SQLException {
//        Question question1 = QuestionInformation.getQuestion(1);
//        assert question1 != null;
//        Question question1Desired = new Question(1, "Ra hqvia Giorgis?", "QUESTION_RESPONSE", 1,0);
//        assertEquals(question1, question1Desired);
//
//        Question question2 = QuestionInformation.getQuestion(2);
//        assert question2 != null;
//        Question question2Desired = new Question(2, "Vin misca kalata witelqudas?", "QuestionType."MULTIPLE_CHOICE", 1,1);
//        assertEquals(question2, question2Desired);
//    }
//
//    @Test
//    void getQuestionsInQuizTest() throws SQLException {
//        Question question1 = new Question(1, "Ra hqvia Giorgis?", QuestionType.QUESTION_RESPONSE, 1,0);
//        Question question2 = new Question(2, "Vin misca kalata witelqudas?", QuestionType.MULTIPLE_CHOICE, 1,0);
//        List<Question> questions1 = QuestionInformation.getQuestionsInQuiz(1);
//        assertTrue(questions1.contains(question1));
//        assertTrue(questions1.contains(question2));
//        assertEquals(questions1.size(), 2);
//
//        List<Question> questions2 = QuestionInformation.getQuestionsInQuiz(2);
//        assertTrue(questions2.isEmpty());
//    }
//
//    @Test
//    void getCorrectAnswersTest() throws SQLException {
//        List<String> answers1 = QuestionInformation.getCorrectAnswers(1);
//        assertTrue(answers1.contains("Giorgi"));
//        assertTrue(answers1.contains("Gio"));
//        assertEquals(answers1.size(), 2);
//
//        List<String> answers2 = QuestionInformation.getCorrectAnswers(2);
//        assertTrue(answers2.contains("deda"));
//        assertEquals(answers2.size(), 1);
//
//        List<String> answers3 = QuestionInformation.getCorrectAnswers(3);
//        assertTrue(answers3.isEmpty());
//    }
//
//    @Test
//    void getPossibleAnswersTest() throws SQLException {
//        List<String> answers = QuestionInformation.getPossibleAnswers(2);
//        assertTrue(answers.contains("deda"));
//        assertTrue(answers.contains("da"));
//        assertTrue(answers.contains("dzma"));
//        assertTrue(answers.contains("mama"));
//
//        assertEquals(answers.size(), 4);
//
//        List<String> answers1 = QuestionInformation.getPossibleAnswers(1);
//        assertTrue(answers1.isEmpty());
//    }
    @Test
    void getQuestionsForQuiz10000() throws SQLException {
        List<Question> questions = QuestionInformation.getQuestionsInQuiz(10000);
        System.out.println(questions.size());
    }

}