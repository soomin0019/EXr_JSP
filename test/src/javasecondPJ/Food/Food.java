package javasecondPJ.Food;
import java.util.ArrayList;
import java.util.List;
public class Food {
    private final String name;
    private final int price;

    public Food(String name, int price){
        this.name = name;
        this.price = price;
    }

    @Override
    public String toString() {
        return "Food{" +
                "name='" + name + '\'' +
                ", price=" + price +
                '}';
    }

    public String getName() {
        return name;
    }

    public int getPrice() {
        return price;
    }
}

