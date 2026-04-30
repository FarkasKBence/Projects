package tron;

import java.util.ArrayList;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.WindowConstants;
import highscore.HighScore;

public class HighScoreWindow extends JDialog{
    private final JTable table;
    
    public HighScoreWindow(ArrayList<HighScore> highScores, JFrame parent){
        super(parent, true);
        String[][] data = new String[highScores.size()][2];
        for (int i = 0; i < highScores.size(); i++){
            data[i][0] = highScores.get(i).getName();
            Integer score = highScores.get(i).getScore();
            data[i][1] = score.toString();
        }
        String[] titles = {"Név", "Pontszám"};
        table = new JTable(data,titles);
        table.setFillsViewportHeight(true);
        
        add(new JScrollPane(table));
        setSize(200,250);
        setTitle("Dicsőség tábla");
        setDefaultCloseOperation(WindowConstants.DISPOSE_ON_CLOSE);
        setLocationRelativeTo(null);
        setVisible(true);
    }
}
