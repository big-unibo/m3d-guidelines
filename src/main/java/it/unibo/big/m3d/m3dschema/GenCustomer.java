package it.unibo.big.m3d.m3dschema;

import com.github.javafaker.Faker;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashSet;
import java.util.Random;

public class GenCustomer extends Gen {

    public int nValues;
    public int maxVarietyAttributes;
    public double probVarietyAttributes;
    public double probOptionalBrowser;
    public GenTag genTag;
    public Calendar minBirthdate;// = Calendar.getInstance();
    public Calendar maxBirthdate;

    public String tagsTableName;
    public String customerBridgeTableName;
    public int maxTags;
    public double probTags;
    public int maxKnownCustomers;
    public double probKnownCustomers;

    public GenMDate genBirthdate;
    public GenCity genCity;
    public ArrayList<Customer> customers = new ArrayList<>();

    public Random random;
    public Faker faker;

    public GenCustomer(String tableName, String customerTagsTableName, String customerBridgeTableName,
                       int nValues,
                       int maxVarietyAttributes, double probVarietyAttributes, double probOptionalBrowser,
                       GenCity genCity, GenTag genTag, int maxTags, double probTags,
                       int maxKnownCustomers, double probKnownCustomers,
                       Random random, Faker faker) {
        this.tableName = tableName;
        this.tagsTableName = customerTagsTableName;
        this.customerBridgeTableName = customerBridgeTableName;

        this.nValues = nValues;
        this.maxVarietyAttributes = maxVarietyAttributes;
        this.probVarietyAttributes = probVarietyAttributes;
        this.probOptionalBrowser = probOptionalBrowser;
        this.genTag = genTag;
        this.genCity = genCity;

        this.maxTags = maxTags;
        this.probTags = probTags;

        this.maxKnownCustomers = maxKnownCustomers;
        this.probKnownCustomers = probKnownCustomers;

        this.random = random;
        this.faker = faker;

        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        minBirthdate = Calendar.getInstance();
        maxBirthdate = Calendar.getInstance();
        try {
            minBirthdate.setTime(formatDate.parse("1920-01-01"));
            maxBirthdate.setTime(formatDate.parse("2000-01-01"));
        } catch (ParseException e) {
            e.printStackTrace();
        }

        this.genBirthdate = new GenMDate("",minBirthdate,maxBirthdate);
    }

    @Override
    public void initialize(){
        genBirthdate.initialize();
        for(int i = 0; i< nValues; i++){

            Customer c = new Customer(i, maxVarietyAttributes, probVarietyAttributes, probOptionalBrowser, random, faker,
                    genBirthdate.getDate(random), new Browser(random), new Gender(random), genCity.getId(random));

            for(int j=0; j<maxTags; j++){
                if(random.nextFloat() >= probTags){
                    c.addTag(genTag.tags.get(j));
                }
            }

            customers.add(c);
        }

        for(Customer refCustomer : customers){
            int n = random.nextInt(maxKnownCustomers);
            HashSet<Integer> bridgeCustomer = new HashSet<>();
            for(int i = 0; i<n; i++){
                if(random.nextFloat() >= probKnownCustomers){
                    bridgeCustomer.add(getIdCustomerDifferentFromCustomer(random,refCustomer));
                }
            }
            refCustomer.addKnownCustomers(bridgeCustomer);
        }
    }

    public Customer getCustomer(Random random) {
        return this.customers.get(random.nextInt(this.customers.size()));
    }

    public Integer getIdCustomerDifferentFromCustomer(Random random, Customer refC) {
        Customer c;
        Integer i;
        do {
            i = random.nextInt(this.customers.size());
            c = this.customers.get(i);
        } while (c.customer.equals(refC.customer));

        return i;
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
                    "id integer," +
                    varietyFields +
                    "customer text ," +
                    "birthdate text ," +
                    "firstname text, " +
                    "lastname text ," +
                    "gender text ," +
                    "browserUsed text, " +
                    "idCity integer" +
                    ")");
            psCreate.execute();

            PreparedStatement psInsert = conn.prepareStatement("insert into " + tableName +
                    " values (?," + varietyQuestionMarks + "?,?,?,?,?,?,?)");

            for (int i=0; i<customers.size(); i++){
                psInsert.setInt(1,i);
                for(int j=0; j<maxVarietyAttributes; j++){
                    psInsert.setString(j+2,customers.get(i).varietyAttributes.get(j));
                }
                psInsert.setString(2+maxVarietyAttributes,customers.get(i).customer);
                psInsert.setString(3+maxVarietyAttributes,customers.get(i).birthdate.date.toString());
                psInsert.setString(4+maxVarietyAttributes,customers.get(i).firstName);
                psInsert.setString(5+maxVarietyAttributes,customers.get(i).lastName);
                psInsert.setString(6+maxVarietyAttributes,customers.get(i).gender.gender);
                psInsert.setString(7+maxVarietyAttributes,customers.get(i).browser.browser);
                psInsert.setInt(8+maxVarietyAttributes,customers.get(i).idCity);
                psInsert.addBatch();
            }
            psInsert.executeBatch();

            conn.commit();
        } catch(SQLException b) {
            System.out.println(b.getMessage());
        }

        try {
            conn.setAutoCommit(false);

            PreparedStatement psDrop = conn.prepareStatement("drop table if exists " + tagsTableName);
            psDrop.execute();

            PreparedStatement psCreate = conn.prepareStatement("create table " + tagsTableName + " (" +
                    "idCustomer integer," +
                    "tag text," +
                    "weight float" +
                    ")");
            psCreate.execute();

            PreparedStatement psInsert = conn.prepareStatement("insert into " + tagsTableName +
                    " values (?,?,?)");

            for (int i=0; i<customers.size(); i++){
                for(Tag tag : customers.get(i).tags){
                    psInsert.setInt(1,i);
                    psInsert.setString(2,tag.tag);
                    psInsert.setDouble(3,1/(double)customers.get(i).tags.size());
                    psInsert.addBatch();
                }
            }
            psInsert.executeBatch();

            conn.commit();
        } catch(SQLException b) {
            System.out.println(b.getMessage());
        }

        try {
            conn.setAutoCommit(false);

            PreparedStatement psDrop = conn.prepareStatement("drop table if exists " + customerBridgeTableName);
            psDrop.execute();

            PreparedStatement psCreate = conn.prepareStatement("create table " + customerBridgeTableName + " (" +
                    "idCustomerChild integer," +
                    "idCustomerParent integer" +
                    ")");
            psCreate.execute();

            PreparedStatement psInsert = conn.prepareStatement("insert into " + customerBridgeTableName +
                    " values (?,?)");

            for (int i=0; i<customers.size(); i++){
                for(Integer idKnownCustomer : customers.get(i).idKnownCustomers){
                    psInsert.setInt(1,i);
                    psInsert.setInt(2,idKnownCustomer);
                    psInsert.addBatch();
                }
            }
            psInsert.executeBatch();

            conn.commit();
        } catch(SQLException b) {
            System.out.println(b.getMessage());
        }
    }

}
