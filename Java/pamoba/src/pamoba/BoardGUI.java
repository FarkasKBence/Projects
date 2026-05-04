package pamoba;

import java.awt.Dimension;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;
import javax.swing.JOptionPane;
import javax.swing.JPanel;

/**
 * @author Farkas Bence BIv5IL
 */
public class BoardGUI {
    private JButton[][] buttons;
    private Board board;
    private JPanel boardPanel;

    public BoardGUI(int y, int x) {
        board = new Board(y, x);
        boardPanel = new JPanel();
        boardPanel.setLayout(new GridLayout(board.getBoardY(), board.getBoardX()));
        buttons = new JButton[board.getBoardY()][board.getBoardX()];
        for (int i = 0; i < board.getBoardY(); ++i) {
            for (int j = 0; j < board.getBoardX(); ++j) {
                JButton button = new JButton();
                button.addActionListener(new ButtonListener(i, j));
                button.setPreferredSize(new Dimension(60, 60));
                buttons[i][j] = button;
                button.setEnabled(false);
                boardPanel.add(button);
            }
        }
        for (int j = 0; j < board.getBoardX(); ++j){ buttons[board.getBoardY() - 1][j].setEnabled(true); }
    }
    
    /**
     * Frissíti a legutóbb lerakott peták gombjának kinézetét.
     * @param y     Y koordináta
     * @param x     X koordináta
     */
    private void refresh(int y, int x) {
        JButton button = buttons[y][x];
        Disc disc = board.get(y, x);
        button.setBackground(disc.getColor());
        button.setText(String.valueOf(disc.getSym()));
        if (y != 0){ buttons[y - 1][x].setEnabled(true); }
    }
    
    /**
     * Visszarakja a gombmátrixot kezdeti állapotába
     */
    private void restart(){
        board = new Board(board.getBoardY(), board.getBoardX());
        for (int i = 0; i < board.getBoardY(); ++i) {
            for (int j = 0; j < board.getBoardX(); ++j) {
                JButton button = buttons[i][j];
                button.setText("");
                button.setBackground(null);
                button.setEnabled(false);
            }
        }
        for (int j = 0; j < board.getBoardX(); ++j){ buttons[board.getBoardY() - 1][j].setEnabled(true); }
    }
    
    public JPanel getBoardPanel() {
        return boardPanel;
    }

    class ButtonListener implements ActionListener {

        private int x, y;

        public ButtonListener(int y, int x) {
            this.x = x;
            this.y = y;
        }

        @Override
        public void actionPerformed(ActionEvent e) {
            System.out.println(y + " " + x);
            if (board.place(y, x)){
                System.out.println("siker");
                refresh(y,x);
                if (board.isWon(y, x)){
                    JOptionPane.showMessageDialog(boardPanel, board.get(y,x).getSym() + " megnyerte a jatekot!\nUj jatek kezdese...", "Gratulalok!", JOptionPane.INFORMATION_MESSAGE);
                    restart();
                }
                else if (board.isDraw()){
                    JOptionPane.showMessageDialog(boardPanel, "Tele lett a matrix! Uj jatek kezdese...", "Dontetlen!", JOptionPane.INFORMATION_MESSAGE);
                    restart();
                }
            }
        }
    }
}
