package com.freeuni.quizwebsite.model.db;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor
public class Achievement {
    private int achievementId;

    private final int userId;

    private String achivementName;

}
