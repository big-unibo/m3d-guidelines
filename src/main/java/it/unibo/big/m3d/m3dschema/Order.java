package it.unibo.big.m3d.m3dschema;

import it.unibo.big.m3d.utils.RandomString;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

public class Order {

    public long id;
    public ShipmentMode shipmentMode;
    public int idCustomer;
    public int idDate;

    public float totalPrice;
    public float netPrice;
    public float vat;
    public float discount;
    public Map<Integer,Float> varietyMeasures = new HashMap<Integer,Float>();

    public ArrayList<BridgeOrderProduct> products;

    public Order(long id, Random random, int idDate, ShipmentMode shipmentMode, int idCustomer,
                 ArrayList<BridgeOrderProduct> products, int maxVarietyMeasures, double probVarietyMeasures){
        this.id = id;
        this.shipmentMode = shipmentMode;
        this.idCustomer = idCustomer;

        this.vat = (random.nextInt(4)+1)*5;
        this.netPrice = Math.round(random.nextFloat()*10000)/100;
        this.discount = random.nextFloat()>=0.9 ? random.nextInt(20)+1 : 0;
        this.totalPrice = ((float)Math.round(netPrice*(1-(discount/100))*(1+vat/100)*100))/100;

        this.idDate = idDate;
        this.products = products;

        for(int j=0; j<maxVarietyMeasures; j++){
            if(random.nextFloat() >= probVarietyMeasures){
                varietyMeasures.put(j, random.nextFloat());
            }
        }
    }

    public String toString(){
        return "Net: " + netPrice + " - Discount: " + discount + " - Vat: " + vat + " - Total: " + totalPrice + idDate + products + " - Variety??";
    }

}
