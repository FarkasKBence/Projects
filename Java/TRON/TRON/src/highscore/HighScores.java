/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package highscore;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Properties;

/**
 *
 * @author bli
 */
public class HighScores {

    private PreparedStatement insertStatement;
    private PreparedStatement deleteStatement;
    private Connection connection;

    public HighScores() throws SQLException {
        Properties connectionProps = new Properties();
        // Add new user -> MySQL workbench (Menu: Server / Users and priviliges)
        //                             Tab: Administrative roles -> Check "DBA" option
        connectionProps.put("user", "root");
        connectionProps.put("password", "asd123");
        connectionProps.put("serverTimezone", "UTC");
        String dbURL = "jdbc:mysql://localhost:3306/highscores";
        connection = DriverManager.getConnection(dbURL, connectionProps);
        
        
        String insertQuery = "INSERT INTO HIGHSCORES (NAME, SCORE) VALUES (?, ?)";
        insertStatement = connection.prepareStatement(insertQuery);
        String deleteQuery = "DELETE FROM HIGHSCORES WHERE NAME=?";
        deleteStatement = connection.prepareStatement(deleteQuery);
    }

    public ArrayList<HighScore> getHighScores(boolean top10) throws SQLException {
        String query = "SELECT * FROM HIGHSCORES";
        ArrayList<HighScore> highScores = new ArrayList<>();
        Statement stmt = connection.createStatement();
        ResultSet results = stmt.executeQuery(query);
        while (results.next()) {
            String name = results.getString("NAME");
            int score = results.getInt("SCORE");
            highScores.add(new HighScore(name, score));
        }
        sortHighScores(highScores);
        
        if (top10){
            ArrayList<HighScore> topHighScores = new ArrayList<>();
            int max = Math.min(10, highScores.size());
            for (int i = 0; i < max; i++) {
                topHighScores.add(highScores.get(i));
            }
            return topHighScores;
        }
        
        return highScores;
    }

    public void putHighScore(String name) throws SQLException {
        ArrayList<HighScore> highScores = getHighScores(false);
        
        boolean alreadyExists = false;
        int scoretotal = 1;
        for (HighScore highScore : highScores){
            if (highScore.getName().equals(name)){
                alreadyExists = true;
                scoretotal = highScore.getScore();
            }
        }
        if (alreadyExists){
            deleteScore(name);
            insertScore(name, scoretotal+1);
        }
        else{
            insertScore(name, scoretotal);
        }
    }

    /**
     * Sort the high scores in descending order.
     * @param highScores 
     */
    private void sortHighScores(ArrayList<HighScore> highScores) {
        Collections.sort(highScores, new Comparator<HighScore>() {
            @Override
            public int compare(HighScore t, HighScore t1) {
                return t1.getScore() - t.getScore();
            }
        });
    }

    private void insertScore(String name, int score) throws SQLException {
        insertStatement.setString(1, name);
        insertStatement.setInt(2, score);
        insertStatement.executeUpdate();
    }

    /**
     * Deletes all the highscores with name.
     *
     * @param name
     */
    private void deleteScore(String name) throws SQLException {
        deleteStatement.setString(1, name);
        deleteStatement.executeUpdate();
    }
}
