package it.unibo.big.m3d.generator;

import java.util.ArrayList;

public class Dt {

    private String name;
    private boolean useIdForLeaf;
    private boolean useIdForRoots;
    ArrayList<DtElement> elements;
    ArrayList<Row> rows;

    public Dt(String name) {
        this.name = name;
        this.useIdForLeaf = true;
        this.useIdForRoots = false;
        this.elements = new ArrayList<>();
        this.rows = new ArrayList<>();
    }

    public Dt(String name, boolean useIdForLeaf, boolean useIdForRoots) {
        this.name = name;
        this.useIdForLeaf = useIdForLeaf;
        this.useIdForRoots = useIdForRoots;
        this.elements = new ArrayList<>();
        this.rows = new ArrayList<>();
    }

    public String getName() {
        return name;
    }

    public void addElement(DtElement element){
        elements.add(element);
    }

    public void generate(){
        int dtCardinality = elements.get(0).getCardinality();
        // Generate as many rows as dtCardinality
        for(int i = 0; i < dtCardinality; i++){
            Row row = new Row();
            // Generate ID if necessary
            if(useIdForLeaf){
                row.addValue(i);
            }
            // Generate one value for
            for(int j = 0; j < elements.size(); j++){

            }
        }
    }

    @Override
    public String toString() {
        String s = "DT " + name + "\n";
        for(int i = 0; i < elements.size(); i++){
            if(i==0 && useIdForLeaf){

            }
        }
        return s;
    }
}
