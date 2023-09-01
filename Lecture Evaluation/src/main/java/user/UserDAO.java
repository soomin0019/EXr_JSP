package user;

import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    //사용자가 입력한 아이디와 비밀번호 정보를 통해 로그인 시도하는 함수 정의
    public int login(String userID, String userPassword){
        String SQL = "SELECT userPassword FROM USER WHERE userID = ?";  //사용자가 가진 ID로 Password를 불러옴
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;        //톡정 sql문에 나온 결과값을 처리할 때 사용
        try {
            conn = DatabaseUtil.getConnection();    //DatabaseUtil클래스 DB에 접근해 연결된 형태의 객체 자체를 반환
            pstmt = conn.prepareStatement(SQL);     //위의 SQL문장을 실행할 수 있는 형태로 준비
            pstmt.setString(1, userID); //입력받은 값을 SQL의 ?안에 넣고
            rs = pstmt.executeQuery();               //나온 결과를 rs에 담아줌,
            // Query는 DB에서 검색하는 것, 조회할 때 사용, resultset을 사용해 결과 확인
            if (rs.next()){                 //SQL문장 실행 후 결과가 나온다면
                if(rs.getString(1).equals(userPassword)){
                    return 1;               //로그인 성공
                }
                else {
                    return 0;               //로그인 실패, 비밀번호 틀림
                }
            }
            return -1;                  //아이디 없음
        }catch (Exception e){
            e.printStackTrace();        //오류 출력
        }finally {
            //***pstmt, conn은 한번 이상 사용하고 종료 이후에는 finally를 이용해 connection 객체를 닫아 주어야 함.
            //서버에 무리가 가지 않도록
            try { if (conn != null) conn.close(); }catch (Exception e){ e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); }catch (Exception e){ e.printStackTrace(); }
            try { if (rs != null) rs.close(); }catch (Exception e){ e.printStackTrace(); }
        }
        return -2;      //DB 오류
    }


    //사용자가 입력한 아이디와 비밀번호, 이메일 정보를 통해 회원가입 시도하는 함수 정의
    public int join(UserDTO user){
        String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, false)";  //ID, PW, Em, EmH, 인증유무
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;        //톡정 sql문에 나온 결과값을 처리할 때 사용
        try {
            conn = DatabaseUtil.getConnection();    //DatabaseUtil클래스 DB에 접근해 연결된 형태의 객체 자체를 반환
            pstmt = conn.prepareStatement(SQL);     //위의 SQL문장을 실행할 수 있는 형태로 준비
            pstmt.setString(1, user.getUserID()); //입력받은 값을 SQL의 ?안에 넣고
            pstmt.setString(2, user.getUserPassword());
            pstmt.setString(3, user.getUserEmail());
            pstmt.setString(4, user.getUserEmailHash());

            return pstmt.executeUpdate();
            //insert, update, delete 같은 함수는 executeUpdate를 활용해 처리, 영향을 받은 데이터 개수 반환 (1)

        } catch (Exception e) {
            e.printStackTrace();        //오류 출력
        } finally {
            //***pstmt, conn은 한번 이상 사용하고 종료 이후에는 finally를 이용해 connection 객체를 닫아 주어야 함.
            //서버에 무리가 가지 않도록
            try {if(conn != null) conn.close();} catch (Exception e) {e.printStackTrace();}
            try {if(pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
            try {if(rs != null) rs.close();} catch (Exception e) {e.printStackTrace();}
        }
        return -1;      //회원가입 실패
    }


    //특정 회원의 이메일 자체를 반환하는 함수
    public String getUserEmail(String userID){
        String SQL = "SELECT userEmail FROM USER WHERE userID = ?";
        //사용자에게 ID값을 받아 사용자의 이메일이 검증이 되었는지 확인
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;        //톡정 sql문에 나온 결과값을 처리할 때 사용
        try {
            conn = DatabaseUtil.getConnection();    //DatabaseUtil클래스 DB에 접근해 연결된 형태의 객체 자체를 반환
            pstmt = conn.prepareStatement(SQL);     //위의 SQL문장을 실행할 수 있는 형태로 준비
            pstmt.setString(1, userID); //입력받은 값을 SQL의 ?안에 넣고
            rs = pstmt.executeQuery();              //결과를 rs안에 넣어줌
            if(rs.next()){
                return rs.getString(1);
            }

        }catch (Exception e){
            e.printStackTrace();        //오류 출력
        }finally {
            //***pstmt, conn은 한번 이상 사용하고 종료 이후에는 finally를 이용해 connection 객체를 닫아 주어야 함.
            //서버에 무리가 가지 않도록
            try { if (conn != null) conn.close(); }catch (Exception e){ e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); }catch (Exception e){ e.printStackTrace(); }
            try { if (rs != null) rs.close(); }catch (Exception e){ e.printStackTrace(); }
        }
        return null;      //DB 오류
    }


    //사용자가 입력한 이메일이 검증, 인증이 되었는지 확인하는 함수 정의
    public boolean getUserEmailChecked(String userID){
        String SQL = "SELECT userEmailChecked FROM USER WHERE userID = ?";
        //사용자에게 ID값을 받아 사용자의 이메일이 검증이 되었는지 확인
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;        //톡정 sql문에 나온 결과값을 처리할 때 사용
        try {
            conn = DatabaseUtil.getConnection();    //DatabaseUtil클래스 DB에 접근해 연결된 형태의 객체 자체를 반환
            pstmt = conn.prepareStatement(SQL);     //위의 SQL문장을 실행할 수 있는 형태로 준비
            pstmt.setString(1, userID); //입력받은 값을 SQL의 ?안에 넣고
            rs = pstmt.executeQuery();              //결과를 rs안에 넣어줌
            if(rs.next()){
                return rs.getBoolean(1);
            }

        }catch (Exception e){
            e.printStackTrace();        //오류 출력
        }finally {
            //***pstmt, conn은 한번 이상 사용하고 종료 이후에는 finally를 이용해 connection 객체를 닫아 주어야 함.
            //서버에 무리가 가지 않도록
            try { if (conn != null) conn.close(); }catch (Exception e){ e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); }catch (Exception e){ e.printStackTrace(); }
            try { if (rs != null) rs.close(); }catch (Exception e){ e.printStackTrace(); }
        }
        return false;      //DB 오류
    }



    //사용자가 입력한 이메일의 인증을 완료하는 함수
    public boolean setUserEmailChecked(String userID){
        String SQL = "UPDATE USER SET userEmailChecked = true WHERE userID = ?";
        //특정 id 값을 가진 사용자로 하여금 email 인증 되도록 처리

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;        //톡정 sql문에 나온 결과값을 처리할 때 사용
        try {
            conn = DatabaseUtil.getConnection();    //DatabaseUtil클래스 DB에 접근해 연결된 형태의 객체 자체를 반환
            pstmt = conn.prepareStatement(SQL);     //위의 SQL문장을 실행할 수 있는 형태로 준비
            pstmt.setString(1, userID); //입력받은 값을 SQL의 ?안에 넣고

            pstmt.executeUpdate();          //insert, update, delete 같은 함수 처리
            return true;                    //추가적으로 인증을 할 수 있도록(이미 인증이 되어있는 상태더라도)

        }catch (Exception e){
            e.printStackTrace();        //오류 출력
        }finally {
            //***pstmt, conn은 한번 이상 사용하고 종료 이후에는 finally를 이용해 connection 객체를 닫아 주어야 함.
            //서버에 무리가 가지 않도록
            try { if (conn != null) conn.close(); }catch (Exception e){ e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); }catch (Exception e){ e.printStackTrace(); }
            try { if (rs != null) rs.close(); }catch (Exception e){ e.printStackTrace(); }
        }
        return false;      //DB 오류
    }
}
