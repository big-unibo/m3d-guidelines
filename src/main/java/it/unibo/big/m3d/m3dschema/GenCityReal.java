package it.unibo.big.m3d.m3dschema;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Random;

public class GenCityReal extends Gen {

    public ArrayList<City> cities = new ArrayList<>();
    public Random random;
    public double probOptionalState;
    public int limitCities = -1;

    public GenCityReal(String tableName, double probOptionalState, Random random) {
        this.tableName = tableName;
        this.probOptionalState = probOptionalState;
        this.random = random;
    }

    public GenCityReal(String tableName, double probOptionalState, Random random, int limitCities) {
        this.tableName = tableName;
        this.probOptionalState = probOptionalState;
        this.random = random;
        this.limitCities = limitCities;
    }

    @Override
    public void initialize(){
        try{
            BufferedReader b = new BufferedReader(new InputStreamReader(this.getClass().getClassLoader().getResourceAsStream("worldcities.csv")));
            String readLine = "";
            boolean first = true;
            while ((readLine = b.readLine()) != null) {
                if(!first) {
                    String[] line = readLine.replaceAll("\"","").split(",");
                    //cities.add(new City(line[0],line[7],line[4],"", probOptionalState, random));
                }
                first = false;
                if(cities.size()==limitCities) break;
            }
            b.close();
        }
        catch(IOException e){
            System.out.println(e.getMessage());
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
