package javasecondPJ.Counter;

public interface Coupon {
    int DISCOUNT_PERCENT_TYPE = 1; // 퍼센트 할인
    int DISCOUNT_MINUS_TYPE = 2; // 차감 할인
    int getDiscount();
    int getDiscountType();
}

