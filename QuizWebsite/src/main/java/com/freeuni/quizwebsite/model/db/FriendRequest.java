package com.freeuni.quizwebsite.model.db;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.sql.Timestamp;

@Data
@Builder
@AllArgsConstructor
public class FriendRequest {

    private int userOneId;

    private int userTwoId;

    private Timestamp friendshipDate;
}
