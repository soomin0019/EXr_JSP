package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {

    public static Connection getConnection(){   //접속한 상태 자체를 반환
        try{
            String dbURL = "jdbc:mysql://localhost:3306/TUTORIAL";
            String dbID = "root";
            String dbPassword = "root";
            Class.forName("com.mysql.jdbc.Driver");
            return DriverManager.getConnection(dbURL, dbID, dbPassword);

        } catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
}
