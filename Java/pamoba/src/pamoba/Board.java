package pamoba;

import java.awt.Color;
import static java.lang.Integer.max;

/**
 * @author Farkas Bence BIv5IL
 */
public class Board {
    private Disc[][] board;
    private final int boardY;
    private final int boardX;
    private int counter;

    public Board(int y, int x) {
        this.counter = 0;
        this.boardY = y;
        this.boardX = x;
        board = new Disc[this.boardY][this.boardX];
        for (int i = 0; i < this.boardY; ++i) {
            for (int j = 0; j < this.boardX; ++j) {
                board[i][j] = new Disc();
            }
        }
    }
    
    /**
     * Átszínezi a soron lévő játékos színeire az üres mezőt.
     * @param row       Y koordináta
     * @param column    X koordináta
     * @return boolean: true, ha le tudott helyezni, false, ha nem
     */
    public boolean place(int row, int column){
        if (board[row][column].getSym() == ' ' && (row == boardY - 1 || board[row+1][column].getSym() != ' ')){
            if (counter % 2 == 0){
                board[row][column].setSym('X');
                board[row][column].setColor(new Color(220,20,60));
            }
            else{
                board[row][column].setSym('O');
                board[row][column].setColor(new Color(95,158,160));
            }
            counter++;
            return true;
        }
        return false;
    }
    
    /**
     * Megnézi a legutóbb lerakott koordináta helyén, hogy megvan-e víszintesen vagy átlósan négy ugyanolyan színű peták.
     * @param row       Y koordináta
     * @param column    X koordináta
     * @return boolean: true, ha nyert, false, ha nem
     */
    public boolean isWon(int row, int column){
        char sym = board[row][column].getSym();
        
        //vízszintes
        int count = 0; int i = 0;
        while (i < boardX && count != 4){
            if (board[row][i].getSym() == sym){ count++; }
            else{ count = 0; }
            i++;
        }
        if (count == 4) { return true; }
        //le átló
        count = 0; i = 0;
        while ((i + max(0, row - column)) < boardY &&
               (i + max(0, column - row)) < boardX && count != 4){
            if (board[i + max(0, row - column)][i + max(0, column - row)].getSym() == sym){ count++; }
            else{ count = 0; }
            i++;
        }
        if (count == 4) { return true; }
        //fel átló
        count = 0; i = 0;
        while (i + column - (boardY - 1 - row) + max(0,boardY - row - column - 1) < boardX &&
               boardY - 1 - i - max(0,boardY - row - column - 1) > -1 &&
               count != 4){
            if (board[boardY - 1 - i - max(0,boardY - row - column - 1)][i + column - (boardY - 1 - row) + max(0,boardY - row - column - 1)].getSym() == sym){ count++; }
            else{ count = 0; }
            i++;
        }
        if (count == 4) { return true; }
        return false;
    }
    
    public boolean isDraw(){
        return counter == boardY * boardX;
    }

    public int getBoardY() {
        return boardY;
    }

    public int getBoardX() {
        return boardX;
    }
    
    public Disc get(int y, int x){
        return board[y][x];
    }
}
