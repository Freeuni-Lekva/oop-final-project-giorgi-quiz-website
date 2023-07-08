package com.freeuni.quizwebsite.service;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;
import com.freeuni.quizwebsite.model.db.Challenge;
import com.freeuni.quizwebsite.model.db.NoteMail;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class NoteMailInformation {

    private static final Connection connection = ConnectToDB.getConnection();

    public static ArrayList<NoteMail> getUserSentNotes(int senderId) throws SQLException {
        ArrayList<NoteMail> result = new ArrayList<>();
        ResultSet resultSet;

        resultSet = connection.prepareStatement("SELECT * FROM NOTE_MAIL WHERE SENDER_USER = "
                + senderId).executeQuery();
        NoteMail mail;
        while (resultSet.next()) {
            mail = new NoteMail(resultSet.getInt("sender_user"), resultSet.getInt("receiver_user"),
                    resultSet.getString("note"),
                    resultSet.getTimestamp("send_time"));
            result.add(mail);
        }
        return result;
    }

    public static ArrayList<NoteMail> getUserReceivedNotes(int receiverId) throws SQLException {
        ArrayList<NoteMail> result = new ArrayList<>();
        ResultSet resultSet;

        resultSet = connection.prepareStatement("SELECT * FROM NOTE_MAIL WHERE RECEIVER_USER = "
                + receiverId).executeQuery();
        NoteMail mail;
        while (resultSet.next()) {
            mail = new NoteMail(resultSet.getInt("sender_user"), resultSet.getInt("receiver_user"),
                    resultSet.getString("note"),
                    resultSet.getTimestamp("send_time"));
            result.add(mail);
        }
        return result;
    }
}
