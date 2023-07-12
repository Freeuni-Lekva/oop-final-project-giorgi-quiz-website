package com.freeuni.quizwebsite.service;

import com.freeuni.quizwebsite.model.db.FriendRequest;
import org.junit.jupiter.api.Test;

import java.sql.SQLException;
import java.util.ArrayList;

import static org.junit.jupiter.api.Assertions.*;

class FriendRequestInformationTest {

    @Test
    void getSentFriendRequests() throws SQLException {
        //test existed sent request
        ArrayList<FriendRequest> sentRequests = FriendRequestInformation.getSentFriendRequests(1);
        assertEquals(2, sentRequests.size());
        assertEquals(1, sentRequests.get(0).getUserOneId());
        assertEquals(3, sentRequests.get(0).getUserTwoId());
        assertEquals(4, sentRequests.get(1).getUserTwoId());
        //test nonexistent sent request
        ArrayList<FriendRequest> noSentRequests = FriendRequestInformation.getSentFriendRequests(2);
        assertEquals(0, noSentRequests.size());
    }

    @Test
    void getReceivedFriendRequests() throws SQLException {
        //test existed received request
        ArrayList<FriendRequest> receivedRequests = FriendRequestInformation.getReceivedFriendRequests(3);
        assertEquals(2, receivedRequests.size());
        assertEquals(3, receivedRequests.get(0).getUserTwoId());
        assertEquals(1, receivedRequests.get(0).getUserOneId());
        assertEquals(4, receivedRequests.get(1).getUserOneId());
        //test nonexistent received request
        ArrayList<FriendRequest> noReceivedRequests = FriendRequestInformation.getReceivedFriendRequests(1);
        assertEquals(0, noReceivedRequests.size());
    }

    @Test
    void getLatestSentFriendRequests() throws SQLException {
        ArrayList<FriendRequest> receivedRequests = FriendRequestInformation.getLatestSentFriendRequests(1);
        assertEquals(2, receivedRequests.size());
        assertEquals(1, receivedRequests.get(0).getUserOneId());
        assertEquals(4, receivedRequests.get(0).getUserTwoId());
        assertEquals(3, receivedRequests.get(1).getUserTwoId());
    }

    @Test
    void getLatestReceivedFriendRequests() throws SQLException {
        ArrayList<FriendRequest> receivedRequests = FriendRequestInformation.getLatestReceivedFriendRequests(3);
        assertEquals(2, receivedRequests.size());
        assertEquals(3, receivedRequests.get(0).getUserTwoId());
        assertEquals(4, receivedRequests.get(0).getUserOneId());
        assertEquals(1, receivedRequests.get(1).getUserOneId());
    }
}