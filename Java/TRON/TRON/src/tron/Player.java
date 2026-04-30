package tron;

import java.awt.Image;
import java.io.IOException;
import resource.ResourceLoader;

/**
 *
 * @author Farkas Bence BIV5IL
 */
public class Player {
    private String name;
    private Position pos;
    private Direction dir;
    private Image image = null;
    
    public Player(String name) throws IOException{ this.name = name; }
    
    public Position premove(){ return pos.translate(dir); }
    public void move(){ this.pos = pos.translate(dir); }
    
    public void setDirection(Direction dir){ this.dir = dir; }
    public void updateDirection(Direction dir){
        switch(dir){
            case Direction.UP -> { if (this.dir != Direction.DOWN) {this.dir = dir;} }
            case Direction.DOWN -> { if (this.dir != Direction.UP) {this.dir = dir;} }
            case Direction.LEFT -> { if (this.dir != Direction.RIGHT) {this.dir = dir;} }
            case Direction.RIGHT -> { if (this.dir != Direction.LEFT) {this.dir = dir;} }
        }
    }
    public Direction getDirection(){ return this.dir; }
    public void setPosition(Position pos){ this.pos = pos; }
    public Position getPosition(){ return this.pos; }
    public void setName(String name){
        if (name == null || name.isBlank()){ }
        else {this.name = name;}
    }
    public String getName(){ return name; }
    public Image getColor(){ return this.image; }
    public void setColor(String color) throws IOException{
        switch(color){
            case "Piros" -> this.image = ResourceLoader.loadImage("resource/red.png");
            case "Fehér" -> this.image = ResourceLoader.loadImage("resource/white.png");
            case "Zöld" -> this.image = ResourceLoader.loadImage("resource/green.png");
            case "Kék" -> this.image = ResourceLoader.loadImage("resource/blue.png");
            case "Sárga" -> this.image = ResourceLoader.loadImage("resource/yellow.png");
        }
    }
}
