package it.unibo.big.m3d.m3dschema;

import com.github.javafaker.Faker;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Random;

public class GenProduct extends Gen {

    public int nValues;
    public int maxVarietyAttributes;
    public double probVarietyAttributes;
    public double probOptionalProductName;
    public GenType genType;
    public GenVendor genVendor;
    public ArrayList<Product> products = new ArrayList<>();

    public ArrayList<Integer> ids = new ArrayList<>();

    public Random random;
    public Faker faker;

    public GenProduct(String tableName, int nValues, int maxVarietyAttributes, double probVarietyAttributes,
                      double probOptionalProductName, GenType genType, GenVendor genVendor, Random random, Faker faker) {
        this.tableName = tableName;
        this.nValues = nValues;
        this.maxVarietyAttributes = maxVarietyAttributes;
        this.probVarietyAttributes = probVarietyAttributes;
        this.probOptionalProductName = probOptionalProductName;
        this.genType = genType;
        this.genVendor = genVendor;
        this.random = random;
        this.faker = faker;
    }

    @Override
    public void initialize(){
        for(int i = 0; i< nValues; i++){
            products.add(new Product(i, maxVarietyAttributes, probVarietyAttributes, probOptionalProductName, random, faker,
                    genType.getType(random), genVendor.getVendor(random)));
        }
    }

    public Product getProduct(Random random) {
        return this.products.get(random.nextInt(this.products.size()));
    }


    public void saveToDb(Connection conn) {

        try {
            conn.setAutoCommit(false);

            PreparedStatement psDrop = conn.prepareStatement("drop table if exists " + tableName);
            psDrop.execute();

            String varietyFields = "", varietyQuestionMarks = "";
            for(int i=0; i<maxVarietyAttributes; i++){
                varietyFields += (varietyFields.isEmpty() ? "" : ",") + "variety" + i + " text";
                varietyQuestionMarks += "?,";
            }
            varietyFields += varietyFields.isEmpty() ? "" : ",";

            PreparedStatement psCreate = conn.prepareStatement("create table " + tableName + " (" +
                    "id integer ," +
                    varietyFields +
                    "productasin text ," +
                    "price float ," +
                    "name text, " +
                    "type text ," +
                    "category text ," +
                    "vendor text ," +
                    "industry text ," +
                    "idCity integer " +
                    ")");
            psCreate.execute();

            PreparedStatement psInsert = conn.prepareStatement("insert into " + tableName + 
                    " values (?," + varietyQuestionMarks + "?,?,?,?,?,?,?,?)");

            for (int i=0; i<products.size(); i++){
                psInsert.setInt(1,i);
                for(int j=0; j<maxVarietyAttributes; j++){
                    psInsert.setString(j+2,products.get(i).varietyAttributes.get(j));
                }
                psInsert.setString(2+maxVarietyAttributes,products.get(i).asin);
                psInsert.setFloat(3+maxVarietyAttributes,products.get(i).price);
                psInsert.setString(4+maxVarietyAttributes,products.get(i).name);
                psInsert.setString(5+maxVarietyAttributes,products.get(i).type.type);
                psInsert.setString(6+maxVarietyAttributes,products.get(i).type.category.category);
                psInsert.setString(7+maxVarietyAttributes,products.get(i).vendor.vendor);
                psInsert.setString(8+maxVarietyAttributes,products.get(i).vendor.industry.industry);
                psInsert.setInt(9+maxVarietyAttributes,products.get(i).vendor.idCity);
                psInsert.addBatch();
            }
            psInsert.executeBatch();

            conn.commit();
        } catch(SQLException b) {
            System.out.println(b.getMessage());
        }
    }

    public Integer getAsin(Random random) {
        return ids.get(random.nextInt(ids.size()));
    }
}
