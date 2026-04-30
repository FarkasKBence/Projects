package tron;

import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.io.IOException;
import javax.swing.JPanel;
import resource.ResourceLoader;

/**
 *
 * @author Farkas Bence BIV5IL
 */
public class GameVisual extends JPanel {
    private GameSim simulation;
    private final Image wall, empty;
    private Image player1, player2;
    private final int TILESIZE = 16;
    private double scaling;
    private int scaled_size;
    
    public GameVisual(GameSim sim) throws IOException{
        this.simulation = sim;
        this.scaling = 1.0;
        this.scaled_size = (int)(TILESIZE*scaling);
        this.wall = ResourceLoader.loadImage("resource/wall.png");
        this.empty = ResourceLoader.loadImage("resource/empty.png");
        this.player1 = ResourceLoader.loadImage("resource/white.png");
        this.player2 = ResourceLoader.loadImage("resource/white.png");
    }
    
    public void setPlayer1Color(){ player1 = simulation.getPlayer1Color(); }    
    public void setPlayer2Color(){ player2 = simulation.getPlayer2Color(); }
    
    public void setScaling(double scale){
        this.scaling = scale;
        this.scaled_size = (int)(TILESIZE*scaling);
        refresh();
    }
    
    public void refresh(){
        Dimension dim = new Dimension(simulation.getColumns() * scaled_size, simulation.getRows() * scaled_size);
        setPreferredSize(dim); setMaximumSize(dim); setSize(dim);
        repaint();
    }
    
    /**
     * a paintComponent függvény felülírása alapján működik. A metódus megkapja a GameSim változójától a pálya méreteit és a játékosok méretét, majd a beágyazott for ciklusokkal átmegy a pálya mezőin és kiválasztja a hozzá tartozó képet, amit beilleszt a 2D-s grafikába megfelelő méretezés szerint.
     * @param g - a grafikaelem a panelnak
     */
    @Override
    protected void paintComponent(Graphics g) {
        Graphics2D gr = (Graphics2D)g;
        int w = simulation.getColumns() - 1;
        int h = simulation.getRows() - 1;
        Position p1 = simulation.getPlayer1Pos();
        Position p2 = simulation.getPlayer2Pos();
        for (int y = 0; y <= h; y++){
            for (int x = 0; x <= w; x++){
                Image img;
                char sym = simulation.getTile(y,x);
                img = switch (sym) {
                    case '#' -> wall;
                    case ' ' -> empty;
                    case '1' -> player1;
                    case '2' -> player2;
                    default -> empty;
                };
                if (p1.getX() == x && p1.getY() == y) img = player1;
                if (p2.getX() == x && p2.getY() == y) img = player2;
                gr.drawImage(img, x * scaled_size, y * scaled_size, scaled_size, scaled_size, null);
            }
        }
    }
}
