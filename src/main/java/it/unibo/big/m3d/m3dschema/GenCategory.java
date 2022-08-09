package it.unibo.big.m3d.m3dschema;

import java.util.ArrayList;
import java.util.Random;

public class GenCategory extends Gen {

    public int maxValues;
    public ArrayList<Category> categories = new ArrayList<>();

    public GenCategory(int maxValues) {
        this.maxValues = maxValues;
    }

    @Override
    public void initialize(){
        for(int i=0; i<maxValues; i++){
            categories.add(new Category(i));
        }
    }

    public Category getCategory(Random random) {
        return this.categories.get(random.nextInt(this.categories.size()));
    }

}
