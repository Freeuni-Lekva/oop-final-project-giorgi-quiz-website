package com.freeuni.quizwebsite.service.manipulation;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;
import com.freeuni.quizwebsite.model.db.FriendRequest;
import com.freeuni.quizwebsite.service.FriendRequestInformation;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class FriendRequestManipulationTest {

    private static final Connection connection = ConnectToDB.getConnection();

    @Test
    void addFriendRequestByIdTest() throws SQLException {
        FriendRequestManipulation.addFriendRequestByIds(2, 4);
        FriendRequestManipulation.addFriendRequestByIds(2, 3);
        List<Integer> receiverIds1 = getReceiverIds(2);

        assertTrue(receiverIds1.contains(4));
        assertTrue(receiverIds1.contains(3));
        assertFalse(receiverIds1.contains(1));
        assertFalse(receiverIds1.contains(2));

        connection.prepareStatement("DELETE FROM FRIEND_REQUESTS " +
                                        " WHERE user_one = 2").executeUpdate();

//        FriendRequestManipulation.addFriendRequestByIds(2, 3);
//        List<Integer> receiverIds2 = getReceiverIds(2);
//        assertEquals(2, receiverIds2.size());
    }

    @Test
    void addFriendRequestTest() throws SQLException {
        FriendRequest fr1 = new FriendRequest(4, 1, null);
        FriendRequest fr2 = new FriendRequest(4, 3, null);
        FriendRequestManipulation.addFriendRequest(fr1);
        FriendRequestManipulation.addFriendRequest(fr2);
        List<Integer> receiverIds1 = getReceiverIds(4);

        assertTrue(receiverIds1.contains(1));
        assertTrue(receiverIds1.contains(3));
        assertFalse(receiverIds1.contains(2));
        assertFalse(receiverIds1.contains(4));

        connection.prepareStatement("DELETE FROM FRIEND_REQUESTS " +
                                        "WHERE user_one = 4 AND (user_two = 1 OR user_two = 3)").executeUpdate();
    }

    @Test
    void deleteFriendRequestByIdsTest() throws SQLException {
        FriendRequestManipulation.deleteFriendRequestByIds(1, 3);
        List<Integer> receiverIds1 = getReceiverIds(1);
        assertFalse(receiverIds1.contains(3));
        FriendRequestManipulation.deleteFriendRequestByIds(1, 4);
        List<Integer> receiverIds2 = getReceiverIds(1);
        assertTrue(receiverIds2.isEmpty());

        connection.prepareStatement("INSERT INTO FRIEND_REQUESTS (user_one, user_two) " +
                "VALUES (1, 3), (1, 4);").executeUpdate();
    }

    @Test
    void deleteFriendRequestTest() throws SQLException {
        List<FriendRequest> sentBy1 = FriendRequestInformation.getSentFriendRequests(1);
        int size = sentBy1.size();
        for(FriendRequest fr : sentBy1) {
            FriendRequestManipulation.deleteFriendRequest(fr);
            int removedSenderId = fr.getUserOneId();
            assertFalse(getReceiverIds(1).contains(removedSenderId));
            assertEquals(--size, FriendRequestInformation.getSentFriendRequests(1).size());
        }

        connection.prepareStatement("INSERT INTO FRIEND_REQUESTS (user_one, user_two) " +
                                        "VALUES (1, 3), (1, 4);").executeUpdate();
    }

    private List<Integer> getReceiverIds(int senderId) throws SQLException {
        List<FriendRequest> requests = FriendRequestInformation.getSentFriendRequests(senderId);
        List<Integer> receivers = new ArrayList<>();;
        for(FriendRequest fr : requests) {
            receivers.add(fr.getUserTwoId());
        }
        return receivers;
    }

}