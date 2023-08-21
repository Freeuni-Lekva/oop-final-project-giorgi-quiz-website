package manipulation;

import com.freeuni.quizwebsite.model.RelationshipStatus;
import com.freeuni.quizwebsite.model.db.Friend;
import com.freeuni.quizwebsite.model.db.User;
import com.freeuni.quizwebsite.service.FriendsInformation;
import com.freeuni.quizwebsite.service.UsersInformation;
import com.freeuni.quizwebsite.service.manipulation.FriendsManipulation;
import org.junit.jupiter.api.Test;

import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.*;

class FriendsManipulationTest {

    @Test
    void addFriendTest() throws SQLException {
        Friend f = new Friend(7,8);
        FriendsManipulation.addFriend(f);
        assertTrue(FriendsInformation.areFriends(7,8));
    }

    @Test
    void addFriendByIdsTest() throws SQLException {
        FriendsManipulation.addFriendByIds(3,4);
        assertTrue(FriendsInformation.areFriends(3,4));
    }

    @Test
    void deleteFriendTest() throws SQLException {
        Friend f = new Friend(9999,10001);
        FriendsManipulation.deleteFriend(f);
        assertFalse(FriendsInformation.areFriends(9999,10001));
    }

    @Test
    void deleteFriendByIdsTest() throws SQLException {
        FriendsManipulation.deleteFriendByIds(5,6);
        assertFalse(FriendsInformation.areFriends(5,6));
    }

    @Test
    void deleteAllFriendsTest() throws SQLException {
        User u = UsersInformation.findUserByUserName("TestUserAdmin");
        FriendsManipulation.deleteAllFriends(u);
        assertEquals(FriendsInformation.getFriends(u.getUserId()).size(),0);
    }

    @Test
    void deleteAllFriendsByIdTest() throws SQLException {
        FriendsManipulation.deleteAllFriendsById(10000);
        assertEquals(FriendsInformation.getFriends(10000).size(),0);
    }

    @Test
    void updateStatusTest() throws SQLException {
        Friend f = new Friend(3,2);
        FriendsManipulation.updateStatus(f, RelationshipStatus.BESTIES);
        assertTrue(FriendsInformation.areOfStatus(3,2, String.valueOf(RelationshipStatus.BESTIES)));
    }
}