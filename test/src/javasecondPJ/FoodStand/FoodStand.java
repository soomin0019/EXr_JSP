package javasecondPJ.FoodStand;

public class FoodStand {
    private final List<Food> foods = new ArrayList<>();

    // foods 객체에 Food 추가하는 메서드
    public void add(Food food) {
        foods.add(food);
    }

    // foods 객체안에 name 매개변수에 해당하는 이름이 있는지 체크하는 메서드
    // foods 객체를 foreach 반복문으로
    // food 의 getName 메서드 사용 후 메서드 체이닝으로 equals로 매개변수 name과 비교해서
    // 같으면 return true;
    // foreach 반복문이 끝나면 return false;
    public boolean hasFood(String name) {
        for(Food f : foods) {
            if (f.getName().equals(name)) {
                return true;
            }
        }
        return false;
    }

    // foods 객체에서 name에 해당하는 값을 가지는 food를 삭제하고 반환하는 메서드
    // foods 객체를 foreach 반복문으로
    // food 의 getName 메서드 사용 후 메서드 체이닝으로 equals로 매개변수 name과 비교해서
    // 같으면
    // foods.remove(food)
    // return food;
    // foreach 반복문이 끝나면 return null;
    public Food getFood(String name) {
        for(Food f : foods) {
            if (f.getName().equals(name)) {
                foods.remove(f);
                return f;
            }
        }
        return null;
    }

}
