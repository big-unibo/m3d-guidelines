package it.unibo.big.m3d.m3dschema;

import java.util.Random;

public class BridgeOrderProduct {

    public int idProduct;
    public int quantity;

    public BridgeOrderProduct(int idProduct, Random random) {
        this.idProduct = idProduct;
        this.quantity = random.nextInt(10)+1;
    }

}
