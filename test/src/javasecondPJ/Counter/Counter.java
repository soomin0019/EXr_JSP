package javasecondPJ.Counter;

import javasecondPJ.Basket.Basket;

import java.util.List;

public class Counter {
    DecimalFormat decimalFormat = new DecimalFormat("###,###");
    boolean isCancel = false;
    private float percentDiscountedPrice;

    // public 접근제어자를 가진
    // int 반환 타입의
    // `calculator` 이름을 가진 메서드이며
    // 매개변수 총 3개로
    // Basket 클래스 타입의 이름은 `basket`,
    // int 형의 이름은 'cash'
    // List<Coupon> 타입의 이름은 'coupons' 가 있다.
    // 메서드 기능은
    // int totalPrice 를 선언하고 getTotalPrice 메소드로 값 주입
    // int finalPrice 를 선언하고 getFinalPrice 메소드로 값 주입
    // int change 를 선언하고 getChange 메소드로 값 주입
    // counterPrint 메소드 호출
    // return finish 메소드로 반환
    public int calculator (Basket basket, int cash, List<Coupon> coupons) {
        int totalPrice = getTotalPrice();
        int finalPrice = getFinalPrice();
        int change = getChange();
        counterPrint();

        return finish();
    }

    // private 접근제어자를 가진
    // int 반환 타입의
    // `finish` 이름을 가진 메서드이며
    // 매개변수는 총 5개로
    // int 형의 이름은 `cash`
    // List<Coupon> 타입의 이름은 `coupons`
    // int 형의 이름은 `totalPrice`
    // int 형의 이름은 `finalPrice`
    // int 형의 이름은 `change` 가 있다.
    // 기능은
    // if 조건문으로 isCancel로 조건을 확인하고
    // true 면
    // rollBack() 메서드 호출 후
    // return cash;
    // false 면
    // return change;
    private int finish(int cash, List<Coupon> coupons, int totalPrice, int finalPrice, int change){
        if(isCancel){
            rollBack();
            return cash;
        }else
            return change;
    }
    // private 접근제어자를 가진
    // void 반환 타입의
    // `rollBack` 이름을 가진 메서드이며
    // 매개변수는 총 3개로
    // List<Coupon> 타입의 이름은 `coupons`
    // int 형의 이름은 `finalPrice`
    // int 형의 이름은 `totalPrice`
    // 기능은
    // rollBackPercentDiscountCoupon 메서드 호출
    // rollBackMinusDiscountCoupon 메서드 호출
    private void rollBack(List<Coupon> coupons, int finalPrice, int totalPrice) {
        rollBackPercentDiscountCoupon();
        rollBackMinusDiscountCoupon();
    }

    // private 접근제어자를 가진
    // void 반환 타입의
    // `rollBackPercentDiscountCoupon` 가진 메서드이며
    // 매개변수는 총 2개로
    // List<Coupon> 타입의 이름은 `coupons`
    // int totalPrice 이다.
    // 기능은
    // 실수형 타입의 `discount` 이름을 가진 변수를 선언하고 (1 - percentDiscountedPrice / totalPrice) * 100 값을 주입
    // coupons 리스트에 add 메서드를 사용해서 new PercentDiscountCoupon((int)Math.ceil(discout))) 로 값 주입
    private void rollBackPercentDiscountCoupon(List<Coupon> coupons, int totalPrice) {
        float discount = (1 - percentDiscountedPrice / totalPrice) * 100;
        coupons = coupons.add(new PercentDiscountCoupon((int)Math.ceil(discout)));
    }

