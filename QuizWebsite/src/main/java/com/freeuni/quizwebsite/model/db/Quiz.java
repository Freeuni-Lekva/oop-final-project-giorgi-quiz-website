package com.freeuni.quizwebsite.model.db;


import com.freeuni.quizwebsite.model.QuizStates;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import java.sql.Timestamp;
import java.util.Objects;


@Data
@Builder
@AllArgsConstructor
public class Quiz {

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
