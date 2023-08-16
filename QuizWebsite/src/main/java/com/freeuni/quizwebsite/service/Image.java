package com.freeuni.quizwebsite.service;

import java.sql.SQLException;

public class Image {
    public static String GetImage(String achievementName){
        String imageData = "";
        try {
            imageData = ImageInformation.getImageDataByName(achievementName); // Assuming you have this method
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return imageData;

    }

}
