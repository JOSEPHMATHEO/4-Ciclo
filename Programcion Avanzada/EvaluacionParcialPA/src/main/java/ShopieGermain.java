import java.util.Arrays;

public class ShopieGermain extends NumerosPrimos{

    public ShopieGermain(int[] row){

        super(row);

    }

    @Override
    public void run(){

        System.out.println(Thread.currentThread().getName()+ " " + getSumaPrimos());

    }
}
