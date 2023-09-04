package user;

import util.Database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class WriteDAO {

    /*public void showList(){
        String insertSQL = "SELECT * FROM boardList ORDER BY NUM";
        PreparedStatement pstmt = Connection.prepareStatement(insertSQL);
        ResultSet rs = null;

    }*/
    public WriteDTO readContent(int num) {
        WriteDTO dd = new WriteDTO();
        String SQL = "SELECT * FROM boardList WHERE num = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = Database.getConetection();
            pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            pstmt.setInt(1, num);
            if(rs.next()){
                dd.setTitle(rs.getString("title"));
                dd.setName(rs.getString("name"));
                dd.setDate(rs.getString("date"));
                dd.setContent(rs.getString("content"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (conn != null) conn.close(); }catch (Exception e){ e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); }catch (Exception e){ e.printStackTrace(); }
            try { if (rs != null) rs.close(); }catch (Exception e){ e.printStackTrace(); }
        }
        return dd;
    }

    //등록시간 알아서 기입
    public String getTime() {
        String SQL = "SELECT NOW()";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = Database.getConetection();
            pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    //num 큰 값 알아내서 하나씩 증가하도록
    public int getNextNumber() {
        String SQL = "SELECT MAX(num) FROM boardList";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            if(rs.next()) {     //앞에 게시글이 있는경우
                return rs.getInt(SQL) + 1;
            }
            return 1;       //첫 게시글인 경우
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                conn.close(); conn = null;
                pstmt.close(); pstmt = null;
                rs.close(); rs = null;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return -1;      //오류
    }

    public int write(WriteDTO boardlist){
        String SQL = "INSERT INTO boardList VALUES (?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = Database.getConetection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNextNumber());
            pstmt.setString(2, boardlist.getTitle());
            pstmt.setString(3, boardlist.getContent());
            pstmt.setString(4, boardlist.getName());
            pstmt.setString(5, getTime());

            return pstmt.executeUpdate();
        } catch (Exception e){
            e.printStackTrace();
        } finally {
            try { if (conn != null) conn.close(); }catch (Exception e){ e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); }catch (Exception e){ e.printStackTrace(); }
            try { if (rs != null) rs.close(); }catch (Exception e){ e.printStackTrace(); }
        }
        return -1;
    }
}
