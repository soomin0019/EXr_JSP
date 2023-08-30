package javasecondPJ.BuyList;

import java.util.*;

public class BuyListTest {
    private static BuyList inputBuyListFromShell() {
        // Scanner 인스턴스를 생성하고
        Scanner scanner = new Scanner(System.in);
        // BuyList 인스턴스를 생성하고
        BuyList buyList = new BuyList();
        // intput 변수에 Scanner의 nextLine() 메서드 사용해서 값 주입
        String input = scanner.nextLine();
        // inputSplit 변수에 String의 split 기능을 써서 " " 처리한 값을 주입
        String[] inputSplit = input.split(" ");
        //
        for (int i = 0; i < inputSplit.length; i += 2) {
            checkInput(buyList, inputSplit, i);
        }
        // TODO
        return buyList;
    }

    private static void checkInput(BuyList buyList, String[] inputSplit, int i) {
        if(inputSplit.length % 2 == 0){
            buyList.add(new BuyList.Item(inputSplit[i], Integer.parseInt(inputSplit[i +1])));
        } else {
            // "잘못된 입력 값입니다. 시스템을 종료합니다." 라는 출력문 println() 작성
            System.out.println("잘못된 입력 값입니다. 시스템을 종료합니다.");
            // 시스템 exit;
            System.exit(0);
        }
    }
}
