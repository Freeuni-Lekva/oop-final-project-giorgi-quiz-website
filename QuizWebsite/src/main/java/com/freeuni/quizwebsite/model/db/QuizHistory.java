package com.freeuni.quizwebsite.model.db;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.sql.Timestamp;


@Data
@Builder
@AllArgsConstructor
public class QuizHistory {
    private final int quizId;

    private final int userId;

    private String name;

    private String description;

    private boolean sorted;

    private boolean oneOrMultiple;

    private boolean instantFeedback;

    private boolean practiceMode;

    private String quizStates;

    private int viewCount;

    private Timestamp creationDate;
}
