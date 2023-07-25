package com.freeuni.quizwebsite.service.manipulation;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;

public class NoteMailManipulation {
    private static final Connection connection = ConnectToDB.getConnection();

    public static void deleteAllMailBySenderId(int senderUser) throws SQLException {
        connection.prepareStatement("DELETE FROM NOTE_MAIL WHERE sender_user = " + senderUser).executeUpdate();
    }

    public static void deleteAllMailByReceiverId(int receiverUser) throws SQLException {
        connection.prepareStatement("DELETE FROM NOTE_MAIL WHERE receiver_user = " + receiverUser).executeUpdate();
    }

    public static void deleteNoteMailByMailId(int mailId) throws SQLException {
        connection.prepareStatement("DELETE FROM NOTE_MAIL WHERE mail_id = " + mailId).executeUpdate();
    }

    public static void addNoteMail(int senderId, int receiverId, String note) throws SQLException {
        connection.prepareStatement("INSERT INTO NOTE_MAIL (sender_user, receiver_user, note) " +
                "VALUES (" + senderId + ", " + receiverId + ", '" + note + "')").executeUpdate();
    }
}
