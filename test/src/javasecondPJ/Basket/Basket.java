package javasecondPJ.Basket;

import javasecondPJ.Food.Food;

import java.util.ArrayList;
import java.util.List;

public class Basket {
    private final List<Food> foods;

    //food객체 생성
    public Basket(){
        this.foods = new ArrayList<>();
    }

    //매개변수 food를 foods 객체에 담기
    public void add(Food food){
        foods.add(food);
    }

    //foods 객체 반환
    public List<Food> getFoods(){

        return foods;
    }
}
