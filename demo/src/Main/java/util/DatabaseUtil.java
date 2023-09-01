package util;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;

public class DatabaseUtil {

    //실제 DB와 연동하는 부분
    public static Connection getConnection() {  //static : 다른 라이브러리에서 쉽게 사용할 수 있도록
        //접속한 상태 자체를 반환하도록
        try{
            String dbURL = "jdbc:mysql://localhost:3306/TUTORIAL";
            //3306포트 번호를 사용하는 TUTORIAL이름의 mysql DB
            String dbID = "root";
            String dbPassword = "1234";
            Class.forName("com.mysql.jdbc.Driver");
            return DriverManager.getConnection(dbURL, dbID, dbPassword);
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
        //오류가 발생한 경우 null 값을 반환
    }
}
