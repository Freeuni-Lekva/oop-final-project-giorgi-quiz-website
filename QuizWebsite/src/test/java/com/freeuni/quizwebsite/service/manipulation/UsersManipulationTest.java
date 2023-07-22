package com.freeuni.quizwebsite.service.manipulation;

import com.freeuni.quizwebsite.model.db.User;
import com.freeuni.quizwebsite.service.UsersInformation;
import org.junit.Test;
import org.junit.jupiter.api.Assertions;

import java.security.Timestamp;
import java.sql.SQLException;

import static org.junit.Assert.*;

public class UsersManipulationTest {

    @Test
    public void testAddUser() {
        try {
            // Test data
            String firstName = "John";
            String lastName = "Doe";
            String userName = "johndoe";
            String bio = "Hello, I am John!";
            String password = "mysecretpassword";

            // Add the user
            int userId = UsersManipulation.addUser(firstName, lastName, userName, bio, password);

            // Check if the user_id is valid (greater than 0)
            assertTrue(userId > 0);

            // Check if the user exists in the database
            User addedUser = UsersInformation.findUserById(userId);
            assertNotNull(addedUser);

            // Check if the user details match the input data
            assertEquals(firstName, addedUser.getFirstName());
            assertEquals(lastName, addedUser.getLastName());
            assertEquals(userName, addedUser.getUsername());
            assertEquals(bio, addedUser.getBio());

            // Check if the password is hashed and stored correctly
            assertNotEquals(password, addedUser.getPassword());
//            assertTrue(checkPasswordHash(password, addedUser.getPassword()));

        } catch (SQLException e) {
            fail("SQLException occurred: " + e.getMessage());
        }
    }

    @Test
    public void testDeleteUserById() {
        try {
            // Test data
            String firstName = "John";
            String lastName = "Doe";
            String userName = "johndoe2";
            String bio = "Hello, I am John!";
            String password = "mysecretpassword";

            // Add the user
            int userId = UsersManipulation.addUser(firstName, lastName, userName, bio, password);

            // Check if the user exists in the database before deletion
            User addedUser = UsersInformation.findUserById(userId);
            assertNotNull(addedUser);

            // Delete the user by their user_id
            UsersManipulation.deleteUserById(userId);

            // Check if the user is deleted from the database
            User deletedUser = UsersInformation.findUserById(userId);
            assertNull(deletedUser);

        } catch (SQLException e) {
            fail("SQLException occurred: " + e.getMessage());
        }
    }

    @Test
    public void testPasswordVerification() {
        try {
            // Test data
            String firstName = "John";
            String lastName = "Doe";
            String userName = "johndoe";
            String bio = "Hello, I am John!";
            String password = "mysecretpassword";

            // Add the user
            int userId = UsersManipulation.addUser(firstName, lastName, userName, bio, password);

            // Verify the password
            boolean isPasswordCorrect = UsersInformation.verifyPassword(userId, password);
            assertTrue(isPasswordCorrect);

            // Verify wrong password
            boolean isWrongPasswordCorrect = UsersInformation.verifyPassword(userId, "wrongpassword");
            assertFalse(isWrongPasswordCorrect);

        } catch (SQLException e) {
            fail("SQLException occurred: " + e.getMessage());
        }
    }


}