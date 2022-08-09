package it.unibo.big.m3d.generator;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

public class EdgeManyToOne extends Edge {

    private Attribute child;
    private Attribute parent;
    private int childEdgeIndex;

    public enum GENERATION_TYPE {UNIFORM, RANDOM};

    private Map<Integer,Integer> relationships = new HashMap<>();

    public EdgeManyToOne(Attribute child, Attribute parent, int childEdgeIndex, GENERATION_TYPE type) throws Exception {
        if(child.getCardinality()<parent.getCardinality()){
            throw new Exception("Child cardinality cannot be lower than parent cardinality");
        }
        this.child = child;
        this.parent = parent;
        this.childEdgeIndex = childEdgeIndex;
        generate(type);
    }

    public EdgeManyToOne(Attribute child, Attribute parent, int childEdgeIndex) throws Exception {
        if(child.getCardinality()<parent.getCardinality()){
            throw new Exception("Child cardinality cannot be lower than parent cardinality");
        }
        this.child = child;
        this.parent = parent;
        this.childEdgeIndex = childEdgeIndex;
        generate(GENERATION_TYPE.UNIFORM);
    }

    public void generate(GENERATION_TYPE type){
        if (type==GENERATION_TYPE.UNIFORM){
            Double reduction = child.getCardinality().doubleValue() / parent.getCardinality().doubleValue();
            for(int i = 0; i < child.getCardinality(); i++){
                relationships.put(i,Integer.valueOf((int)Math.floor(i / reduction)));
            }
        }
        else if (type==GENERATION_TYPE.RANDOM){
            Random random = new Random(12345);
            for(int i = 0; i < child.getCardinality(); i++){
                relationships.put(i,random.nextInt(parent.getCardinality()));
            }
        }
    }

    public Attribute getChild() {
        return child;
    }

    public Attribute getParent() {
        return parent;
    }

    public int getChildEdgeIndex() {
        return childEdgeIndex;
    }

    public Map<Integer, Integer> getRelationships() {
        return relationships;
    }

    @Override
    public String toString() {
        String s = "Many-to-one edge " + child.getName() + " -> " + parent.getName() + "\n";
        for (Map.Entry<Integer, Integer> entry : relationships.entrySet()) {
            s += child.getName() + entry.getKey() + " -> " + parent.getName() + entry.getValue() + "\n";
        }
        return s.toString();
    }

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
