package manipulation;

import com.freeuni.quizwebsite.model.QuestionType;
import com.freeuni.quizwebsite.service.QuestionInformation;
import com.freeuni.quizwebsite.service.QuizzesInformation;
import com.freeuni.quizwebsite.service.manipulation.QuestionsManipulation;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.*;

class QuestionsManipulationTest {
    private static int a, b, c;

    @AfterAll
    static void deleteQuestionById() throws SQLException {
        int size = QuestionInformation.getQuestionsInQuiz(5).size();
        QuestionsManipulation.deleteQuestionById(b);
        assertEquals(0, QuestionInformation.getPossibleAnswers(b).size());
        assertEquals(0, QuestionInformation.getCorrectAnswers(b).size());
        assertEquals(size - 1, QuestionInformation.getQuestionsInQuiz(5).size());
    }

    @Test
    void deleteQuestionByQuizId() throws SQLException {
        assertEquals(1, QuestionInformation.getQuestionsInQuiz(4).size());
        QuestionsManipulation.deleteQuestionByQuizId(4);
        assertEquals(0, QuestionInformation.getQuestionsInQuiz(4).size());
    }

    //tests adding questions using two methods explicitly (and one implicitly, since these two methods call one other public method internally)
    @BeforeAll
    static void addQuestions() throws SQLException {
       //a = QuestionsManipulation.addQuestion(5, "", QuestionType.QUESTION_RESPONSE.toString(), "Which team won the last world cup?", 0);
       b = QuestionsManipulation.addQuestion(5, QuestionType.MULTIPLE_CHOICE.toString(), "what are the dividers of 15?");
       c = QuestionsManipulation.addQuestion(4, QuestionType.QUESTION_RESPONSE.toString(), "What is convolution?", 0);
    }

    @Test
    void addPossibleAnswer() throws SQLException {
        assertEquals(0, QuestionInformation.getPossibleAnswers(b).size());
        QuestionsManipulation.addPossibleAnswer(b, "1");
        QuestionsManipulation.addPossibleAnswer(b, "3");
        QuestionsManipulation.addPossibleAnswer(b, "5");
        QuestionsManipulation.addPossibleAnswer(b, "15");
        QuestionsManipulation.addPossibleAnswer(b, "14");
        QuestionsManipulation.addPossibleAnswer(b, "2");
        assertEquals(6, QuestionInformation.getPossibleAnswers(b).size());
    }

    @Test
    void addCorrectAnswer() throws SQLException {
        assertEquals(0, QuestionInformation.getCorrectAnswers(b).size());
        QuestionsManipulation.addCorrectAnswer(b, "1");
        QuestionsManipulation.addCorrectAnswer(b, "3");
        QuestionsManipulation.addCorrectAnswer(b, "5");
        QuestionsManipulation.addCorrectAnswer(b, "15");
        assertEquals(4, QuestionInformation.getCorrectAnswers(b).size());
    }
}