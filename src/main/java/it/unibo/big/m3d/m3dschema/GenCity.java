package it.unibo.big.m3d.m3dschema;

import it.unibo.big.m3d.generator.Attribute;
import it.unibo.big.m3d.generator.EdgeManyToOne;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Random;

public class GenCity extends Gen {

    public int nValues;
    public GenState genState;
    public ArrayList<City> cities = new ArrayList<>();
    public Random random;
    public double probOptionalState;

    public GenCity(String tableName, int nValues, GenState genState,
                   double probOptionalState, Random random) {
        this.tableName = tableName;
        this.nValues = nValues;
        this.genState = genState;
        this.probOptionalState = probOptionalState;
        this.random = random;
    }


    @Override
    public void initialize(){
        for(int i = 0; i< nValues; i++){
            cities.add(new City(i, genState.getState(random), probOptionalState, random));
        }
    }

    public City getCity(Random random) {
        return this.cities.get(random.nextInt(this.cities.size()));
    }

    public void saveToDb(Connection conn) {

        try {
            conn.setAutoCommit(false);

            PreparedStatement psDrop = conn.prepareStatement("drop table if exists " + tableName);
            psDrop.execute();

            PreparedStatement psCreate = conn.prepareStatement("create table " + tableName + " (" +
                    "id integer," +
                    "city text," +
                    "state text," +
                    "country text" +
                    ")");
            psCreate.execute();

            PreparedStatement psInsert = conn.prepareStatement("insert into " + tableName + " values (?,?,?,?)");

            for (int i=0; i<cities.size(); i++){
                psInsert.setInt(1,i);
                psInsert.setString(2,cities.get(i).city);
                psInsert.setString(3,cities.get(i).state);
                psInsert.setString(4,cities.get(i).country);
                psInsert.addBatch();
            }
            psInsert.executeBatch();

            conn.commit();
        } catch(SQLException b) {
            System.out.println(b.getMessage());
        }
    }

}
