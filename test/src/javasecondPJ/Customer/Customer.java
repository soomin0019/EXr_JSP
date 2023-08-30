package javasecondPJ.Customer;

public class Customer {
    // private 접근 제어자의 정수형 `cash`라는 이름을 가진 변수 선언
    private int cash;

    // 고객의 구매 목록
    // private 접근 제어자의 final 제어자로 BuyList 타입의 `buyList` 이름을 가진 변수 선언
    private final BuyList buyList;

    // 고객의 장바구니
    // private 접근 제어자의 Basket 타입의 `basket` 이름을 가진 변수 선언
    private Basket basket;

    // 쿠폰
    // private 접근 제어자의 final 제어자로 List<Coupon> 타입의 `coupons` 이름을 가진 변수 선언
    private final List<Coupon> coupons = new ArrayList<>();

    public Customer() {
        this.buyList = buyList;
        this.cash = 20_000;
        this.coupons.add(new PercentDiscountCoupon());
        this.coupons.add(new MinusDiscountCoupon());
    }

    public void bring(Basket basket) {

    }



    public void pickFoods(FoodStand foodStand) {

    }

    public void payTo(Counter counter) {
        checkFoodsInBasket(counter);
    }
}
