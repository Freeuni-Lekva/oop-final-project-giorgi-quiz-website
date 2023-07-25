package com.freeuni.quizwebsite.service.manipulation;

import com.freeuni.quizwebsite.service.NoteMailInformation;
import org.junit.jupiter.api.Test;

import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.*;

class NoteMailManipulationTest {

    @Test
    void deleteAllMailBySenderId() throws SQLException {
//        assertEquals(2, NoteMailInformation.getUserSentNotes(1).size());
        NoteMailManipulation.deleteAllMailBySenderId(1);
//        assertEquals(0, NoteMailInformation.getUserSentNotes(1).size());
    }

    @Test
    void deleteAllMailByReceiverId() {
    }

    @Test
    void deleteNoteMailByMailId() {
    }

    @Test
    void deleteNoteMailsOlderThan() {
    }

    @Test
    void addNoteMail() {
    }
}