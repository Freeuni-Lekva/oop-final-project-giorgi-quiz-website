package com.freeuni.quizwebsite.model.db;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.sql.Timestamp;

@Data
@Builder
@AllArgsConstructor
public class Announcement {

    private int AnnouncementId;

    private int userId;

    private String announcement;

    private Timestamp creationDate;
}
