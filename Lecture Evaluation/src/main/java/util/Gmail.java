package util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Gmail extends Authenticator {

    @Override
    protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication("smlee010998@gmail.com", "uvadxexksgbqgmxu");
        //구글 아이디와 비밀번호를 넣어 사용자(관리자)에게 메일을 전송
    }
}
