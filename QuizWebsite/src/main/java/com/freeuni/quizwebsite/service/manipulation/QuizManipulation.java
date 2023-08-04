package com.freeuni.quizwebsite.service.manipulation;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;
import com.freeuni.quizwebsite.service.QuestionInformation;
import com.freeuni.quizwebsite.service.QuizzesInformation;
import com.freeuni.quizwebsite.service.UsersInformation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;

public class QuizManipulation {
    private static final Connection connection = ConnectToDB.getConnection();

    public static void deleteQuizByQuizId(int quizId) throws SQLException {
        connection.prepareStatement("DELETE FROM quizes WHERE quiz_id = " + quizId +";").executeUpdate();
        QuestionsManipulation.deleteQuestionByQuizId(quizId);
    }
    public static void deleteQuizByName(String name) throws SQLException {
        connection.prepareStatement("DELETE FROM quizes WHERE name = \"" +name+"\";").executeUpdate();

    }
    public static void deleteQuizByUserIDAndName(int userId,String name) throws SQLException {
        connection.prepareStatement("DELETE FROM quizes WHERE name = \"" +name+"\" and user_id ="+userId+";").executeUpdate();
    }


    public static void deleteQuizByUserId(int userId) throws SQLException {
        connection.prepareStatement("DELETE FROM quizes WHERE user_id = " + userId +";").executeUpdate();
    }

    public static void deleteQuizesBeforeT(Timestamp T) throws SQLException {
        connection.prepareStatement("DELETE FROM quizes WHERE creation_date < \""+T+"\";").executeUpdate();
    }
    public static void deleteUserIDsQuizesBeforeT(int userId,Timestamp T) throws SQLException {
        connection.prepareStatement("DELETE FROM quizes WHERE creation_date < \"" +T+"\" and user_id ="+userId+";").executeUpdate();
    }

    public static void deleteQuizesAfterT(Timestamp T) throws SQLException {
        connection.prepareStatement("DELETE FROM quizes WHERE creation_date >= \""+T+"\"").executeUpdate();
    }
    public static void deleteUserIDsQuizesAfterT(int userId,Timestamp T) throws SQLException {
        connection.prepareStatement("DELETE FROM quizes WHERE creation_date >= \"" +T+"\" and user_id ="+userId+";").executeUpdate();
    }

    public static int addQuiz(int userId,String name, String description,boolean sorted,boolean oneOrMultiple
                               ,boolean instantFeedback, boolean practiceMode, String quizStates,int viewCount
                                ) throws SQLException {

        if(UsersInformation.findUserById(userId)==null){
            return -1;
        }

        PreparedStatement ps =connection.prepareStatement("INSERT INTO quizes (user_id, name, description, sorted, one_or_multiple" +
                ", instant_feedback, practice_mode,quiz_state,view_count) VALUES (?,?,?,?,?,?,?,?,?)");
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
        return 0;
    }
}
