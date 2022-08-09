package it.unibo.big.m3d.m3dschema;

import java.util.ArrayList;
import java.util.Random;

public class GenVendor extends Gen {

    public int nValues;
    public GenIndustry genIndustry;
    public GenCity genCity;
    public ArrayList<Vendor> vendors = new ArrayList<>();
    public Random random;

    public GenVendor(int nValues, int nIndustries, GenCity genCity, Random random) {
        this.nValues = nValues;
        this.genIndustry = new GenIndustry(nIndustries);
        this.genCity = genCity;
        this.random = random;
    }

    @Override
    public void initialize(){
        genIndustry.initialize();
        for(int i = 0; i< nValues; i++){
            vendors.add(new Vendor(i, genIndustry.getIndustry(random), genCity.getId(random)));
        }
    }

    public Vendor getVendor(Random random) {
        return this.vendors.get(random.nextInt(this.vendors.size()));
    }



}
