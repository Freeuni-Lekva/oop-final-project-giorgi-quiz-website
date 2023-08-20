package com.freeuni.quizwebsite.service;

import com.freeuni.quizwebsite.model.db.Challenge;
import com.freeuni.quizwebsite.model.db.NoteMail;
import org.junit.jupiter.api.Test;

import java.sql.SQLException;
import java.util.ArrayList;

import static org.junit.jupiter.api.Assertions.*;

class NoteMailInformationTest {

    @Test
    void getUserSentNotes() throws SQLException {
        ArrayList<NoteMail> mariamSent = NoteMailInformation.getUserSentNotes(1);
        assertEquals(mariamSent.size(), 3);
        NoteMail mail = mariamSent.get(0);
        assertEquals(mail.getReceiverUserId(), 3);
        assertEquals(mail.getNote(), "damamate");

        ArrayList<NoteMail> sandrikaSent = NoteMailInformation.getUserSentNotes(3);
        assertEquals(sandrikaSent.size(), 0);
    }

    @Test
    void getUserReceivedNotes() throws SQLException {
        ArrayList<NoteMail> sandrikaReceived = NoteMailInformation.getUserReceivedNotes(3);
        assertEquals(sandrikaReceived.size(), 1);
        NoteMail mail = sandrikaReceived.get(0);
        assertEquals(mail.getReceiverUserId(), 3);
        assertEquals(mail.getNote(), "damamate");

        ArrayList<NoteMail> tamaziReceived = NoteMailInformation.getUserReceivedNotes(2);
        assertEquals(tamaziReceived.size(), 0);
    }
}