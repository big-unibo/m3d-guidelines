package it.unibo.big.m3d.generator;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

public class Hierarchy extends DtElement {

    private String name;

    ArrayList<Edge> edges = new ArrayList<>();

    public Hierarchy(String name) {
        this.name = name;
    }

    @Override
    public Integer getCardinality() {
        return edges.get(0).getCardinality();
    }

    @Override
    public ArrayList<Integer> getIds() {
        return edges.get(0).getIds();
    }

    @Override
    public ArrayList<Object> getRowValues() {
        return null;
    }

    public void addEdge(Edge edge){
        edges.add(edge);
    }

    public String getName() {
        return name;
    }

    public ArrayList<Edge> getEdges() {
        return edges;
    }

    public void saveToDb(Connection conn) {

        try {
            conn.setAutoCommit(false);

            PreparedStatement psDrop = conn.prepareStatement("drop table if exists " + name);
            psDrop.execute();

            PreparedStatement psCreate = conn.prepareStatement("create table " + name + " ()");
            psCreate.execute();

            for (int i=0; i<edges.size(); i++){
                if(i==0){
                    PreparedStatement psAlter = conn.prepareStatement("alter table " + name + " add column id integer");
                    psAlter.execute();

                    psAlter = conn.prepareStatement("alter table " + name + " add column "
                            + ((EdgeManyToOne)edges.get(i)).getChild().getName() + " "
                            + ((EdgeManyToOne)edges.get(i)).getChild().getType().toString());
                    psAlter.execute();
                }
                PreparedStatement psAlter = conn.prepareStatement("alter table " + name + " add column "
                        + ((EdgeManyToOne)edges.get(i)).getParent().getName() + " "
                        + ((EdgeManyToOne)edges.get(i)).getParent().getType().toString());
                psAlter.execute();
            }

            String[] nColumns = new String[edges.size()+2];
            for (int i=0; i<edges.size()+2; i++){ nColumns[i]="?"; }
            PreparedStatement psInsert = conn.prepareStatement("insert into " + name + " values (" + String.join(",", nColumns) + ")");

            for (int i=0; i<getCardinality(); i++){
                Integer[] childKeys = new Integer[edges.size()+1];

                for (int j=0; j<edges.size(); j++) {
                    EdgeManyToOne edge = (EdgeManyToOne) edges.get(j);
                    if (j == 0) {
                        psInsert.setInt(1, i);
                        if (edge.getChild().getType() == Attribute.TYPE.INTEGER) {
                            psInsert.setInt(2, i);
                        } else {
                            psInsert.setString(2, edge.getChild().getName() + i);
                        }
                        childKeys[j] = i;
                    }

                    int v = edge.getRelationships().get(childKeys[edge.getChildEdgeIndex()]);
                    if (edge.getParent().getType() == Attribute.TYPE.INTEGER) {
                        psInsert.setInt(j + 3, v);
                    } else {
                        psInsert.setString(j + 3, edge.getParent().getName() + v);
                    }
                    childKeys[j+1] = v;
                }
                psInsert.addBatch();
            }
            psInsert.executeBatch();
//            int [] numUpdates=psInsert.executeBatch();
//            for (int i=0; i < numUpdates.length; i++) {
//                if (numUpdates[i] == -2)
//                    System.out.println("Execution " + i +
//                            ": unknown number of rows updated");
//                else
//                    System.out.println("Execution " + i +
//                            "successful: " + numUpdates[i] + " rows updated");
//            }
            conn.commit();
        } catch(SQLException b) {
            System.out.println(b.getMessage());
        }

    }
}
