package it.unibo.big.m3d.generator;

import java.util.ArrayList;

public class Row {

    private ArrayList<Object> values;

    public Row() {
        this.values = new ArrayList<>();
    }

    public void addValue(Object value){
        this.values.add(value);
    }

    public ArrayList<Object> getValues() {
        return values;
    }
}
