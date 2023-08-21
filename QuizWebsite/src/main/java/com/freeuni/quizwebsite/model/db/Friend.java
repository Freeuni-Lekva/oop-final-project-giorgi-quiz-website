package com.freeuni.quizwebsite.model.db;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import java.sql.Timestamp;
import java.util.Date;

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
    public Friend(int userOneId, int userTwoId) {
        this.userOneId = userOneId;
        this.userTwoId = userTwoId;
        this.status = "FRIEND";
        Date currentDate = new Date();
        this.friendshipDate = new Timestamp(currentDate.getTime());
    }

    private int friend_id;

    private int userOneId;

    private int userTwoId;

    private String status;

    private Timestamp friendshipDate;
}
