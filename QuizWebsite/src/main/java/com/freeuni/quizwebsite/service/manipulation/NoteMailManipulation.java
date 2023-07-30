package com.freeuni.quizwebsite.service.manipulation;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;

import java.sql.*;

public class NoteMailManipulation {

    private static final Connection connection = ConnectToDB.getConnection();

    //deletes all mail sent by the specified user
    public static void deleteAllMailBySenderId(int senderUser) throws SQLException {
        connection.prepareStatement("DELETE FROM NOTE_MAIL WHERE sender_user = " + senderUser).executeUpdate();
    }

    //deletes all mail received by the specified user
    public static void deleteAllMailByReceiverId(int receiverUser) throws SQLException {
        connection.prepareStatement("DELETE FROM NOTE_MAIL WHERE receiver_user = " + receiverUser).executeUpdate();
    }

    //deletes a mail having the specified id
    public static void deleteNoteMailByMailId(int mailId) throws SQLException {
        connection.prepareStatement("DELETE FROM NOTE_MAIL WHERE mail_id = " + mailId).executeUpdate();
    }

    //adds a noteMail given the sender user (id), receiver user (id), and the text, returns id of that mail
    public static int addNoteMail(int senderId, int receiverId, String note) throws SQLException {
        String update = "INSERT INTO NOTE_MAIL (sender_user, receiver_user, note) " +
                "VALUES (" + senderId + ", " + receiverId + ", '" + note + "')";
        PreparedStatement preparedStatement = connection.prepareStatement(update, Statement.RETURN_GENERATED_KEYS);
        preparedStatement.executeUpdate();
        ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
        if(generatedKeys.next()) {
            return generatedKeys.getInt(1);
        } else {
            throw new SQLException("Failed to get the generated mail_id."); //this is the line that is not covered in the tests
        }
        //return generatedKeys.next() ? generatedKeys.getInt(1) : -1;
    }
}
