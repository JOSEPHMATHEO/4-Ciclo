package ToDoWork;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.concurrent.TimeUnit;

public class ThDoWork extends Thread {

    private static TimeUnit time = TimeUnit.SECONDS;
    private int id;
    public ThDoWork(int id){

        this.id = id;

    }

    public void run(){

        System.out.println(Thread.currentThread().getName());
        System.out.printf("Work %s started at $s\n",
                id,
                LocalDateTime.now().format(DateTimeFormatter.ofPattern("HH:mm:ss")));

        try{

            time.sleep(1);

        }catch(InterruptedException e){}
        System.out.printf("Work %s finished at %s\n",
                id,
                LocalDateTime.now().format(DateTimeFormatter.ofPattern("HH:mm:ss")));



    }
}
