package manipulation;

import com.freeuni.quizwebsite.service.AnnouncementInformation;
import com.freeuni.quizwebsite.service.manipulation.AnnouncementManipulation;
import org.junit.Test;

import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.*;


public class AnnouncementManipulationTest {

    @Test
    public void addAnnouncement() throws SQLException {
       AnnouncementManipulation.addAnnouncement(1,"vau vau vau");
        assertEquals( AnnouncementInformation.getCreatedAnnouncementsById(1).size(),3);
    }
    @Test
    public void deleteAnnouncementById() throws SQLException {
        AnnouncementManipulation.deleteUserAnnouncementById(2,2);
        assertEquals( AnnouncementInformation.getCreatedAnnouncementsById(2).size(),0);
    }
    @Test
    public void deleteUserAllAnnouncement() throws SQLException {
        AnnouncementManipulation.deleteUsersAllAnnouncement(3);
        assertEquals( AnnouncementInformation.getCreatedAnnouncementsById(3).size(),0);
    }
}