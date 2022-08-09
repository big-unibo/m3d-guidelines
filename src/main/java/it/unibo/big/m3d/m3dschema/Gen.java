package it.unibo.big.m3d.m3dschema;

import it.unibo.big.m3d.Main;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;

public class Gen {

    public String tableName;
    public int minId;
    public int maxId;

    public void runGenerator(Connection conn){
        this.initialize();
        this.saveToDb(conn);
        this.getIdsFromDb(conn);
    }

    public void getIdsFromDb(Connection conn){
        try {
            PreparedStatement ps = conn.prepareStatement("select min(id) minId, max(id) maxId from " + tableName);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                this.minId = rs.getInt(1);
                this.maxId = rs.getInt(2);
            }

        } catch(SQLException e) {
            e.printStackTrace();
        }
    }

    public void saveToDb(Connection conn) {}

    public void initialize(){}

    public int getId(Random random) {
        return random.nextInt(maxId)+minId;
    }

}
