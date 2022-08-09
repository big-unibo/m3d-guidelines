package it.unibo.big.m3d.m3dschema;

public class Industry {

    public String industry;

    public Industry(int i){
        this.industry = "INDUSTRY" + i;
    }

    @Override
    public String toString() {
        return "Industry: " + industry;
    }
}
