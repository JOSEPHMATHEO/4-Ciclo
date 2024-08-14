import java.util.List;

public class ThCountPerfecto extends ThCountMain{

    public ThCountPerfecto(List<Integer> nums){

        super(nums);


    }
    @Override
    public void run(){

        System.out.println(Thread.currentThread().getName()+ " " + getNums().stream()
                .filter(num -> num == sumaDivPropios(num)).toList());

        counter = getNums().stream().filter(num -> num == sumaDivPropios(num))
                .count();

    }
}
