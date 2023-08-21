package manipulation;

import com.freeuni.quizwebsite.service.NoteMailInformation;
import com.freeuni.quizwebsite.service.manipulation.NoteMailManipulation;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.*;

class NoteMailManipulationTest {

    @Test
    void deleteAllMailBySenderId() throws SQLException {
        NoteMailManipulation.deleteAllMailBySenderId(2);
        assertEquals(0, NoteMailInformation.getUserSentNotes(2).size());
    }

    @Test
    void deleteAllMailByReceiverId() throws SQLException {
        assertEquals(1, NoteMailInformation.getUserReceivedNotes(3).size());
        NoteMailManipulation.deleteAllMailByReceiverId(3);
        assertEquals(0, NoteMailInformation.getUserReceivedNotes(3).size());
    }

    @Test
    void deleteNoteMailByMailId() throws SQLException {
        int mailId = NoteMailManipulation.addNoteMail(4, 3, "damamate");
       assertEquals(1, NoteMailInformation.getUserSentNotes(4).size());
       NoteMailManipulation.deleteNoteMailByMailId(mailId);
       assertEquals(0, NoteMailInformation.getUserSentNotes(4).size());
    }


    static void addNoteMail1() throws SQLException {
        assertEquals(1, NoteMailInformation.getUserSentNotes(1).size());
        NoteMailManipulation.addNoteMail(2, 1, "damamate");
        NoteMailManipulation.addNoteMail(2, 4, "damamate");
        assertEquals(1, NoteMailInformation.getUserSentNotes(1).size());
        assertEquals(2, NoteMailInformation.getUserSentNotes(2).size());
        assertEquals(1, NoteMailInformation.getUserReceivedNotes(3).size());
    }

    static void addNoteMail2() throws SQLException {
        assertEquals(0, NoteMailInformation.getUserSentNotes(1).size());
        NoteMailManipulation.addNoteMail(1, 3, "damamate");
        assertEquals(1, NoteMailInformation.getUserSentNotes(1).size());
    }
}