    // private 접근제어자를 가진
    // void 반환 타입의
    // `rollBackMinusDiscountCoupon` 가진 메서드이며
    // 매개변수는 총 2개로
    // List<Coupon> 타입의 이름은 `coupons`
    // int 형 타입의 이름은 `finalPrice` 이다.
    // 기능은
    // 정수형 타입의 `discount` 이름을 가진 변수를 선언하고 (int) (percentDiscountedPrice - finalPrice)로 값을 주입
    // coupons 리스트에 add 메서드를 사용해서 new MinusDiscountCoupon((int)Math.ceil(discout)))로 값 주입
    private void rollBackMinusDiscountCoupon(List<Coupon> coupons, int finalPrice) {
        int discount = (int) (percentDiscountedPrice - finalPrice);
        coupons = coupons.add(new MinusDiscountCoupon((int)Math.ceil(discout)));
    }

    // private 접근제어자를 가진
    // int 반환 타입의
    // `getChange` 이름을 가진 메서드이며
    // 매개변수는 총 2개로
    // int 형 타입의 이름은 `cash`
    // int 형 타입의 이름은 `finalPrice`
    // 기능은
    // if 조건문으로 cash - finalPrice > 0를 조건으로
    // true면 return cash - finalPrice;
    // false면
    // isCancle = true;
    // return cash;
    private int getChange(int cash, int finalPrice) {
        if (cash - finalPrice > 0)
            return cash - finalPrice;
        isCancel = true;
        return cash;
    }

    private void counterPrint(int change, int totalPrice, int finalPrice) {
        System.out.println("총 가격은 " + decimalFormat.format(totalPrice) + "원 입니다.");
        System.out.print("할인 후 " + decimalFormat.format(finalPrice) + "원 입니다. ");
        if (isCancel) {
            System.out.println();
            System.out.println("현금이 부족합니다.");
        } else {
            System.out.println("고맙습니다.");
            System.out.println("고객님 결제 후 잔액: " + decimalFormat.format(change));
        }
    }

    private int getFinalPrice(int totalPrice, List<Coupon> coupons) {
        percentDiscountedPrice = getPercentDiscount(totalPrice, coupons);
        return getMinusDiscount(percentDiscountedPrice, coupons);
    }

    private int getPercentDiscount(int totalPrice, List<Coupon> coupons) {
        for (Coupon coupon : coupons) {
            if (coupon.getDiscountType() == Coupon.DISCOUNT_PERCENT_TYPE) {
                totalPrice *= (1 - coupon.getDiscount() * 0.01);
                coupons.remove(coupon);
                break;
            }
        }
        return totalPrice;
    }

    private int getMinusDiscount(float percentDiscountedPrice, List<Coupon> coupons) {
        for (Coupon coupon : coupons) {
            if (coupon.getDiscountType() == Coupon.DISCOUNT_MINUS_TYPE) {
                percentDiscountedPrice -= coupon.getDiscount();
                percentDiscountedPrice = adjustPrice(percentDiscountedPrice);
                coupons.remove(coupon);
                break;
            }
        }
        return (int)percentDiscountedPrice;
    }

    private float adjustPrice(float percentDiscountedPrice) {
        if(percentDiscountedPrice < 0) {
            percentDiscountedPrice = 0;
        }
        return percentDiscountedPrice;
    }

    private int getTotalPrice() {
        int totalPrice = 0;
        List<Food> foods = basket.getFoods();
        for (Food food : foods) {
            totalPrice += food.getPrice();
        }
        return totalPrice;
    }

    public Coupon giveCoupon() {
        if (isCancel) {
            return null;
        } else {
            return makeRandamCoupon();
        }
    }

    // 랜덤 쿠폰 발급
    private Coupon makeRandamCoupon() {
        Random random = new Random();
        int randomDiscountType = random.nextInt(2) + 1;
        int randomDiscount;
        if (randomDiscountType == Coupon.DISCOUNT_PERCENT_TYPE) {
            randomDiscount = (random.nextInt(3) + 1) * 10;
            return new PercentDiscountCoupon(randomDiscount);
        } else {
            randomDiscount = (random.nextInt(5) + 1) * 1000;
            return new MinusDiscountCoupon(randomDiscount);
        }
    }
}