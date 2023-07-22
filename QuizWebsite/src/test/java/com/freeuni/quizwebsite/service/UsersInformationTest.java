package com.freeuni.quizwebsite.service;

import com.freeuni.quizwebsite.model.db.User;
import org.junit.jupiter.api.Test;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import static org.junit.Assert.assertEquals;

class UsersInformationTest {

    @Test
    public void findUserById() throws SQLException {
        User tazuka = UsersInformation.findUserById(2);
        assertEquals(tazuka.getFirstName(), "Tamazi");
    }


    @Test
    public void findUserByUserName() throws SQLException {
        User tazuka = UsersInformation.findUserByUserName("Tazuka");
        assertEquals(tazuka.getFirstName(), "Tamazi");
    }
//?????
    @Test
    public void CreatedBefore() throws SQLException {
        Timestamp T = new Timestamp(126, 5, 11, 10, 30, 0, 0);
        List<User> userList = UsersInformation.CreatedBefore(T);
        assertEquals(3,userList.size());
        Timestamp T1 = new Timestamp(120, 5, 11, 10, 30, 0, 0);
        List<User> userList1 = UsersInformation.CreatedBefore(T1);
        assertEquals(0,userList1.size());

    }
//???????????
    @Test
    public void CreatedAfter() throws SQLException {
        Timestamp T = new Timestamp(120 , 6, 11, 10, 30, 0, 0);
        List<User> userList = UsersInformation.CreatedAfter(T);
        assertEquals(3,userList.size());
        Timestamp T1 = new Timestamp(126, 5, 11, 10, 30, 0, 0);
        List<User> userList1 = UsersInformation.CreatedAfter(T1);
        assertEquals(0,userList1.size());

    }

    @Test
    public void findAdmins() throws SQLException {
        List<User> userList = UsersInformation.findAdmins();
        assertEquals(2,userList.size());

    }
// e
    @Test
    public void exceptAdmins() throws SQLException {
        List<User> userList = UsersInformation.exceptAdmins();
        assertEquals(1,userList.size());
    }


}