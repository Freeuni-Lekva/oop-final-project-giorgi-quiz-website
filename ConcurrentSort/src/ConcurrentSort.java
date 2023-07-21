import java.lang.reflect.Array;
import java.util.Arrays;
import java.util.Comparator;

// Press Shift twice to open the Search Everywhere dialog and type `show whitespaces`,
// then press Enter. You can now see whitespace characters in your code.
public class ConcurrentSort {

    private static class SortSmall<T> implements Runnable{
        private int start;
        private int end;
        private T[] list;
        private Comparator<T> comparator;

        public SortSmall(int start, int end, T[] list, Comparator<T> comparator){
            this.start = start;
            this.end = end;
            this.list = list;
            this.comparator = comparator;
        }


        @Override
        public void run() {
            Arrays.sort(list, start, end, comparator);
        }
    }

    private static class MergeParts<T> implements Runnable{
        private T[] list;
        private Comparator<T> comparator;

        @Override
        public void run() {

        }
    }

    public static <T> T[] sort(T[] list, int num_threads, Comparator<T> comparator) throws InterruptedException {
        int len = list.length / num_threads + 1;
        Thread[] threads = new Thread[num_threads];
        for(int i = 0; i < num_threads; i++){
            int start = i * len;
            int end = start + len;
            if(i == num_threads - 1){
                end = list.length;
            }
            threads[i] = new Thread(new SortSmall<T>(start, end, list, comparator));
            threads[i].start();
        }
        for(int i = 0; i < num_threads; i++){
            threads[i].join();
        }



    }


    public static void main(String[] args) {
        // Press Alt+Enter with your caret at the highlighted text to see how
        // IntelliJ IDEA suggests fixing it.
        System.out.printf("Hello and welcome!");

        // Press Shift+F10 or click the green arrow button in the gutter to run the code.
        for (int i = 1; i <= 5; i++) {

            // Press Shift+F9 to start debugging your code. We have set one breakpoint
            // for you, but you can always add more by pressing Ctrl+F8.
            System.out.println("i = " + i);
        }
    }
}