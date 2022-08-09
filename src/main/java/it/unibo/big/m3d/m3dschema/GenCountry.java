package it.unibo.big.m3d.m3dschema;

import java.util.ArrayList;
import java.util.Random;

public class GenCountry extends Gen {

    public int maxValues;
    public ArrayList<Country> countries = new ArrayList<>();

    public GenCountry(int maxValues) {
        this.maxValues = maxValues;
    }

    @Override
    public void initialize(){
        for(int i=0; i<maxValues; i++){
            countries.add(new Country(i));
        }
    }

    public Country getCountry(Random random) {
        return this.countries.get(random.nextInt(this.countries.size()));
    }

}
