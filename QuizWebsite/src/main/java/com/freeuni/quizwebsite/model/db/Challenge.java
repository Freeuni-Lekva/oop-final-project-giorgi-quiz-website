package com.freeuni.quizwebsite.model.db;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.sql.Timestamp;

@Data
@Builder
@AllArgsConstructor
public class Challenge {

    private final int challengeId;

    private final int senderUserId;

    private final int receiverUserId;

    private final int quizId;

    private String description;

    private Timestamp sendTime;
}
