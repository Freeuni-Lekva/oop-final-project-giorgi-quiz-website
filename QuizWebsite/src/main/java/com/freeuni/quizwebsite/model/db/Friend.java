package com.freeuni.quizwebsite.model.db;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.sql.Timestamp;
@Data
@Builder
@AllArgsConstructor
public class Friend {

    public Friend(int userOneId, int userTwoId, String status, Timestamp friendshipDate) {
        this.userOneId = userOneId;
        this.userTwoId = userTwoId;
        this.status = status;
        this.friendshipDate = friendshipDate;
    }

    private int friend_id;

    private int userOneId;

    private int userTwoId;

    private String status;

    private Timestamp friendshipDate;
}
