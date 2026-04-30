package tron;

import java.awt.Image;
import java.io.IOException;
import resource.MapLoader;

/**
 *
 * @author Farkas Bence BIV5IL
 */
public class GameSim {
    private char[][] map;
    private Player player1;
    private Player player2;
    
    public GameSim(Player one, Player two) throws IOException{
        player1 = one;
        player2 = two;
    }
    
    /**
     * először ellenőrizzük mindkét játékosra, hogy a következő lépésükkel meghalnának-e. Ha egyik játékos sem halna meg, mindkettőt léptetjük; ha csak az egyik, akkor csak az élőt léptetjük; ha pedig mindketten meghalnak, vagyis döntetlen alakul, akkor nem változik a pálya. A metódusok a végén visszaad egy egész számot, ami egyenlő a halott játékosok sorszámának összegével.
     * @return - meghalt játékosok sorszámainak összege
     */
    public int update(){
        int result = 0;
        Position move1 = player1.premove(); Position move2 = player2.premove();
        
        if (getTile(move1.getY(), move1.getX()) != ' ' ||
            move1.equals(move2) ||
            move1.equals(player2.getPosition())){
            result += 1;
        }
        if (getTile(move2.getY(), move2.getX()) != ' ' ||
            move2.equals(move1) ||
            move2.equals(player1.getPosition())){
            result += 2;
        }
        
        switch (result){
            case 0 -> { 
                setTile(player1.getPosition().getY(),player1.getPosition().getX(), '1');
                player1.move();
                setTile(player2.getPosition().getY(),player2.getPosition().getX(), '2');
                player2.move();
            }
            case 1 -> {
                setTile(player2.getPosition().getY(),player2.getPosition().getX(), '2');
                player2.move();
            }
            case 2 -> {
                setTile(player1.getPosition().getY(),player1.getPosition().getX(), '1');
                player1.move();
            }
        }
        
        return result;
    }
    
    public void loadMap(String mapName){
        map = MapLoader.load(mapName);
        player1.setDirection(MapLoader.loadDir(mapName, 0));
        player2.setDirection(MapLoader.loadDir(mapName, 1));
        player1.setPosition(MapLoader.loadPos(mapName, 0));
        player2.setPosition(MapLoader.loadPos(mapName, 1));
    }
    
    public int getColumns(){ return map[0].length; }
    public int getRows(){ return map.length; }
    public void setTile(int y, int x, char sym){ map[y][x] = sym; }
    public char getTile(int y, int x){ return map[y][x]; }
    public Position getPlayer1Pos(){ return player1.getPosition(); }
    public Position getPlayer2Pos(){ return player2.getPosition(); }
    public Image getPlayer1Color(){ return player1.getColor(); }
    public Image getPlayer2Color(){ return player2.getColor(); }
}
