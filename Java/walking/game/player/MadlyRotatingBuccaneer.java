package walking.game.player;

import walking.game.util.Direction;

public class MadlyRotatingBuccaneer extends Player{
    private int turnCount;

    public void MadlyRotatingBuccaneer(){

    }

    public void turn(){
        for (int i = 0; i < turnCount; i++){
            switch (direction){
                case UP:
                    direction = Direction.RIGHT;
                    break;
                case RIGHT:
                    direction = Direction.DOWN;
                    break;
                case DOWN:
                    direction = Direction.LEFT;
                    break;
                case LEFT:
                    direction = Direction.UP;
                    break;
                default:
                    break;
            }
        }
        turnCount++;
    }
}