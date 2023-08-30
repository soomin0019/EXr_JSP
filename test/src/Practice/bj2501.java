package Practice;
import java.util.*;

public class bj2501 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        int n = sc.nextInt();
        int k = sc.nextInt();
        int [] Arr = new int[n+1];

        for(int i=1; i<=n ;i++){
            if(n%i==0){
                Arr[i] = i;
            }
        }
        System.out.println(Arr[k]);
    }
}
