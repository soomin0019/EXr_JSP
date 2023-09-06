package evaluation;

import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

//DTO에 적용해 DB에 접근해 내용 처리
public class EvaluationDAO {

    //글쓰기 함수
    public int write(EvaluationDTO evaluationDTO){
        String SQL = "INSERT INTO EVALUATION VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
        //null값을 넣으면 차례대로 알아서 기입, 나머지는 사용자가 알아서 입력해야 하기 때문
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;        //톡정 sql문에 나온 결과값을 처리할 때 사용
        try {
            conn = DatabaseUtil.getConnection();    //DatabaseUtil클래스 DB에 접근해 연결된 형태의 객체 자체를 반환
            pstmt = conn.prepareStatement(SQL);     //위의 SQL문장을 실행할 수 있는 형태로 준비
            pstmt.setString(1, evaluationDTO.getUserID()); //입력받은 값을 SQL의 ?안에 넣고
            pstmt.setString(2, evaluationDTO.getLectureName());
            pstmt.setString(3, evaluationDTO.getProfessorName());
            pstmt.setInt(4, evaluationDTO.getLectureYear());
            pstmt.setString(5, evaluationDTO.getSemesterDivide());
            pstmt.setString(6, evaluationDTO.getLectureDivide());
            pstmt.setString(7, evaluationDTO.getEvaluationTitle());
            pstmt.setString(8, evaluationDTO.getEvaluationContent());
            pstmt.setString(9, evaluationDTO.getTotalScore());
            pstmt.setString(10, evaluationDTO.getCreditScore());
            pstmt.setString(11, evaluationDTO.getComfortableScore());
            pstmt.setString(12, evaluationDTO.getLectureScore());

            return pstmt.executeUpdate();               //insert해서 나온 결과(1) 반환 (성공적으로 기입이 되었다는 것으로)

        }catch (Exception e){
            e.printStackTrace();        //오류 출력
        }finally {
            //***pstmt, conn은 한번 이상 사용하고 종료 이후에는 finally를 이용해 connection 객체를 닫아 주어야 함.
            //서버에 무리가 가지 않도록
            try { if (conn != null) conn.close(); }catch (Exception e){ e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); }catch (Exception e){ e.printStackTrace(); }
            try { if (rs != null) rs.close(); }catch (Exception e){ e.printStackTrace(); }
        }
        return -1;      //DB 오류
    }
}
