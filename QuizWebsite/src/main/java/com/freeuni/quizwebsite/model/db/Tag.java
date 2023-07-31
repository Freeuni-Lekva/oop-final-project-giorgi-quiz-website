package com.freeuni.quizwebsite.model.db;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class Tag {
    private int quizId;
    private String tagName;
}
