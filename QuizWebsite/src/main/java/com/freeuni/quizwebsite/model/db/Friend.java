package com.freeuni.quizwebsite.model.db;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.sql.Timestamp;
@Data
@Builder
@AllArgsConstructor
public class Friend {
    private int userOneId;

    private int userTwoId;

    private String status;

    private Timestamp friendshipDate;
}
