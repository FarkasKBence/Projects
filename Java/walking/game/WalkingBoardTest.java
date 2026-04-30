package walking.game;

import walking.game.util.Direction;
import walking.game.WalkingBoard;

import static check.CheckThat.*;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.condition.*;
import org.junit.jupiter.api.extension.*;
import org.junit.jupiter.params.*;
import org.junit.jupiter.params.provider.*;
import check.*;

public class WalkingBoardTest{

    @ParameterizedTest(name = "size {0}:")
    @CsvSource(textBlock = """
        0
        1
        2
        3
        4
        5
        10
    """)
    public void testSimpleInit(int size){
        WalkingBoard test = new WalkingBoard(size);
        int base = test.BASE_TILE_SCORE;
        assertEquals(size, test.getTiles().length);
        for (int i = 0; i < test.getTiles().length; i++){
            assertEquals(size, test.getTiles()[i].length);
        }
        for (int i = 0; i < size; i++){
            for (int j = 0; j < size; j++){
                assertEquals(base, test.getTile(j, i));
            }
        }
    }

    @ParameterizedTest(name = "x: {0}, y: {1} = {2}")
    @CsvSource(textBlock = """
        0, 0, 1
        5, 0, 6
        1, 1, 3
        2, 2, 5
        2, 3, 4
        4, 4, 5
        1, 5, 1
        5, 5, 5
    """)
    public void testCustomInit(int x, int y, int expected){
        int[][] test_tiles = new int[][]{
            {1, 2, 3, 4, 5, 6}, //0 0-6
            {2, 3, 4, 5, 6},    //1 0-5
            {3, 4, 5, 6},       //2 0-4
            {2, 3, 4},          //3 0-3
            {1, 2, 3, 4, 5},    //4 0-5
            {0, 1, 2, 3, 4, 5}  //5 0-6
        };
        WalkingBoard test = new WalkingBoard(test_tiles);
        int base = test.BASE_TILE_SCORE;
        assertEquals(Math.max(base, expected), test.getTile(x,y));
        test_tiles[y][x] += 100;
        assertEquals(Math.max(base, expected), test.getTile(x, y));
        test.getTiles()[y][x] += 100;
        assertEquals(Math.max(base, expected), test.getTile(x, y));
    }

    @Test
    public void testMoves(){
        int[][] test_tiles = new int[][]{{11,12},{21,22}};
        WalkingBoard test = new WalkingBoard(test_tiles);
        //le
        assertEquals(test.getTile(0,1), test.moveAndSet(Direction.DOWN, 111));
        assertEquals(test.getTile(0,1), 111);
        assertEquals(test.getPosition()[0], 0);
        assertEquals(test.getPosition()[1], 1);
        //balra
        assertEquals(0, test.moveAndSet(Direction.LEFT, 222));  //kilépne (-1, 1)
        assertEquals(test.getTile(0,1), 111);
        assertEquals(test.getPosition()[0], 0);
        assertEquals(test.getPosition()[1], 1);
        //jobb
        assertEquals(test.getTile(1,1), test.moveAndSet(Direction.RIGHT, 333));
        assertEquals(test.getTile(1,1), 333);
        assertEquals(test.getPosition()[0], 1);
        assertEquals(test.getPosition()[1], 1);
        //fel
        assertEquals(test.getTile(1,0), test.moveAndSet(Direction.UP, 444));
        assertEquals(test.getTile(1,0), 444);
        assertEquals(test.getPosition()[0], 1);
        assertEquals(test.getPosition()[1], 0);
        //balra
        assertEquals(test.getTile(0,0), test.moveAndSet(Direction.LEFT, 555));
        assertEquals(test.getTile(0,0), 555);
        assertEquals(test.getPosition()[0], 0);
        assertEquals(test.getPosition()[1], 0);
    }
}