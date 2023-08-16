package com.freeuni.quizwebsite.encodeBase64;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Base64;

public class EncodeImage {
    public static void main(String[] args) throws Exception {
        byte[] imageData = Files.readAllBytes(Paths.get("C:\\Users\\User\\Desktop\\PICSOOP\\ach6.png"));
        String encodedString = Base64.getEncoder().encodeToString(imageData);
        System.out.println();
        System.out.println(encodedString);  // This will print the base64 encoded string.
    }
}
