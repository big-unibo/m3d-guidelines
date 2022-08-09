package it.unibo.big.m3d.m3dschema;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Random;

public class GenTag extends Gen {

    public int nValues;
    public ArrayList<Tag> tags = new ArrayList<>();

    public GenTag(String tableName, int nValues) {
        this.tableName = tableName;
        this.nValues = nValues;
    }

    @Override
    public void initialize(){
        for(int i = 0; i< nValues; i++){
            tags.add(new Tag(i));
        }
    }

    public Tag getRandomTag(Random random) {
        return this.tags.get(random.nextInt(this.tags.size()));
    }

    public void saveToDb(Connection conn) {

        try {
            conn.setAutoCommit(false);

            PreparedStatement psDrop = conn.prepareStatement("drop table if exists " + tableName);
            psDrop.execute();

            PreparedStatement psCreate = conn.prepareStatement("create table " + tableName + " (" +
                            "id integer," +
                            "tag text" +
                    ")");
            psCreate.execute();

            PreparedStatement psInsert = conn.prepareStatement("insert into " + tableName +
                    " values (?,?)");

            for (int i=0; i<tags.size(); i++){
                psInsert.setInt(1,i);
                psInsert.setString(2,tags.get(i).tag);
                psInsert.addBatch();
            }
            psInsert.executeBatch();

            conn.commit();
        } catch(SQLException b) {
            System.out.println(b.getMessage());
        }
    }

}
