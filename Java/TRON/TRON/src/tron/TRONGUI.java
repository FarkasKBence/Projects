package tron;

import highscore.HighScores;
import resource.ResourceLoader;

import java.awt.BorderLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.AbstractAction;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.Timer;

/**
 *
 * @author Farkas Bence BIV5IL
 */
public class TRONGUI extends JFrame {
    //JÁTÉKELEMEK
    private GameSim game;
    private GameVisual board;
    private Player player1;
    private Player player2;
    private Timer timer;
    private HighScores highScores;
    
    private Timer labeltimer;
    private double time;
    private boolean started;
    private String currentMap = "Közepes";
    //JSWING
    private JPanel inputPanel;
    private JMenu speedMenu;
    private JLabel timeLabel;
    
    public TRONGUI() throws IOException{
        //JÁTÉKADATOK
        player1 = new Player("Kevin Flynn");
        player2 = new Player("Ed Dillinger");
        game = new GameSim(player1, player2);
        board = new GameVisual(game);
        try { highScores = new HighScores(); }
        catch (SQLException ex) { System.out.println("SQL hiba"); }
        setTimer(1);
        setLabelTimer();
        game.loadMap("Közepes");
        board.setScaling(0.75);
        
        //JFRAME INITIALIZÁLÁSA
        setTitle("TRON");
        setSize(600, 600);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setIconImage(ResourceLoader.loadImage("resource/wall.png"));
        
        //IDŐMÉRŐ
        timeLabel = new JLabel("Eltelt idő: 0.0 mp");
        add(timeLabel, BorderLayout.NORTH);
        
        //MENÜSOR MEGALKOTÁSA
        JMenuBar menuBar = new JMenuBar();
        JMenu gameMenu = new JMenu("Új Játék");
        JMenu levelMenu = new JMenu("Pályák");
        String levelNames[] = {"Kicsi", "Közepes", "Nagy", "Kicsi - Nehéz", "Közepes - Nehéz", "Nagy - Nehéz" };
        for (String level : levelNames){
            JMenuItem levelItem = new JMenuItem(new AbstractAction(level) {
            @Override
            public void actionPerformed(ActionEvent e) {
                currentMap = level;
                inputPanel.setVisible(true);
                game.loadMap(level);
                stop();
                board.refresh();
                pack();
            }
        });
            levelMenu.add(levelItem);
        }
        JMenu scaleMenu = new JMenu("Méretezés");
        speedMenu = new JMenu("Sebesség");
        double scaling[] = {0.5,0.75,1.0,1.25,1.5,2.0};
        for (double scale : scaling){
            JMenuItem scaleItem = new JMenuItem(new AbstractAction(scale + "x") {
                @Override
                public void actionPerformed(ActionEvent e) {
                    board.setScaling(scale);
                    pack();
                }
            });
            scaleMenu.add(scaleItem);
            JMenuItem speedItem = new JMenuItem(new AbstractAction(scale + "x") {
                @Override
                public void actionPerformed(ActionEvent e) {
                    setTimer(1 / scale);
                }
            });
            speedMenu.add(speedItem);
        }
        JMenuItem leaderboardMenu = new JMenuItem(new AbstractAction("Dicsőség tábla") {
            @Override
            public void actionPerformed(ActionEvent e) {              
                try { System.out.println(highScores.getHighScores(true));
                new HighScoreWindow(highScores.getHighScores(true), TRONGUI.this); }
                catch (SQLException ex) { System.out.println("SQL hiba"); }
            }
        });
        JMenuItem exitMenu = new JMenuItem(new AbstractAction("Kilépés") {
            @Override
            public void actionPerformed(ActionEvent e) {
                System.exit(0);
            }
        });
        menuBar.add(gameMenu);  gameMenu.add(levelMenu); gameMenu.add(scaleMenu); gameMenu.add(speedMenu); gameMenu.add(leaderboardMenu); gameMenu.add(exitMenu);
        
        //BEMENET KEZELŐK
        inputPanel = new JPanel();
        inputPanel.setLayout(new GridLayout(2, 3));
        String[] choices = { "Fehér", "Piros", "Sárga", "Zöld", "Kék"};
        JLabel player1Label = new JLabel("WASD Játékos:"); JTextField nameInput1 = new JTextField(10); JComboBox<String> colorInput1 = new JComboBox<>(choices);
        JLabel player2Label = new JLabel("NYÍL Játékos:"); JTextField nameInput2 = new JTextField(10); JComboBox<String> colorInput2 = new JComboBox<>(choices);
        colorInput1.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent ae) {
                try {
                    player1.setColor(colorInput1.getSelectedItem().toString());
                    board.setPlayer1Color();
                    board.refresh();
                    pack();
                } catch (IOException ex) { }
            }
        });
        colorInput2.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent ae) {
                try {
                    player2.setColor(colorInput2.getSelectedItem().toString());
                    board.setPlayer2Color();
                    board.refresh();
                    pack();
                } catch (IOException ex) { }
            }
        });
        inputPanel.add(player1Label); inputPanel.add(nameInput1); inputPanel.add(colorInput1);
        inputPanel.add(player2Label); inputPanel.add(nameInput2); inputPanel.add(colorInput2);
        add(BorderLayout.SOUTH, inputPanel);
        add(BorderLayout.CENTER, board);
        
        //GOMB- ÉS EGÉRÉRZÉKELŐK
        addMouseListener(new MouseListener(){
            @Override
            public void mouseClicked(MouseEvent e){
                if (!started){
                    player1.setName(nameInput1.getText()); player2.setName(nameInput2.getText());
                    labelstart(); start(); inputPanel.setVisible(false); pack();
                }
            }

            @Override
            public void mousePressed(MouseEvent e) { }
            @Override
            public void mouseReleased(MouseEvent e) {  }
            @Override
            public void mouseEntered(MouseEvent e) {  }
            @Override
            public void mouseExited(MouseEvent e) {  }
        });
        
        addKeyListener(new KeyAdapter() {
            @Override
            public void keyPressed(KeyEvent ke) {
                super.keyPressed(ke); 
                //if (!board.isStarted()) return;
                int kk = ke.getKeyCode();
                switch (kk){
                    case KeyEvent.VK_LEFT:  player2.updateDirection(Direction.LEFT);   break;
                    case KeyEvent.VK_RIGHT: player2.updateDirection(Direction.RIGHT);  break;
                    case KeyEvent.VK_UP:    player2.updateDirection(Direction.UP);     break;
                    case KeyEvent.VK_DOWN:  player2.updateDirection(Direction.DOWN);   break;
                    case KeyEvent.VK_A:     player1.updateDirection(Direction.LEFT);   break;
                    case KeyEvent.VK_D:     player1.updateDirection(Direction.RIGHT);  break;
                    case KeyEvent.VK_W:     player1.updateDirection(Direction.UP);     break;
                    case KeyEvent.VK_S:     player1.updateDirection(Direction.DOWN);   break;
                }
            }
        });
        
        //JFRAME INDÍTÁSA
        setFocusable(true);
        requestFocus(); 
        setResizable(false);
        setLocationRelativeTo(null);
        setJMenuBar(menuBar);
        pack();
        setVisible(true);
    }
    
    private void start() { timer.start(); started = true; speedMenu.setEnabled(false); }
    private void stop() { timer.stop(); started = false; speedMenu.setEnabled(true); }
    private void labelstart() { labeltimer.start(); }
    private void labelstop() { labeltimer.stop(); }
    private void setTimer(double interval){
        timer = new Timer((int)(100*interval), new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent ae) {
                try {
                    switch(game.update()){
                        case 0: break;  //minden okés
                        case 1: handleWin(player2); break;
                        case 2: handleWin(player1); break;
                        case 3: handleDraw();       break;
                    }
                    board.repaint();
                } catch (SQLException ex) {
                    Logger.getLogger(TRONGUI.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        });
    }
    private void setLabelTimer(){
        labeltimer = new Timer((int)(100), new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent ae) { time++; updateTime(); }
        });
    }
    private void updateTime(){
        timeLabel.setText("Eltelt idő: " + Double.toString(time/10)+ " mp");
    }
    private void handleWin(Player player) throws SQLException{
        stop(); labelstop();
        highScores.putHighScore(player.getName());
        JOptionPane.showInternalMessageDialog(null, player.getName() + " megnyerte a játékot!", "Győzelem", JOptionPane.INFORMATION_MESSAGE);
        game.loadMap(currentMap);
        inputPanel.setVisible(true);
        time = 0; updateTime();
        pack();
    }
    private void handleDraw(){
        stop(); labelstop();
        JOptionPane.showInternalMessageDialog(null, "A két játékos egyszerre halt meg!", "Döntetlen!", JOptionPane.INFORMATION_MESSAGE);
        game.loadMap(currentMap);
        inputPanel.setVisible(true);
        time = 0; updateTime();
        pack();
    }
}
