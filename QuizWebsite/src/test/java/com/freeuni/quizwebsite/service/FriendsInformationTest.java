package com.freeuni.quizwebsite.service;

import com.freeuni.quizwebsite.model.db.Announcement;
import com.freeuni.quizwebsite.model.db.Friend;
import org.junit.jupiter.api.Test;

import java.sql.SQLException;
import java.util.ArrayList;

import static org.junit.jupiter.api.Assertions.*;

class FriendsInformationTest {

    @Test
    void getPeopleOfStatus() throws SQLException {
        //test existing relationships
        ArrayList<Friend> besties = FriendsInformation.getPeopleOfStatus(2, "BESTIES", 0);
        assertEquals(1, besties.size());
        assertEquals(2, besties.get(0).getUserOneId());
        assertEquals(3, besties.get(0).getUserTwoId());
        assertEquals("BESTIES", besties.get(0).getStatus());
//        assertEquals(, friends.get(0).getFriendshipDate());
        //test nonexistent relashionships
        ArrayList<Friend> noBesties = FriendsInformation.getPeopleOfStatus(1, "BESTIES", 0);
        assertEquals(0, noBesties.size());
    }

    //getNewestFriends method uses this method, so it is already checked
    @Test
    void getNewestPeopleOfStatus() {
    }

    //getOldestFriends method uses this method, so it is already checked
    @Test
    void getOldestPeopleOfStatus() {
    }

    @Test
    void getFriends() throws SQLException {
        ArrayList<Friend> friends = FriendsInformation.getFriends(1);
        assertEquals(2, friends.size());
        assertEquals(1, friends.get(0).getUserOneId());
        assertEquals(2, friends.get(0).getUserTwoId());
        assertEquals(3, friends.get(1).getUserTwoId());
        assertEquals("FRIENDS", friends.get(0).getStatus());
//        assertEquals(, friends.get(0).getFriendshipDate());
        ArrayList<Friend> nofriends = FriendsInformation.getFriends(2);
        assertEquals(1, nofriends.size());
    }

    @Test
    void getNewestFriends() throws SQLException {
        ArrayList<Friend> friends = FriendsInformation.getNewestFriends(1);
        assertEquals(2, friends.size());
        assertEquals(3, friends.get(0).getUserTwoId());
        assertEquals(2, friends.get(1).getUserTwoId());
    }

    @Test
    void getOldestFriends() throws SQLException {
        ArrayList<Friend> friends = FriendsInformation.getOldestFriends(1);
        assertEquals(2, friends.size());
        assertEquals(2, friends.get(0).getUserTwoId());
        assertEquals(3, friends.get(1).getUserTwoId());
    }

    @Test
    void areOfStatus() throws SQLException {
        assertEquals(true, FriendsInformation.areOfStatus(2, 3, "BESTIES"));
        assertEquals(true, FriendsInformation.areOfStatus(3, 2, "BESTIES"));
        assertEquals(false, FriendsInformation.areOfStatus(3, 2, "FRIENDS"));
        assertEquals(false, FriendsInformation.areOfStatus(4, 2, "BESTIES"));
    }

    @Test
    void areFriends() throws SQLException {
        assertEquals(true, FriendsInformation.areFriends(1, 3));
        assertEquals(false, FriendsInformation.areFriends(3, 2));
    }
}