package resource;

import java.util.Random;
import tron.Direction;
import tron.Position;

/**
 *
 * @author Farkas Bence BIV5IL
 */
public class MapLoader {
    
    private static final Position small[] = {new Position(2,2), new Position(62,32)};
    private static final Position medium[] = {new Position(2,2), new Position(82,52)};
    private static final Position large[] = {new Position(2,2), new Position(112,82)};
    private static final Direction rectangle[] = {Direction.DOWN, Direction.UP};
    
    /**
     * a metódus kap két egész számot – ami egyenlő a pálya méretével, és egy bool értéket – hogy akarunk-e akadályokat a pályánkra; és egy 2D-s char tömböt kapunk vissza, ami a pályánk lesz. Két egymásba ágyazott for ciklussal kitöltjük üres mezőkkel vagy falmezőkkel a tömbünket, attól függően, hogy a pálya szélén vagyunk-e vagy sem. Ha akarunk akadályokat a pályánkra, akkor annyi 3x3-s elemet rakunk le, ami egyenlő a pálya hossza és nagyságával osztva 100-al. Az alakzatokat véletlenszerűen rakjuk le, vigyázva arra, hogy a pálya játszható maradjon, ezért a külső falakhoz 3 vastagságban nem engedjük az akadályok lerakását.
     * @param y - pálya y nagysága
     * @param x - pálya x nagysága
     * @param hasObstacles  - van-e vagy nincs akadály
     * @return 
     */
    private static char[][] makeRectangleMap(int y, int x, boolean hasObstacles){
        char[][] map = new char[y][x];
        
        for (int i = 0; i < y; i++){
            for (int j = 0; j < x; j++){
                if (i == 0 || i == y - 1 || j == 0 || j == x - 1){
                    map[i][j] = '#';
                } else{
                    map[i][j] = ' ';
                }
            }
        }
        
        if (hasObstacles){
            Random rn = new Random();
            int ox, oy, maxX, minX, maxY, minY;
            minY = 4; maxY = y - 7;
            minX = 4; maxX = x - 7;
            for (int i = 0; i < x * y / 100; i++){
                ox = rn.nextInt(maxX - minX + 1) + minX;
                oy = rn.nextInt(maxY - minY + 1) + minY;
                
                map[oy+0][ox+0] = '#'; map[oy+1][ox+0] = ' '; map[oy+2][ox+0] = '#';
                map[oy+0][ox+1] = ' '; map[oy+1][ox+1] = ' '; map[oy+2][ox+1] = ' ';
                map[oy+0][ox+2] = '#'; map[oy+1][ox+2] = ' '; map[oy+2][ox+2] = '#';
            }
        }
        
        return map;
    }
    
    public static char[][] load(String mapName){
        switch(mapName){
            case "Kicsi" -> { return makeRectangleMap(35,65, false); }
            case "Közepes" -> { return makeRectangleMap(55,85, false); }
            case "Nagy" -> { return makeRectangleMap(85,115, false); }
            case "Kicsi - Nehéz" -> { return makeRectangleMap(35,65, true); }
            case "Közepes - Nehéz" -> { return makeRectangleMap(55,85, true); }
            case "Nagy - Nehéz" -> { return makeRectangleMap(85,115, true); }
            default  -> { return makeRectangleMap(85,115, false); }
        }
    }
    public static Position loadPos(String mapName, int playerNum){
        switch(mapName){
            case "Kicsi" -> { return small[playerNum]; }
            case "Közepes" -> { return medium[playerNum]; }
            case "Nagy" -> { return large[playerNum]; }
            case "Kicsi - Nehéz" -> { return small[playerNum]; }
            case "Közepes - Nehéz" -> { return medium[playerNum]; }
            case "Nagy - Nehéz" -> { return large[playerNum]; }
            default  -> { return small[playerNum]; }
        }
    }
    public static Direction loadDir(String mapName, int playerNum){
        switch(mapName){
            case "Kicsi" -> { return rectangle[playerNum]; }
            case "Közepes" -> { return rectangle[playerNum]; }
            case "Nagy" -> { return rectangle[playerNum]; }
            case "Kicsi - Nehéz" -> { return rectangle[playerNum]; }
            case "Közepes - Nehéz" -> { return rectangle[playerNum]; }
            case "Nagy - Nehéz" -> { return rectangle[playerNum]; }
            default  -> { return rectangle[playerNum]; }
        }
    }
}
