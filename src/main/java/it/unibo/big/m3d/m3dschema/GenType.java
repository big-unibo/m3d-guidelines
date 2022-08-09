package it.unibo.big.m3d.m3dschema;

import java.util.ArrayList;
import java.util.Random;

public class GenType extends Gen {

    public int nValues;
    public GenCategory genCategory;
    public ArrayList<Type> types = new ArrayList<>();
    public Random random;

    public GenType(int nValues, int maxCategories, Random random) {
        this.nValues = nValues;
        this.genCategory = new GenCategory(maxCategories);
        this.random = random;
    }

    @Override
    public void initialize(){
        genCategory.initialize();
        for(int i = 0; i< nValues; i++){
            types.add(new Type(i, genCategory.getCategory(random)));
        }
    }

    public Type getType(Random random) {
        return this.types.get(random.nextInt(this.types.size()));
    }

}
