package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class Database {

    public static Connection getConntection() {
        try {
            String dbURL = "jdbc:mysql://localhost:3306/Board";
            String dbID = "root";
            String dbPassword = "root";
            Class.forName("com.mysql.jdbc.Driver");
            return DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
