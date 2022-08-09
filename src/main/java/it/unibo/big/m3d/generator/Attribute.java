package it.unibo.big.m3d.generator;

import java.util.ArrayList;

public class Attribute {

    public enum TYPE {TEXT, INTEGER}

    private String name;
    private Integer cardinality;
    private TYPE type;

    private ArrayList<Object> values;


    public Attribute(String name, TYPE type, Integer cardinality) {
        this.name = name;
        this.type = type;
        this.cardinality = cardinality;
    }

    public String getName() {
        return name;
    }

    public TYPE getType() {
        return type;
    }

    public Integer getCardinality() {
        return cardinality;
    }

    public void setValues(ArrayList<Object> values) {
        this.values = values;
    }
}
