package user;

import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class UserDAO {

    //회원가입을 하는 하나의 함수
    public int join(String userID, String userPassword){
        String SQL = "INSERT INTO USER VALUES (?, ?)"; //?실제 회원의 ID와 비번 입력
        try{
            Connection conn = DatabaseUtil.getConnection();
            //?에 각각의 데이터를 실제로 넣어줄 수 있도록 함
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);         //첫 번째 ID
            pstmt.setString(2, userPassword);   //두 번쨰 Password

            return pstmt.executeUpdate(); //INSERT 구문을 실행한 후 반환한 결과
        } catch ( Exception e){
            e.printStackTrace();
        }
        return -1;   //오류가 발생한 경우 반환
        // 현재는 DB에서 데이터 값이 겹치면 안된다는 기능을 정하지 않았으므로 오류가 없을 듯
    }
}
