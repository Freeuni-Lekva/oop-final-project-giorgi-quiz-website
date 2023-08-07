package com.freeuni.quizwebsite.model.db;

import com.freeuni.quizwebsite.model.QuestionType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor
public class Question {
    private final int questionId;

    private String question;

    private String questionType;

    private int quizId;

    private int sortOrder;
}
