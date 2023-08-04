package com.freeuni.quizwebsite.service;

import org.junit.jupiter.api.Test;

import java.sql.SQLException;

class TagsInformationTest {

    @Test
    void allTagNames() throws SQLException {
        System.out.printf(TagsInformation.AllTagNames().toString());
    }

    @Test
    void getQuizzesIdByTagName() throws SQLException {
        System.out.printf(TagsInformation.getQuizzesIdByTagName("Science").toString());
    }
}