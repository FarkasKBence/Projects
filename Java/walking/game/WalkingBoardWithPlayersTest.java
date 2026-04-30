package walking.game;

import static check.CheckThat.*;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.condition.*;
import org.junit.jupiter.api.extension.*;
import org.junit.jupiter.params.*;
import org.junit.jupiter.params.provider.*;
import check.*;

public class WalkingBoardWithPlayersTest{
    @Test
    public void walk1(){
        int[][] test_tiles = new int[][]{
            {11, 12, 13, 14, 15, 16},   //0 0-6
            {21, 22, 23, 24, 25},       //1 0-5
            {31, 32, 33, 34},           //2 0-4
            {41, 42, 43},               //3 0-3
            {51, 52, 53, 54, 55},       //4 0-5
            {61, 62, 63, 64, 65, 75}    //5 0-6
        };
        WalkingBoardWithPlayers test = new WalkingBoardWithPlayers(test_tiles, 2);
        int mn = test.BASE_TILE_SCORE; int mx = test.SCORE_EACH_STEP;
        /*
                             0 1 2   4  5  6  7    9  10 11 12 13               23 24               31 32 33 34 35
        player0 - Buccaneer: 0 0 0 | 13 14 15 16 | 6   5 4  3  11             | 21 31             | 13 13 41 51 61 
                             3       8             14 15 16 17 18 19 20 21 22   25 26 27 28 29 30
        player1 - Player   : 12    | 0           | 0  0  0  0  0  0  0  0  0  | 13 13 0  0  0  0

                             0 1 2   4  5  6  7    9  10 11 12 13               23 24               31 32 33 34 35
        player0 - Buccaneer: 0 0 0 | 13 14 15 16 | 6  5  4  3  11             | 21 31             | 25 24 41 51 61
                             3       8             14 15 16 17 18 19 20 21 22   25 26 27 28 29 30
        player1 - Player   : 12    | 0           | 0  0  0  0  0  0  0  0  0  | 23 13 0  0  0  0
        */
        int[][] solution = new int[][]{
            {Math.min(mx,26), Math.min(mx,12), Math.min(mx,11), Math.min(mx,10), Math.min(mx, 9), Math.min(mx, 7)},
            {Math.min(mx,31), Math.max(mn,22), Math.max(mn,23), Math.max(mn,24), Math.max(mn,25)},
            {Math.min(mx,32), Math.max(mn,32), Math.max(mn,33), Math.max(mn,34)},
            {Math.min(mx,33), Math.max(mn,42), Math.max(mn,43)},
            {Math.min(mx,34), Math.max(mn,52), Math.max(mn,53), Math.max(mn,54), Math.max(mn,55)},
            {Math.min(mx,35), Math.max(mn,62), Math.max(mn,63), Math.max(mn,64), Math.max(mn,65), Math.max(mn,75)}
        };
        assertArrayEquals(new int[]
        {
            Math.max(mn,13) + Math.max(mn,14) + Math.max(mn,15) + Math.max(mn,16) +
            Math.max(mn,11) + Math.min(mx, 3) + Math.min(mx, 4) + Math.min(mx, 5) + Math.min(mx, 6) + 
            Math.max(mn,21) + Math.max(mn,31) +
            Math.min(mx,25) + Math.min(mx,24) + Math.max(mn,41) + Math.max(mn,51) + Math.max(mn,61),
            Math.max(mn,12) + Math.min(mx,23) + Math.min(mx,13)
        }, test.walk(3,1,4,1,5,9,2,6,5));
        assertArrayEquals(solution, test.getTiles());
    }

    @Test
    public void walk2(){
        WalkingBoardWithPlayers test = new WalkingBoardWithPlayers(6, 3);
        int mn = test.BASE_TILE_SCORE; int mx = test.SCORE_EACH_STEP;
        /*
                             0    3  4    9  10 11   18 19 20 21   30 31 32 33 34   42 43
        player0 - Buccaneer: 0  | mn mn | mn mn mn | mn 0  0  0  | 24 23 22 21 17 | 37 36
                             1    5  6    12 13 14   22 23 24 25   35 36 37 38      44
        player1 - Player   : mn | mn mn | mn 0  0  | 12 mn mn mn | mn mn mn mn    | 0
                             2    7  8    15 16 17   26 27 28 29   39 40 41
        player1 - Player   : mn | mn mn | 0  0  0  | mn 0  0  0  | mn 0  0
        */
        int[][] solution = new int[][]{
            { Math.min(26, mx), Math.min( 1, mx), Math.min( 2, mx), Math.min( 3, mx), Math.min( 4, mx),               mn},
            { Math.min(30, mx),               mn,               mn,               mn, Math.min( 5, mx),               mn},
            { Math.min(31, mx),               mn,               mn,               mn, Math.min( 6, mx),               mn},
            { Math.min(32, mx),               mn,               mn,               mn, Math.min( 7, mx),               mn},
            { Math.min(33, mx), Math.min(11, mx), Math.min(10, mx), Math.min( 9, mx), Math.min( 8, mx),               mn},
            { Math.min(34, mx), Math.min(35, mx), Math.min(36, mx), Math.min(43, mx), Math.min(42, mx), Math.min(39, mx)}
        };
        assertArrayEquals(new int[]
        {
            6  * mn + Math.min(25, mx)+ Math.min(24, mx)+ Math.min(23, mx)+ Math.min(22, mx)+ Math.min(18, mx)+ Math.min(38, mx)+ Math.min(37, mx),
            11 * mn + Math.min(12, mx),
            5  * mn,
        }, test.walk(1,1,1,2,2,2,3,3,3,4,4,4,5,4,3,2,1));
        assertArrayEquals(solution, test.getTiles());
    }
}