package javasecondPJ.MZCMart;

import javasecondPJ.BuyList.BuyList;
import javasecondPJ.Customer.Customer;

import java.util.*;

public class MZCMartShell {
    public static void main(String[] args) {
        // MZCMart 클래스 타입의 `mart` 이름을 가진 MZCMart 객체 생성
        MZCMart mart = new MZCMart();
        // MZCMart 객체의 prepareMart 메소드 실행
        mart.prepareMart();
        // "메가존 마트에 오신 것을 환영합니다. 사고 싶은 물건을 골라주세요." 라는 메시지 출력
        System.out.println("메가존 마트에 오신 것을 환영합니다. 사고 싶은 물건을 골라주세요.");
        // BuyList 클래스 타입의 `buyList`이름을 가진 변수 선언, inputBuyListFromShell()메소드로 값을 받는다.
        BuyList buyList = inputBuyListFromShell();

        // Customer 클래스 타입의 `customer` 이름을 가진 Customer 인스턴스 생성
        Customer customer = new Customer();
        // MZCMart 객체의 provideBasket() 메서드를 이용해서 Customer 객체의 bring 메서드 이용
        customer.bring(mart.provideBasket());
        // MZCMart 객체의 getFoodStand 메서드를 이용해서 Customer 객체의 pickFoods 메서드 이용
        customer.pickFoods(mart.getfoodStand());
        // MZCMart 객체의 getCounter 메서드를 이용해서 Customer 객체의 payTo 메서드 이용
        customer.payTo(mart.getCounter());
    }

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
