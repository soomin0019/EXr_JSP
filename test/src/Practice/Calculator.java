package Practice;

public class Calculator {
    public static void main(String[] args) {
        int x = 10;
        int y = 20;

        System.out.println("sum = " + add(x, y));

        System.out.println("min = " + min(x, y));
        System.out.println("mul = " + mul(x, y));
        System.out.println("div = " + div(x, y));
    }

    static int add(int x, int y){
        return x + y;
    }

    static int min(int x, int y){
        return x -y;
    }

    static float mul(float x, float y){
        return x * y;
    }

    static float div(float x, float y){
        return x/y;
    }
}
