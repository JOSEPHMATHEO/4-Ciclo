import java.util.List;

public class ThCountAbundante extends ThCountMain{

    public ThCountAbundante(List<Integer> nums){

        super(nums);


    }

    @Override
    public void run(){

        System.out.println(Thread.currentThread().getName()+ " " + getNums().stream()
                .filter(num -> num > sumaDivPropios(num)).toList());

        counter = getNums().stream().filter(num -> num > sumaDivPropios(num))
                .count();

    }
}
