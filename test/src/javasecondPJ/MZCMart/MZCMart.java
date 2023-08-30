package javasecondPJ.MZCMart;

public class MZCMart {
    private final FoodStand foodStand = new FoodStand(); // 식품을 받아서 넣는 걸로
    private final Counter counter = new Counter();

    // fillFoodStand() 메서드 실행 시켜주세요
    public void prepareMart() {
        fillFoodStand();
    }

    private void fillFoodStand() {
        // foodStand 객체의 add 메서드를 사용해서 생성해주세요.

        // 반복문으로 양파는 2개 생성
        for(int i = 0; i<2; i++) {
            foodStand.add(new Food("onion", 1000));
        }
        // 반복문으로 계란 5판 생성
        for(int i = 0; i<5; i++) {
            foodStand.add(new Food("eggs", 2000));
        }
        // 반복문으로 파 10개 생성
        for(int i = 0; i<10; i++) {
            foodStand.add(new Food("greenonion", 500));
        }
        // 반복문으로 사과 20개 새엉
        for(int i = 0; i<20; i++) {
            foodStand.add(new Food("apple", 20000));
        }
    }

    // 메서드 이름은 provideBasket()
    // 반환 타입은 Basket
    // Basket 인스턴스를 새로 생성해서 반환하는 메서드는 만들어 주세요
    public Basket provideBasket() {
        Basket basket = new Basket();
        return basket;
    }


    // 메서드 이름은 getfoodStand()
    // 반환 타입은 FoodStand
    // foodStand 객체를 반환해주세요.
    public FoodStand getfoodStand() {
        return foodStand;
    }


    // 메서드 이름은 getCounter()
    // 반환 타입은 Counter
    // counter 객체를 반환해주세요.
    public Counter getCounter() {
        return counter;
    }
}