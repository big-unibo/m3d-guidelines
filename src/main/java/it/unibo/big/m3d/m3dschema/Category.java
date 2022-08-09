package it.unibo.big.m3d.m3dschema;

public class Category {

    public String category;

    public Category(int i){
        this.category = "CATEGORY" + i;
    }

    @Override
    public String toString() {
        return "Category: " + category;
    }
}
