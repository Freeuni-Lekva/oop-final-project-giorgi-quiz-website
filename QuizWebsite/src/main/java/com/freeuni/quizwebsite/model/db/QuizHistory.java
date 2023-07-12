package com.freeuni.quizwebsite.model.db;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.sql.Timestamp;


@Data
@Builder
@AllArgsConstructor
public class QuizHistory {

    private int user_id;

    private int quiz_id;

    private double score;

    private Timestamp tadeDate;

}
