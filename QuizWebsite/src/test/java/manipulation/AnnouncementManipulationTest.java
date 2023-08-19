package manipulation;

import com.freeuni.quizwebsite.service.manipulation.AnnouncementManipulation;
import org.junit.Test;

import java.sql.SQLException;

public class AnnouncementManipulationTest {

    @Test
    public void addAnnouncement() throws SQLException {
        System.out.println(AnnouncementManipulation.addAnnouncement(1,"vau vau vau"));
    }
    @Test
    public void deleteAnnouncementById() throws SQLException {
        AnnouncementManipulation.deleteUserAnnouncementById(1,1);
    }
    @Test
    public void deleteUserAllAnnouncement() throws SQLException {
        AnnouncementManipulation.deleteUsersAllAnnouncement(1);
    }
}