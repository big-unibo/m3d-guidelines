package it.unibo.big.m3d.m3dschema;

public class Tag {

    public String tag;

    public Tag(int i){
        this.tag = "TAG" + i;
    }

    @Override
    public String toString() {
        return "Tag: " + tag;
    }

}
