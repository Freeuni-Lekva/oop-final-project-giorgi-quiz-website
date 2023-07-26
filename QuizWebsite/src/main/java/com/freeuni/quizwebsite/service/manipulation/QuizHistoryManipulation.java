package com.freeuni.quizwebsite.service.manipulation;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;
import com.freeuni.quizwebsite.service.UsersInformation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;

public class QuizHistoryManipulation {
    private static final Connection connection = ConnectToDB.getConnection();

    public static void deleteFromQuizHistoryByQuizId(int quizId) throws SQLException {
        connection.prepareStatement("DELETE FROM QUIZ_HISTORY  WHERE quiz_id = " + quizId +";").executeUpdate();
    }
    public static void deleteFromQuizHistoryByUserId(int userId) throws SQLException {
        connection.prepareStatement("DELETE FROM QUIZ_HISTORY  WHERE user_id = " + userId +";").executeUpdate();
    }

    public static void deleteFromQuizHistoryBeforeT(Timestamp T) throws SQLException {
        connection.prepareStatement("DELETE FROM QUIZ_HISTORY  WHERE take_date < \""+T+"\";").executeUpdate();
    }
    public static void deleteUserIDsQuizesHistoryBeforeT(int userId,Timestamp T) throws SQLException {
        connection.prepareStatement("DELETE FROM QUIZ_HISTORY  WHERE take_date < \"" +T+"\" and user_id ="+userId+";").executeUpdate();
    }

    public static void deleteFromQuizHistoryAfterT(Timestamp T) throws SQLException {
        connection.prepareStatement("DELETE FROM QUIZ_HISTORY  WHERE take_date >= \""+T+"\"").executeUpdate();
    }
    public static void deleteUserIDsQuizesHistoryAfterT(int userId,Timestamp T) throws SQLException {
        connection.prepareStatement("DELETE FROM QUIZ_HISTORY  WHERE take_date >= \"" +T+"\" and user_id ="+userId+";").executeUpdate();
    }

    public static void deleteLowScores(double minScore) throws SQLException{
        connection.prepareStatement("DELETE FROM QUIZ_HISTORY  WHERE score < "+minScore+";").execute();
    }
    public static void deleteUsersLowScores(double minScore, int userID) throws SQLException{
        connection.prepareStatement("DELETE FROM QUIZ_HISTORY  WHERE score < "+minScore+" and user_id ="+userID+";").execute();
    }
    public static void deleteHighScores(double maxScore) throws SQLException{
        connection.prepareStatement("DELETE FROM QUIZ_HISTORY  WHERE score > "+maxScore+";").execute();
    }
    public static void deleteUsersHighScores(double maxScore, int userID) throws SQLException{
        connection.prepareStatement("DELETE FROM QUIZ_HISTORY  WHERE score > "+maxScore+" and user_id ="+userID+";").execute();
    }





    public static int addQuizHistory(int user_Id, int quiz_ID,double score
    ) throws SQLException {

        if(UsersInformation.findUserById(user_Id)==null){
            return -1;
        }

        PreparedStatement ps =connection.prepareStatement("INSERT INTO QUIZ_HISTORY (user_id,quiz_id,score ) VALUES (?,?,?)");
        ps.setInt(1, user_Id);
        ps.setInt(2, quiz_ID);
        ps.setDouble(3, score);
        ps.executeUpdate();
        return 0;
    }
}
