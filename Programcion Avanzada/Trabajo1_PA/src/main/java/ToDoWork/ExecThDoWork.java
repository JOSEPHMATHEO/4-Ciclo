package ToDoWork;

public class ExecThDoWork {

    public static void main(String[] args) {

        for (int id = 0; id < 5; id++){

            ThDoWork thDoWork = new ThDoWork(id);
            thDoWork.start();

        }
    }
}
