package com.freeuni.quizwebsite.model.db;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.sql.Timestamp;

@Data
@Builder
@AllArgsConstructor
public class User {

    private final int userId;

    private String firstName;

    private String lastName;

    private String username;

    private String bio;

    private String password;

    private Timestamp creationDate;

    private boolean isAdmin;
}
