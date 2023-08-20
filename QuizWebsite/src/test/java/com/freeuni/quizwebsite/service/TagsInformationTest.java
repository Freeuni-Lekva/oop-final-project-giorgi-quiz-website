package com.freeuni.quizwebsite.service;

import org.junit.jupiter.api.Test;

import java.sql.SQLException;

import static org.junit.Assert.assertEquals;

class TagsInformationTest {

    @Test
    void allTagNames() throws SQLException {
        System.out.printf(TagsInformation.AllTagNames().toString());
        assertEquals(TagsInformation.AllTagNames().size(), 7);
    }

    @Test
    void getQuizzesIdByTagName() throws SQLException {
        System.out.printf(TagsInformation.getQuizzesIdByTagName("Science").toString());
        assertEquals(TagsInformation.getQuizzesIdByTagName("Science").size(), 2);
    }
}