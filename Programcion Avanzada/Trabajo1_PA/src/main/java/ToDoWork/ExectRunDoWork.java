package ToDoWork;

public class ExectRunDoWork {

    public static void main(String[] args) {

        for (var id = 0; id <5; id ++){

            // RunDoWork runDoWork = new RunDoWork(id);
            // Thread thread = new Thread(new RunDoWork(id));
            // thread.start();
            new Thread(new RunDoWork(id)).start();

        }
    }
}
