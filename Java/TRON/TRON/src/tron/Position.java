package tron;

/**
 *
 * @author Farkas Bence BIV5IL
 */
public class Position {
    private int x, y;

    public Position(int x, int y) {
        this.x = x;
        this.y = y;
    }    
    
    public int getX(){ return this.x; }
    public int getY(){ return this.y; }
    
    public Position translate(Direction d){
        return new Position(x + d.x, y + d.y);
    }
    
    @Override
    public boolean equals(Object o) {
        if (o == this) {
            return true;
        }
        
        if (!(o instanceof Position)) {
            return false;
        }
        
        Position c = (Position) o;
        return Integer.compare(x, c.x) == 0 && Integer.compare(y, c.y) == 0;
    }
    @Override
    public String toString() {
        return this.x + "x + " + this.y + "y";
    }
}
