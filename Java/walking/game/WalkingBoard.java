package walking.game;

import walking.game.util.Direction;

public class WalkingBoard{
    private int[][] tiles;
    private int x;
    private int y;
    public static final int BASE_TILE_SCORE = 3;

    public WalkingBoard(int size){
        this.tiles = new int[size][size];
        for (int i = 0; i < size; i++){
            for (int j = 0; j < size; j++){
                tiles[i][j] = BASE_TILE_SCORE;
            }
        }
    }

    public WalkingBoard(int[][] tiles){
        this.tiles = tiles.clone();
        for (int i = 0; i < this.tiles.length; i++){
            this.tiles[i] = tiles[i].clone();
            for (int j = 0; j < this.tiles[i].length; j++){
                this.tiles[i][j] = Math.max(BASE_TILE_SCORE, this.tiles[i][j]);
            }
        }
    }

    public int[] getPosition(){
        return new int[]{this.x, this.y};
    }

    public boolean isValidPosition(int x, int y){ //bajos
        if ((y < 0 || y >= tiles.length) || (x < 0 || x >= tiles[y].length))
            return false;
        return true;
    }

    public int getTile(int x, int y){
        if (isValidPosition(x, y))
            return tiles[y][x];
        else
            throw new IllegalArgumentException();
    }

    public int[][] getTiles(){
        int[][] return_tiles = new int[tiles.length][];
        for (int i = 0; i < tiles.length; i++){
            return_tiles[i] = tiles[i].clone();
        }
        return return_tiles;
    }

    public static int getXStep(Direction direction){
        switch (direction){
            case UP:
                return 0;
            case DOWN:
                return 0;
            case LEFT:
                return -1;
            case RIGHT:
                return 1;
            default:
                return 0;
        }
    }

    public static int getYStep(Direction direction){
        switch (direction){
            case UP:
                return -1;
            case DOWN:
                return 1;
            case LEFT:
                return 0;
            case RIGHT:
                return 0;
            default:
                return 0;
        }
    }

    public int moveAndSet(Direction direction, int value){
        if (isValidPosition(x + getXStep(direction), y + getYStep(direction))){
            x += getXStep(direction);
            y += getYStep(direction);
            int regi_ertek = getTile(x, y);
            tiles[y][x] = value;
            return regi_ertek;
        }
        else
            return 0;
    }
}
