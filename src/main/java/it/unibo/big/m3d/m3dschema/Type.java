package it.unibo.big.m3d.m3dschema;

public class Type {


    public String type;
    public Category category;


    public Type(int i, Category category){
        this.type = "TYPE" + i;
        this.category = category;
    }

    @Override
    public String toString() {
        return "Type: " + type + " - " + category;
    }

}
