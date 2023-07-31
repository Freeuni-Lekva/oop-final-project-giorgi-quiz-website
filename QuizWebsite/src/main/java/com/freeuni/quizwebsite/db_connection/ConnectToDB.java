package com.freeuni.quizwebsite.db_connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectToDB {
  
    private static final String USERNAME = "root";

    private static final String PASSWORD = "root";

    private static final String DB_NAME = "QUIZ_TEST_DB";  // fill in after creating sql script

    private static final Connection connection;

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/" + DB_NAME;
            connection = DriverManager.getConnection(url, USERNAME, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public static void close() throws SQLException {
        connection.close();
    }

    public static Connection getConnection() {
        return connection;
    }

}
