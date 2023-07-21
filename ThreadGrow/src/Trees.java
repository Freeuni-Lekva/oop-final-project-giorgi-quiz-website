import java.util.*;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;


public class Trees {
    public static void main(String[] args) throws InterruptedException {
        List<Integer> trees = Arrays.asList(2, 1, 3, 4, 10, 15, 22, 27, 33, 2, 1);
        Trees t = new Trees(trees);
        t.grow();
    }
    private List<Integer> trees;
    private Lock lock;
    private Lock lock2;
    private Lock lock3;
    private Condition con;
    private Condition con2;
    private Condition con3;
    private int counter;
    private int counter2;

    public Trees(List<Integer> trees) {
        this.trees = trees;
        this.lock = new ReentrantLock();
        this.lock2 = new ReentrantLock();
        this.con = lock.newCondition();
        this.con2 = lock2.newCondition();
        this.counter = 0;
        this.counter2 = trees.size();
        lock3 = new ReentrantLock();
        this.con3 = lock3.newCondition();
    }

    public void grow() throws InterruptedException {
        System.out.println(trees);
        for(int i = 0; i < trees.size(); i++) {
            int finalI = i;
            Thread thread = new Thread(new Runnable() {
                @Override
                public void run() {
                    try {
                        growIthTree(finalI);
                    } catch (InterruptedException e) {
                        throw new RuntimeException(e);
                    }
                };
            });
            thread.start();
        }
        lock3.lock();
        con3.await();

        System.out.println("Happy Tree Friends");
    }

    public void growIthTree(int treeIndex) throws InterruptedException {
        if(trees.size() == 0 || trees.size() == 1) return;
        while(true) {
            // გაზრდა
            int height = trees.get(treeIndex);
            if(treeIndex == 0) {
                if(height < trees.get(treeIndex + 1)) {
                    height = trees.get(treeIndex + 1);
                }
            } else if(treeIndex == trees.size() - 1) {
                if(height < trees.get(trees.size() - 2)) {
                    height = trees.get(trees.size() - 2);
                }
            } else {
                height = Math.max(height, Math.max(trees.get(treeIndex - 1), trees.get(treeIndex + 1)));
            }
            // დაველოდოთ გაზრდას
            lock.lock();
            counter++;
            if(counter < trees.size()) {
                con.await();
            }
            con.signalAll();
            counter = 0;
            lock.unlock();
            // ჩავწეროთ
            trees.set(treeIndex, height);
            // დავალოდოთ ჩაწერას
            lock2.lock();
            counter2--;
            if(counter2 == 0)
                System.out.println(trees.toString());
            if(counter2 > 0) {
                con2.await();
            }
            con2.signalAll();
            counter2 = trees.size();
            lock2.unlock();
            if(trees.stream().distinct().count() == 1) {
                lock3.lock();
                con3.signal();
                lock3.unlock();
                break;
            }
        }
    }
}