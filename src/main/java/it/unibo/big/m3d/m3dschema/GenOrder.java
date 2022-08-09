package it.unibo.big.m3d.m3dschema;

import com.github.javafaker.Faker;
import it.unibo.big.m3d.Main;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Random;

public class GenOrder extends Gen {

    public String orderTableName;
    public String orderProductTableName;
    public String ratingTableName;
    public int nValues;
    public int maxFactVarietyMeasures;
    public double probFactVarietyMeasures;
    public GenBridgeOP genBridgeOP;
    public GenMDate genMDate;
    public GenCustomer genCustomer;
    public Random random;
    public Faker faker;

    public GenOrder(String tableName, String orderTableName, String orderProductTableName, String ratingTableName,
                    int nValues, int maxFactVarietyMeasures, double probFactVarietyMeasures,
                    GenBridgeOP genBridgeOP, GenMDate genMDate, GenCustomer genCustomer,
                    Random random, Faker faker){
        this.tableName = tableName;
        this.orderTableName = orderTableName;
        this.orderProductTableName = orderProductTableName;
        this.ratingTableName = ratingTableName;
        this.nValues = nValues;
        this.maxFactVarietyMeasures = maxFactVarietyMeasures;
        this.probFactVarietyMeasures = probFactVarietyMeasures;
        this.genBridgeOP = genBridgeOP;
        this.genMDate = genMDate;
        this.genCustomer = genCustomer;
        this.random = random;
        this.faker = faker;
    }


    public void generate(Connection conn){

        try {

            String varietyFields = "", varietyQuestionMarks = "";
            for(int i=0; i<maxFactVarietyMeasures; i++){
                varietyFields += (varietyFields.isEmpty() ? "" : ",") + "variety" + i + " text";
                varietyQuestionMarks += "?,";
            }
            varietyFields += varietyFields.isEmpty() ? "" : ",";

            conn.setAutoCommit(false);

            PreparedStatement psDrop = conn.prepareStatement("drop table if exists " + tableName);
            psDrop.execute();
            psDrop = conn.prepareStatement("drop table if exists " + orderTableName);
            psDrop.execute();
            psDrop = conn.prepareStatement("drop table if exists " + orderProductTableName);
            psDrop.execute();
            psDrop = conn.prepareStatement("drop table if exists " + ratingTableName);
            psDrop.execute();

            PreparedStatement psCreate = conn.prepareStatement("create table " + tableName + " (" +
                    "totalprice float," +
                    "netprice float," +
                    "vat float," +
                    "discount float, " +
                    varietyFields +
                    "idDate integer," +
                    "idOrder integer" +
                    ")");
            psCreate.execute();

            psCreate = conn.prepareStatement("create table " + orderTableName + " (" +
                    "idOrder integer," +
                    "shipmentmode text," +
                    "idCustomer integer" +
                    ")");
            psCreate.execute();

            psCreate = conn.prepareStatement("create table " + orderProductTableName + " (" +
                    "idOrder integer," +
                    "idProduct integer," +
                    "quantity integer," +
                    "weight float" +
                    ")");
            psCreate.execute();

            psCreate = conn.prepareStatement("create table " + ratingTableName + " (" +
                    "idProduct integer," +
                    "idCustomer integer," +
                    "rating integer," +
                    "posNeg text" +
                    ")");
            psCreate.execute();


            int interval = Math.max(1,nValues/100);
            PreparedStatement psInsertFact = conn.prepareStatement("insert into " + tableName +
                    " values (?,?,?,?," + varietyQuestionMarks + "?,?)");
            PreparedStatement psInsertOrder = conn.prepareStatement("insert into " + orderTableName +
                    " values (?,?,?)");
            PreparedStatement psInsertOrderProduct = conn.prepareStatement("insert into " + orderProductTableName +
                    " values (?,?,?,?)");
            PreparedStatement psInsertRating = conn.prepareStatement("insert into " + ratingTableName +
                    " values (?,?,?,?)");

            HashSet<CustProdRating> custProdRatings = new HashSet<>();
            for (int i = 0; i < nValues; i++) {
                Order order = new Order(i, random, genMDate.getId(random), new ShipmentMode(random),
                        genCustomer.getId(random), genBridgeOP.generate(random), maxFactVarietyMeasures, probFactVarietyMeasures);

                psInsertFact.setFloat(1,order.totalPrice);
                psInsertFact.setFloat(2,order.netPrice);
                psInsertFact.setFloat(3,order.vat);
                psInsertFact.setFloat(4,order.discount);
                for(int j=0; j<maxFactVarietyMeasures; j++){
                    if(order.varietyMeasures.get(j)!=null) psInsertFact.setFloat(j+5,order.varietyMeasures.get(j));
                    else psInsertFact.setNull(j+5,java.sql.Types.FLOAT);
                }
                psInsertFact.setInt(5+maxFactVarietyMeasures,order.idDate);
                psInsertFact.setLong(6+maxFactVarietyMeasures,order.id);
                psInsertFact.addBatch();

                psInsertOrder.setLong(1,order.id);
                psInsertOrder.setString(2,order.shipmentMode.shipmentMode);
                psInsertOrder.setInt(3,order.idCustomer);
                psInsertOrder.addBatch();

                for(BridgeOrderProduct op : order.products) {
                    psInsertOrderProduct.setLong(1, order.id);
                    psInsertOrderProduct.setInt(2, op.idProduct);
                    psInsertOrderProduct.setInt(3, op.quantity);
                    psInsertOrderProduct.setDouble(4, 1/(double)order.products.size());
                    psInsertOrderProduct.addBatch();

                    custProdRatings.add(new CustProdRating(order.idCustomer, op.idProduct, new Rating(random)));
                }

                if (i % interval == 0){
                    psInsertOrder.executeBatch();
                    psInsertFact.executeBatch();
                    psInsertOrderProduct.executeBatch();
                    conn.commit();
                    System.out.println("Executed " + i + " of " + nValues + " (" + ((double)i/(double)nValues) + "%)");
                    psInsertOrder.clearBatch();
                    psInsertFact.clearBatch();
                    psInsertOrderProduct.clearBatch();
                }
            }
            psInsertOrder.executeBatch();
            psInsertFact.executeBatch();
            psInsertOrderProduct.executeBatch();
            conn.commit();

            System.out.println("Created all " + nValues + " (100%)");

            for(CustProdRating r : custProdRatings){
                psInsertRating.setInt(1, r.idProduct);
                psInsertRating.setInt(2, r.idCustomer);
                psInsertRating.setInt(3, r.rating.rating);
                psInsertRating.setString(4, r.rating.posNeg);
                psInsertRating.addBatch();
            }

            psInsertRating.executeBatch();
            conn.commit();
            System.out.println("Created all ratings");

        } catch( SQLException b) {
            System.out.println(b.getMessage());
        }
    }
}
