package com.freeuni.quizwebsite.model.db;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.sql.Timestamp;

@Data
@Builder
@AllArgsConstructor
public class NoteMail {

    private final int senderUserId;

    private final int receiverUserId;

    private String note;

    private Timestamp sendTime;
}
