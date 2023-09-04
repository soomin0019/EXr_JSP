package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class WriterDAO {

    /*public void showList(){
        String insertSQL = "SELECT * FROM boardList ORDER BY NUM";
        PreparedStatement pstmt = Connection.prepareStatement(insertSQL);
        ResultSet rs = null;

    }*/

    private Connection conn;
    private ResultSet rs;


    public String getTime() {
        String SQL = "SELECT NOW()";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    //num 알아내서 하나씩 증가하도록
    public int getNext() {
        String SQL = "SELECT num FROM boardList ORDER BY num DESC";
        try {
            PreparedStatement pstmp = conn.prepareStatement(SQL);
            rs = pstmp.executeQuery();
            if(rs.next()) {     //앞에 게시글이 있는경우
                return rs.getInt(1) + 1;
            }
            return 1;       //첫 게시글인 경우
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;      //오류
    }

    public int write(String title, String name, String content){
        String SQL = "INSERT INTO boardList VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmp = conn.prepareStatement(SQL);
            pstmp.setInt(1, getNext());
            pstmp.setString(2, title);
            pstmp.setString(3, name);
            pstmp.setString(4, getTime());
            pstmp.setString(5, content);
            pstmp.setInt(6, 1);

            return pstmp.executeUpdate();
        } catch (Exception e){
            e.printStackTrace();
        }
        return -1;
    }
}
