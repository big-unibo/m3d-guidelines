package it.unibo.big.m3d.m3dschema;

import java.util.Random;

public class City {

    public String city;
    public String state;
    public String country;
    public String region;

    public City(int i, State state, double probOptionalState, Random random) {
        this.city = "CITY" + i;
        this.state = random.nextFloat() >= probOptionalState ? state.state : null;
        this.country = state.country.country;
        this.region = region;
    }

    public String toString(){
        return "City " + city + " - State: " + state + " - Country: " + country + " - Region: " + region;
    }
}
