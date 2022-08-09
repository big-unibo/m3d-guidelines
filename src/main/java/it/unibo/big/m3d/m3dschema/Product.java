package it.unibo.big.m3d.m3dschema;

import com.github.javafaker.Faker;
import it.unibo.big.m3d.utils.RandomString;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

public class Product {

    public String asin;
    public String name;
    public float price;
    public Map<Integer,String> varietyAttributes = new HashMap<Integer,String>();;
    public Type type;
    public Vendor vendor;

    public Product(int i, int maxVarietyAttributes, double probVarietyAttributes, double probOptionalProductName,
                   Random random, Faker faker, Type type, Vendor vendor){
        this.asin = RandomString.generate(random,10);
        this.name = random.nextFloat() >= probOptionalProductName ? faker.commerce().productName() : null;
        this.price = Math.round(random.nextFloat()*10000)/100;

        for(int j=0; j<maxVarietyAttributes; j++){
            if(random.nextFloat() >= probVarietyAttributes){
                varietyAttributes.put(j,RandomString.generate(random,30));
            }
        }

        this.type = type;
        this.vendor = vendor;
    }

    @Override
    public String toString() {
        String varietyAttributesStr = "";
        for (Map.Entry<Integer, String> entry : varietyAttributes.entrySet()) {
            Integer key = entry.getKey();
            String value = entry.getValue();
            varietyAttributesStr += (varietyAttributesStr.isEmpty() ? "" : " - ") + "Attr" + key + ": " + value;
        }
        return "ASIN: " + asin + " - Name: " + name + " - Price: " + price + " - " + varietyAttributes + type + vendor;
    }
}
