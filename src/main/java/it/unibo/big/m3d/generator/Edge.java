package it.unibo.big.m3d.generator;

import java.util.ArrayList;

public abstract class Edge {

    public abstract Integer getCardinality();
    public abstract ArrayList<Integer> getIds();
    public abstract ArrayList<Object> getRowValues();
}
