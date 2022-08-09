package it.unibo.big.m3d.m3dschema;

public class Vendor {


    public String vendor;
    public Industry industry;
    public int idCity;


    public Vendor(int i, Industry industry, int idCity){
        this.vendor = "VENDOR" + i;
        this.industry = industry;
        this.idCity = idCity;
    }

    @Override
    public String toString() {
        return "Vendor: " + vendor + " - " + industry + " - IdCity: " + idCity;
    }

}
