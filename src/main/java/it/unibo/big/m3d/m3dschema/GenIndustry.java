package it.unibo.big.m3d.m3dschema;

import java.util.ArrayList;
import java.util.Random;

public class GenIndustry extends Gen {

    public int nValues;
    public ArrayList<Industry> industries = new ArrayList<>();

    public GenIndustry(int nValues) {
        this.nValues = nValues;
    }

    @Override
    public void initialize(){
        for(int i = 0; i< nValues; i++){
            industries.add(new Industry(i));
        }
    }

    public Industry getIndustry(Random random) {
        return this.industries.get(random.nextInt(this.industries.size()));
    }


}
