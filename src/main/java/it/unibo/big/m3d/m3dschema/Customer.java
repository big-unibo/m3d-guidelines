package it.unibo.big.m3d.m3dschema;

import com.github.javafaker.Faker;
import it.unibo.big.m3d.utils.RandomString;

import java.text.SimpleDateFormat;
import java.util.*;

public class Customer {

    public String customer;
    public String firstName;
    public String lastName;
    public Map<Integer,String> varietyAttributes = new HashMap<Integer,String>();
    public MDate birthdate;
    public Browser browser;
    public Gender gender;
    public int idCity;
    public HashSet<Tag> tags;
    public HashSet<Integer> idTags;
    public HashSet<Integer> idKnownCustomers;

    public Customer(int i, int maxVarietyAttributes, double probVarietyAttributes, double probOptionalBrowser,
                    Random random, Faker faker, MDate birthdate, Browser browser, Gender gender, int idCity){
        this.customer = "CUSTOMER" + i;
        this.firstName = faker.address().firstName();
        this.lastName = faker.address().lastName();

        this.birthdate = birthdate;
        this.browser = browser;
        if(random.nextFloat() < probOptionalBrowser) browser.browser = null;
        this.gender = gender;
        this.idCity = idCity;
        this.tags = new HashSet<>();
        this.idTags = new HashSet<>();
        this.idKnownCustomers = new HashSet<>();

        for(int j=0; j<maxVarietyAttributes; j++){
            if(random.nextFloat() >= probVarietyAttributes){
                varietyAttributes.put(j,RandomString.generate(random,30));
            }
        }
    }

    public void addTag(int idTag){
        this.idTags.add(idTag);
    }

    public void addTag(Tag tag){
        this.tags.add(tag);
    }

    @Override
    public String toString() {
        String varietyAttributesStr = "";
        for (Map.Entry<Integer, String> entry : varietyAttributes.entrySet()) {
            Integer key = entry.getKey();
            String value = entry.getValue();
            varietyAttributesStr += (varietyAttributesStr.isEmpty() ? "" : " - ") + "Attr" + key + ": " + value;
        }
        return "Customer: " + customer + " - FN: " + firstName + " - LN: " + lastName + " - Birthdate: " + birthdate
                + browser + gender + varietyAttributes + " - IdCity: " + idCity;
    }

    public void addKnownCustomers(HashSet<Integer> idKnownCustomers){ this.idKnownCustomers = idKnownCustomers; }
}
