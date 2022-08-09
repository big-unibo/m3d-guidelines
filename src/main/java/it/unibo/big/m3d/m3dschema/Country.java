package it.unibo.big.m3d.m3dschema;

public class Country {

    public String country;

    public Country(int i){
        this.country = "COUNTRY" + i;
    }

    @Override
    public String toString() {
        return "Country: " + country;
    }
}
