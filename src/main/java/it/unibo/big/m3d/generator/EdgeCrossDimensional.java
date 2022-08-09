package it.unibo.big.m3d.generator;

import java.util.ArrayList;

public class EdgeCrossDimensional extends Edge {

    private Attribute[] children;
    private Attribute parent;

    @Override
    public Integer getCardinality() {
        return children[0].getCardinality() * children[1].getCardinality();
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
