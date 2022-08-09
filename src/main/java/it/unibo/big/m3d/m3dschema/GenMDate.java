package it.unibo.big.m3d.m3dschema;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.*;

public class GenMDate extends Gen {

    public Calendar minDate;
    public Calendar maxDate;
    public ArrayList<MDate> dates;

    public GenMDate(String tableName, Calendar minDate, Calendar maxDate){
        this.tableName = tableName;
        this.minDate = minDate;
        this.maxDate = maxDate;
    }

    @Override
    public void initialize(){
        this.dates = new ArrayList<>();

        Calendar c = minDate;
        while(c.before(maxDate)){
            dates.add(new MDate(c));
            c.add(Calendar.DATE,1);
        }
    }

    public MDate getDate(Random random) {
        return this.dates.get(random.nextInt(this.dates.size()));
    }


    public void saveToDb(Connection conn) {

        try {
            conn.setAutoCommit(false);

            PreparedStatement psDrop = conn.prepareStatement("drop table if exists " + tableName);
            psDrop.execute();

            PreparedStatement psCreate = conn.prepareStatement("create table " + tableName + " (" +
                    "id integer," +
                    "date date," +
                    "month integer," +
                    "monthyear text," +
                    "fourmonthsperiod text," +
                    "quarter text," +
                    "semester text," +
                    "year integer" +
                    ")");
            psCreate.execute();

            PreparedStatement psInsert = conn.prepareStatement("insert into " + tableName + " values (?,?,?,?,?,?,?,?)");

            for (int i=0; i<dates.size(); i++){
                psInsert.setInt(1,i);
                psInsert.setDate(2,new java.sql.Date(dates.get(i).date.getTime()));
                psInsert.setInt(3,dates.get(i).month);
                psInsert.setString(4,dates.get(i).monthYear);
                psInsert.setString(5,dates.get(i).fourMonthsPeriod);
                psInsert.setString(6,dates.get(i).quarter);
                psInsert.setString(7,dates.get(i).semester);
                psInsert.setInt(8,dates.get(i).year);
                psInsert.addBatch();
            }
            psInsert.executeBatch();

            conn.commit();
        } catch(SQLException b) {
            System.out.println(b.getMessage());
        }
    }
}
