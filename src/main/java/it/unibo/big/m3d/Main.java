package it.unibo.big.m3d;

import com.github.javafaker.Faker;
import it.unibo.big.m3d.m3dschema.*;
import it.unibo.big.m3d.utils.db.DbUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Random;

public final class Main {
    private static final Logger L = LoggerFactory.getLogger(Main.class);

    private Main() {
    }

    public static void main(final String[] args) throws Exception {

        Random random = new Random(12345);
        Faker faker = new Faker(random);

        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        Calendar minDate = Calendar.getInstance();
        Calendar maxDate = Calendar.getInstance();

        // SETTING PARAMETERS
        minDate.setTime(formatDate.parse("2015-01-01"));
        maxDate.setTime(formatDate.parse("2016-01-01"));

        int nProducts = 10000;
        int maxProductVarietyAttributes = 5;
        double probProductVarietyAttributes = 0.3;
        double probOptionalProductName = 0.05;
        int nTypes = 100;
        int nCategories = 5;
        int nVendors = 500;
        int nIndustries = 10;

        int maxProductsPerOrder = 10;

        int nCities = 5000;
        int nStates = 100;
        int nCountries = 30;

        int nCustomers = 100000;
        int maxCustomerVarietyAttributes = 10;
        double probCustomerVarietyAttributes = 0.2;
        double probOptionalBrowser = 0.15;
        int nTags = 50;
        int maxTagsPerCustomer = 5;
        double probTags = 0.6;
        int maxKnownCustomers = 30;
        double probKnownCustomer = 0.5;
        double probOptionalState = 0.01;

        int numberOfFacts = 1000000;
        int maxFactVarietyAttributes = 2;
        double probFactVarietyAttributes = 0.6;

        String factTableName = "ref_ft";
        String dateTableName = "ref_dt_date";
        String cityTableName = "ref_dt_city";
        String productTableName = "ref_dt_product";
        String customerTableName = "ref_dt_customer";
        String tagTableName = "ref_dt_tag";
        String orderTableName = "ref_dt_order";
        String orderProductTableName = "ref_bt_order_product";
        String ratingTableName = "ref_bt_rating";
        String knownCustomerTableName = "ref_bt_ckc";
        String customerTagTableName = "ref_bt_customer_tag";

        // SETTING CONNECTION
        Connection conn = DbUtils.getConnection();

        // GENERATING DATA
        GenMDate genMDate = new GenMDate(dateTableName,minDate,maxDate);
        genMDate.runGenerator(conn);

        GenState genState = new GenState(nStates,nCountries,random);
        genState.runGenerator(conn);

        GenCity genCity = new GenCity(cityTableName,nCities,genState,probOptionalState,random);
        genCity.runGenerator(conn);

        GenVendor genVendor = new GenVendor(nVendors,nIndustries,genCity,random);
        genVendor.runGenerator(conn);

        GenType genType = new GenType(nTypes,nCategories,random);
        genType.runGenerator(conn);

        GenProduct genProduct = new GenProduct(productTableName, nProducts,
                maxProductVarietyAttributes, probProductVarietyAttributes, probOptionalProductName,
                genType, genVendor, random, faker);
        genProduct.runGenerator(conn);

        GenTag genTag = new GenTag(tagTableName, nTags);
        genTag.runGenerator(conn);

        GenCustomer genCustomer = new GenCustomer(customerTableName, customerTagTableName, knownCustomerTableName,
                nCustomers, maxCustomerVarietyAttributes, probCustomerVarietyAttributes, probOptionalBrowser,
                genCity, genTag, maxTagsPerCustomer, probTags, maxKnownCustomers, probKnownCustomer, random, faker);
        genCustomer.runGenerator(conn);

        GenBridgeOP genBridgeOP = new GenBridgeOP(maxProductsPerOrder,genProduct);

        GenOrder genOrder = new GenOrder(factTableName, orderTableName, orderProductTableName, ratingTableName,
            numberOfFacts, maxFactVarietyAttributes, probFactVarietyAttributes, genBridgeOP, genMDate, genCustomer, random, faker);
        genOrder.generate(conn);

    }

}
