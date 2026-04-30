package walking.game;

import walking.game.player.Player;
import walking.game.player.MadlyRotatingBuccaneer;

public class WalkingBoardWithPlayers extends WalkingBoard {
    private Player[] players;
    private int round;  //feladatleírás nem ad ennek feladatot
    public static final int SCORE_EACH_STEP = 13;

    public WalkingBoardWithPlayers(int[][] board, int playerCount){
        super(board);
        initPlayers(playerCount);
    }

    public WalkingBoardWithPlayers(int size, int playerCount){
        super(size);
        initPlayers(playerCount);
    }

    private void initPlayers(int playerCount){
        if (playerCount < 2){
            throw new IllegalArgumentException();
        }
        players = new Player[playerCount];
        players[0] = new MadlyRotatingBuccaneer();
        for (int i = 1; i < playerCount; i++){
            players[i] = new Player();
        }
    }
    
    public int[] walk(int... stepCounts){
        int player_ind = 0; int steps = 0;   //step_ind = stepsCount paraméter index, player_ind = players adattag index, steps = lépések számlálója, i = segédinex
        for (int step_ind = 0; step_ind < stepCounts.length; step_ind++){
            if (player_ind >= players.length){
                player_ind = 0;
            }

            players[player_ind].turn();
            for (int i = 0; i < stepCounts[step_ind]; i++){
                players[player_ind].addToScore(moveAndSet(players[player_ind].getDirection(), Math.min(SCORE_EACH_STEP, steps)));
                steps++;
            }

            player_ind++;
        }
        
        int[] return_array = new int[players.length];
        for (int i = 0; i < players.length; i++){
            return_array[i] = players[i].getScore();
        }
        return return_array;
    }
}