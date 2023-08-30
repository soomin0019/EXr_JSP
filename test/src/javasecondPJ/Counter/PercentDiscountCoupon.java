package javasecondPJ.Counter;

public class PercentDiscountCoupon implements Coupon {
    private final int discountRate;

    public PercentDiscountCoupon() {
        discountRate = 10;

    }

    public PercentDiscountCoupon(int discountRate) {
        this.discountRate = discountRate;

    }

    @Override
    public int getDiscount() {
        return this.discountRate;

    }

    @Override
    public int getDiscountType() {
        return Coupon.DISCOUNT_PERCENT_TYPE;

    }
}
