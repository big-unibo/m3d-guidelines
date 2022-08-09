package it.unibo.big.m3d.m3dschema;

import java.util.Random;

public class ShipmentMode {

    public String shipmentMode;
    public String[] shipmentModeList = { "AIR", "SHIP", "TRUCK", "TRAIN" };

    public ShipmentMode(Random random){
        this.shipmentMode = shipmentModeList[random.nextInt(shipmentModeList.length)];
    }

    @Override
    public String toString() {
        return "ShipmentMode: " + shipmentMode;
    }

}
