package com.freeuni.quizwebsite.service.manipulation;

import com.freeuni.quizwebsite.service.NoteMailInformation;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.*;

class NoteMailManipulationTest {

    @Test
    void deleteAllMailBySenderId() throws SQLException {
        System.out.println("1");
        assertEquals(2, NoteMailInformation.getUserSentNotes(2).size());
        NoteMailManipulation.deleteAllMailBySenderId(2);
        assertEquals(0, NoteMailInformation.getUserSentNotes(2).size());
    }

    @Test
    void deleteAllMailByReceiverId() throws SQLException {
        System.out.println("2");
        assertEquals(1, NoteMailInformation.getUserReceivedNotes(3).size());
        NoteMailManipulation.deleteAllMailByReceiverId(3);
        assertEquals(0, NoteMailInformation.getUserReceivedNotes(3).size());
    }

    @Test
    void deleteNoteMailByMailId() throws SQLException {
        System.out.println("3");
        int mailId = NoteMailManipulation.addNoteMail(4, 3, "damamate");
       assertEquals(1, NoteMailInformation.getUserSentNotes(4).size());
       NoteMailManipulation.deleteNoteMailByMailId(mailId);
       assertEquals(0, NoteMailInformation.getUserSentNotes(4).size());
    }

    @BeforeAll
    static void addNoteMail1() throws SQLException {
        System.out.println("4");
        assertEquals(1, NoteMailInformation.getUserSentNotes(1).size());
        NoteMailManipulation.addNoteMail(2, 1, "damamate");
        NoteMailManipulation.addNoteMail(2, 4, "damamate");
        assertEquals(1, NoteMailInformation.getUserSentNotes(1).size());
        assertEquals(2, NoteMailInformation.getUserSentNotes(2).size());
        assertEquals(1, NoteMailInformation.getUserReceivedNotes(3).size());
    }

    @AfterAll
    static void addNoteMail2() throws SQLException {
        assertEquals(0, NoteMailInformation.getUserSentNotes(1).size());
        NoteMailManipulation.addNoteMail(1, 3, "damamate");
        assertEquals(1, NoteMailInformation.getUserSentNotes(1).size());
    }
}