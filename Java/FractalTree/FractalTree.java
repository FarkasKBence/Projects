import java.awt.*;
import java.util.concurrent.*;
import java.util.concurrent.atomic.AtomicInteger;
import javax.swing.*;

public class FractalTree extends Canvas {
    /* Variables with class-wide visibility */
    private static boolean slowMode;
    
    private static final int QUEUE_CAPACITY = 1000;
    private final BlockingQueue<Line> queue = new LinkedBlockingQueue<>(QUEUE_CAPACITY);

	private static final int POOL_SIZE = 128;
    private static final int START_HEIGHT = 15;
    private static final int SCREEN_X = 1600;
    private static final int SCREEN_Y = 1000;
    private static final int ANGLE_DIFF = 12;
    
    private static final AtomicInteger ongoing = new AtomicInteger(0);
    private static final Object lock = new Object();

    private void submit(Runnable r, ExecutorService pool) {
        ongoing.incrementAndGet();
        pool.submit(() -> {
            try {  r.run(); }
            finally {
                int remaining = ongoing.decrementAndGet();
                if (remaining == 0) {
                    synchronized (lock) { lock.notifyAll(); }
                }
            }
        });
    }

    //strukt
    private static class Line {
        final int x1, y1, x2, y2;
        final Color color;
        public Line(int x1, int y1, int x2, int y2, Color color) {
            this.x1 = x1;
            this.y1 = y1;
            this.x2 = x2;
            this.y2 = y2;
            this.color = color;
        }
    }

    /* Recursive function for calculating all drawcalls for the fractal tree */
    public void makeFractalTree(int x, int y, int angle, int height, ExecutorService pool) {

        if (slowMode) {
            try {Thread.sleep(41);}
            catch (InterruptedException ie) {ie.printStackTrace();}
        }

        if (height == 0) return;

        int x2 = x + (int)(Math.cos(Math.toRadians(angle)) * height * 8);
        int y2 = y + (int)(Math.sin(Math.toRadians(angle)) * height * 8);
        Color color = (height < 5) ? Color.GREEN : Color.BLACK;

        try {
            queue.put(new Line(x, y, x2, y2, color));
        } 
        catch (InterruptedException ie) {ie.printStackTrace();}

        submit(() -> makeFractalTree(x2, y2, 360 - (int)(Math.random() * 181), height-1, pool), pool);
        makeFractalTree(x2, y2, 360 - (int)(Math.random() * 181), height-1, pool);
    }

    /* Code for EDT */
    /* Must only contain swing code (draw things on the screen) */
    /* Must not contain calculations (do not use math and compute libraries here) */
    /* No need to understand swing, a simple endless loop that draws lines is enough */
    @Override
    public void paint(Graphics g) {
        while(true) {
            try {
                final Line L = queue.take();
                g.setColor(L.color);
                g.drawLine(L.x1, L.y1, L.x2, L.y2);
            }
            catch (InterruptedException ie) {ie.printStackTrace();}
        }
    }

    /* Code for main thread */
    public static void main(String args[]) {
		var pool = Executors.newFixedThreadPool(POOL_SIZE);
        
        /* Parse args */
        slowMode = true; //args.length != 0 && Boolean.parseBoolean(args[0]);

        /* Initialize graphical elements and EDT */
        JFrame frame = new JFrame();
        FractalTree tree = new FractalTree();
        frame.setSize(SCREEN_X,SCREEN_Y);
        frame.setVisible(true);
        frame.add(tree);
        //frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        //tree.makeFractalTree(390, 480, -90, 10, pool);

        tree.submit(() -> tree.makeFractalTree(SCREEN_X / 2, SCREEN_Y, -90, START_HEIGHT, pool), pool);
        synchronized (lock) {
            while (ongoing.get() != 0) {
                try { lock.wait(); } 
                catch (InterruptedException ie) {ie.printStackTrace();}
            }
        }
        pool.shutdown();

        /* Log success as last step */
        System.out.println("Main has finished");
    }
}
