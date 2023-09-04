package user;

public class UserDTO {

    String userID;
    String userPassword;

    //현재 기록된 데이터 가져오기
    public String getUserID() {
        return userID;
    }

    //데이터를 기록하는 명령어
    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }
}
