package com.freeuni.quizwebsite.service;

import com.freeuni.quizwebsite.model.db.Challenge;
import org.junit.jupiter.api.Test;

import java.sql.SQLException;
import java.util.ArrayList;

import static org.junit.jupiter.api.Assertions.*;

class ChallengesInformationTest {

    @Test
    void getUserSentChallenges() throws SQLException {
        ArrayList<Challenge> tamaziSent = ChallengesInformation.getUserSentChallenges(2);
        assertEquals(tamaziSent.size(), 1);
        Challenge challenge = tamaziSent.get(0);
        assertEquals(challenge.getReceiverUserId(), 1);

        ArrayList<Challenge> sandrikaSent = ChallengesInformation.getUserSentChallenges(3);
        assertEquals(sandrikaSent.size(), 0);
    }

    @Test
    void getUserReceivedChallenges() throws SQLException {
        ArrayList<Challenge> mariamReceived = ChallengesInformation.getUserReceivedChallenges(1);
        assertEquals(mariamReceived.size(), 1);
        Challenge challenge = mariamReceived.get(0);
        assertEquals(challenge.getSenderUserId(), 2);

        ArrayList<Challenge> sandrikaReceived = ChallengesInformation.getUserReceivedChallenges(3);
        assertEquals(sandrikaReceived.size(), 0);
    }
}