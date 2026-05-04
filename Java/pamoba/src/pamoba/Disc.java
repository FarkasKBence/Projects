package pamoba;
import java.awt.Color;
/**
 * @author Farkas Bence BIV5IL
 */
public class Disc {
    private Color color;
    private char sym;
    
    public Disc(){
        this.color = null;
        this.sym = ' ';
    }

    public Color getColor() {
        return color;
    }

    public void setColor(Color color) {
        this.color = color;
    }

    public char getSym() {
        return sym;
    }

    public void setSym(char sym) {
        this.sym = sym;
    }
}
