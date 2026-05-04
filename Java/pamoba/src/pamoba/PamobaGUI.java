package pamoba;

import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;

/**
 * @author Farkas Bence BIV5IL
 */
public class PamobaGUI {

    private JFrame frame;
    private BoardGUI boardGUI;

    private final int INITIAL_HEIGHT = 5;
    private final int INITIAL_WIDTH = 8;

    public PamobaGUI() {
        frame = new JFrame("Potyogós labda");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        boardGUI = new BoardGUI(INITIAL_HEIGHT, INITIAL_WIDTH);
        frame.getContentPane().add(boardGUI.getBoardPanel(), BorderLayout.CENTER);

        JMenuBar menuBar = new JMenuBar();
        frame.setJMenuBar(menuBar);
        JMenu gameMenu = new JMenu("Menü");
        menuBar.add(gameMenu);
        JMenu newMenu = new JMenu("Új Játék");
        gameMenu.add(newMenu);
        int[][] boardSizes  = new int[][]{{5,8}, {6,10}, {7,12}};
        for (int[] boardSize : boardSizes) {
            JMenuItem sizeMenuItem = new JMenuItem(boardSize[1] + "x" + boardSize[0]);
            newMenu.add(sizeMenuItem);
            sizeMenuItem.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {
                    frame.getContentPane().remove(boardGUI.getBoardPanel());
                    boardGUI = new BoardGUI(boardSize[0], boardSize[1]);
                    frame.getContentPane().add(boardGUI.getBoardPanel(), BorderLayout.CENTER);
                    //frame.getContentPane().add(boardGUI.getNextPlayer(), BorderLayout.SOUTH);
                    frame.pack();
                }
            });
        }
        JMenuItem exitMenuItem = new JMenuItem("Kilépés");
        gameMenu.add(exitMenuItem);
        exitMenuItem.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent ae) {
                System.exit(0);
            }
        });

        frame.pack();
        frame.setVisible(true);
    }


}
