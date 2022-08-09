package it.unibo.big.m3d.generator;

import java.util.ArrayList;

public class Convergence extends DtElement {

    ArrayList<Hierarchy> hierarchies;

    public Convergence(ArrayList<Hierarchy> hierarchies) {
        this.hierarchies = hierarchies;
    }

    @Override
    public Integer getCardinality() {
        return hierarchies.get(0).getCardinality();
    }

    @Override
    public ArrayList<Integer> getIds() {
        return hierarchies.get(0).getIds();
    }

    @Override
    public ArrayList<Object> getRowValues() {
        return null;
    }
}
