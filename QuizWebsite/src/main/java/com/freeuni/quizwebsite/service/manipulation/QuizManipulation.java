package com.freeuni.quizwebsite.service.manipulation;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;
import com.freeuni.quizwebsite.model.db.Quiz;
import com.freeuni.quizwebsite.service.QuestionInformation;
import com.freeuni.quizwebsite.service.QuizzesInformation;
import com.freeuni.quizwebsite.service.UsersInformation;

import java.sql.*;
import java.util.List;

public class QuizManipulation {
    private static final Connection connection = ConnectToDB.getConnection();

    public static void deleteQuizByQuizId(int quizId) throws SQLException {
        connection.prepareStatement("DELETE FROM quizes WHERE quiz_id = " + quizId +";").executeUpdate();
        QuestionsManipulation.deleteQuestionByQuizId(quizId);
    }
    public static void deleteQuizByName(String name) throws SQLException {
        List<Quiz> ql=QuizzesInformation.findQuizzesByName(name);
        for (Quiz q:ql) {
            QuestionsManipulation.deleteQuestionByQuizId(q.getQuizId());

        }
        connection.prepareStatement("DELETE FROM quizes WHERE name = \"" +name+"\";").executeUpdate();

    }
    public static void deleteQuizByUserIDAndName(int userId,String name) throws SQLException {
        List<Quiz> ql=QuizzesInformation.findQuizzesByName(name);
        for (Quiz q:ql) {
            if(q.getUserId()==userId){
                QuestionsManipulation.deleteQuestionByQuizId(q.getQuizId());
            }


        }

        connection.prepareStatement("DELETE FROM quizes WHERE name = \"" +name+"\" and user_id ="+userId+";").executeUpdate();
    }


    public static void deleteQuizByUserId(int userId) throws SQLException {
        List<Quiz> ql=QuizzesInformation.findQuizzesByUserId(userId);
        for (Quiz q:ql) {
            QuestionsManipulation.deleteQuestionByQuizId(q.getQuizId());
        }
        connection.prepareStatement("DELETE FROM quizes WHERE user_id = " + userId +";").executeUpdate();
    }

    public static int addQuiz(int userId,String name, String description,boolean sorted,boolean oneOrMultiple
            ,boolean instantFeedback, boolean practiceMode, String quizStates,int viewCount
    ) throws SQLException {

        if(UsersInformation.findUserById(userId)==null){
            return -1;
        }

        PreparedStatement ps =connection.prepareStatement("INSERT INTO quizes (user_id, name, description, sorted, one_or_multiple" +
                ", instant_feedback, practice_mode,quiz_state,view_count) VALUES (?,?,?,?,?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
        ps.setInt(1, userId);
        ps.setString(2, name);
        ps.setString(3, description);
        ps.setBoolean(4, sorted);
        ps.setBoolean(5, oneOrMultiple);
        ps.setBoolean(6, instantFeedback);
        ps.setBoolean(7, practiceMode);
        ps.setString(8, quizStates);
        ps.setInt(9, viewCount);
        ps.executeUpdate();
        ResultSet generatedKeys = ps.getGeneratedKeys();
        if(generatedKeys.next()) {
            return generatedKeys.getInt(1);
        } else {
            throw new SQLException("Failed to get the generated quiz_id."); //this is the line that is not covered in the tests
        }
    }

    public static void addTagsToQuiz(int quizId, String tag) throws SQLException {
        connection.prepareStatement("INSERT INTO TAGS  (quiz_id, tag_name) " +
                "VALUES (" + quizId + ", '" + tag + "')").executeUpdate();
    }

    public static void increaseQuizViewCount(int quizId) throws SQLException {
        PreparedStatement ps = connection.prepareStatement(
                "UPDATE quizes SET view_count = view_count + 1 WHERE quiz_id = ?"
        );
        ps.setInt(1, quizId);
        ps.executeUpdate();
    }

}
