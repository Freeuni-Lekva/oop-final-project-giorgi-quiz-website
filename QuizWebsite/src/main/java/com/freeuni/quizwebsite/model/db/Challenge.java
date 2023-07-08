package com.freeuni.quizwebsite.model.db;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.sql.Timestamp;

@Data
@Builder
@AllArgsConstructor
public class Challenge {

    private final int senderAccountId;

    private final int receiverAccountId;

    private final int quizId;

    private String description;

    private Timestamp sendTime;
}
