package ToDoWork;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.concurrent.TimeUnit;

// Alternatva 2: Implementar la interfaz Runnable
public class RunDoWork implements Runnable{

    private static TimeUnit time = TimeUnit.SECONDS;
    private int id;
    public RunDoWork(int id){

        this.id = id;

    }

    @Override
    public void run() {

        System.out.printf("Work %s started at %s\n",
                id,
                LocalDateTime.now().format(DateTimeFormatter.ofPattern("HH:mm:ss")));

        try{

            time.sleep(1);

        }catch(InterruptedException e){}
        System.out.printf("Work %s finished at $s\n",
                id,
                LocalDateTime.now().format(DateTimeFormatter.ofPattern("HH:mm:ss")));

    }

}
