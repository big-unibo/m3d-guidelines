package it.unibo.big.m3d.generator;

import java.util.ArrayList;

public class EdgeManyToMany extends Edge {

    private Attribute child;
    private Attribute parent;

    private ArrayList<Attribute> properties;

    @Override
    public Integer getCardinality() {
        return child.getCardinality();
    }

    @Override
    public ArrayList<Integer> getIds() {
        return null;
    }

    @Override
    public ArrayList<Object> getRowValues() {
        return null;
    }
}
