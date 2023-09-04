package user;

import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;

//실제 데이터베이스와 1:1로 연동되어 내용을 기록하고 다시 정보를 가져오는 기능
public class UserDAO {

    public int join(String userID, String userPassword){
        String SQL = "INSERT INTO USER VALUES (?,?)";
        try{
            Connection conn = DatabaseUtil.getConnection();
            PreparedStatement pstmp = conn.prepareStatement(SQL);
            pstmp.setString(1,userID);
            pstmp.setString(2,userPassword);
            return pstmp.executeUpdate();   //insert구문 실행해서 나온 결과 저장(1/0)
        } catch (Exception e){
            e.printStackTrace();
        }
        return -1;
    }
}
