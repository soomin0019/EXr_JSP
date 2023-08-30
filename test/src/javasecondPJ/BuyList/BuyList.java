package javasecondPJ.BuyList;

import java.util.ArrayList;
import java.util.List;


public class BuyList {
    // 양파 2개 계란 3판
    private final List<Item> items = new ArrayList<>();

    public static class Item {
        private final String name;
        private final int amount;


        // 생성자로 매개변수 name, amount 값으로 Item의 필드 값 주입
        public Item(String name, int amount){
            this.name = name;
            this.amount = amount;

        }



        // Item name 필드 반환
        public String getName() {
            return name;

        }
        // Item Amount 필드 반환
        public int getAmount() {
            return amount;

        }


    }

    public void add(Item Item){
        items.add(Item);
    }


    public List<Item> getItems() {
        return items;

    }

// 메서드이름은 add로 지정하고 반환타입은 void
// 매개변수는 Item 타입인 하나의 매개변수가 있는데
// 그 변수를 items 객체에 add 시켜주세요.


/// 메서드이름은 getItems로 지정하고 반환타입은 List<Item>인
// items 객체를 반환하는 메서드