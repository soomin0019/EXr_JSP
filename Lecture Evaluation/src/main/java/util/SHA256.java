package util;

import java.security.MessageDigest;

//회원가입 후 이메일 값에 Hash를 적용해 인증 코드를 보내면 타고 들어와 인증해주는 기능
//이메일 값에 Hash값을 더해 반환, salt값을 더해 암호화
public class SHA256 {
    public static String getSHA256(String input){
        StringBuffer result = new StringBuffer();
        try{
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            //실제 사용자가 입력한 값을 SHA256으로 알고리즘 적용
            byte[] salt = "Hello! This is Salt".getBytes();
            //sort : 해킹에 대비한 암호화
            digest.reset();
            digest.update(salt);    //salt값 적용
            byte[] chars = digest.digest(input.getBytes("UTF-8"));
            //실제 Hash를 적용한 값을 저장
            for(int i=0; i<chars.length; i++){
                String hex = Integer.toHexString(0xff & chars[i]);
                //Hex값과 Hash값을 적용한 배열의 인덱스를 더해서
                if(hex.length() == 1) result.append("0");
                //한 자리수인 경우 -> 총 2자리의 16진수로 만들어줌
                result.append(hex);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result.toString();
    }
}
