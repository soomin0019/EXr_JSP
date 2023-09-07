package evaluation;

import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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

    public ArrayList<EvaluationDTO> getList(String lectureDivide, String searchType, String search, int pageNumber) {
        //사용자가 검색한 내용에 대한 결과를 강의평가 글로써 리스트형으로 반환
        if(lectureDivide.equals("전체")){
            lectureDivide = "";
        }
        ArrayList<EvaluationDTO> evaluationList = null;     //강의평가 글이 담기는 리스트, 오류가 난다면 null값 그대로 반환
        String SQL = "";  //
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;        //톡정 sql문에 나온 결과값을 처리할 때 사용
        try {
            if(searchType.equals("최신순")){
                SQL = "SELECT * FROM EVALUATION WHERE lectureDivide LIKE ? AND CONCAT(lectureName, professorName, evaluationTitle, evaluationContent) LIKE " +
                        "? ORDER BY evaluationID DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
                //6개의 게시글을 출력하도록, 페이지가 넘어갈 때마다 5개씩 보이도록 출력
            } else if (searchType.equals("추천순")) {
                SQL = "SELECT * FROM EVALUATION WHERE lectureDivide LIKE ? AND CONCAT(lectureName, professorName, evaluationTitle, evaluationContent) LIKE " +
                        "? ORDER BY likeCount DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
            }
            conn = DatabaseUtil.getConnection();    //DatabaseUtil클래스 DB에 접근해 연결된 형태의 객체 자체를 반환
            pstmt = conn.prepareStatement(SQL);     //위의 SQL문장을 실행할 수 있는 형태로 준비
            pstmt.setString(1, "%" + lectureDivide + "%"); //% : SQL문법, 위에 SQL문 안 like ?에 들어갈 문자열을 포함하는지(전체 : 빈문자열, 전공, 교양, 기타)
            pstmt.setString(2, "%" + search + "%");
            rs = pstmt.executeQuery();               //나온 결과를 rs에 담아줌,

            evaluationList = new ArrayList<EvaluationDTO>();        //강의평가 담긴 게시글 초기화
            while (rs.next()) {                         //현재 나온 결과물
                EvaluationDTO evaluation = new EvaluationDTO(       //결과물(자료형) 가져오고 강의평가 데이터에 담아준 뒤
                        rs.getInt(1),                   //특정한 결과 나올 때마다 결과 이용해 초기화
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getInt(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10),
                        rs.getString(11),
                        rs.getString(12),
                        rs.getString(13),
                        rs.getInt(14)
                );
                evaluationList.add(evaluation);
                //데이터에 담아준 뒤 리스트에 추가
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
        return evaluationList;      //담겨진 리스트 그대로 출력
    }

}
