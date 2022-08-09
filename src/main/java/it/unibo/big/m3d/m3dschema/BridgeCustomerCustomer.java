package it.unibo.big.m3d.m3dschema;

import java.util.Random;

public class BridgeCustomerCustomer {

    public int idCustomer1;
    public int idCustomer2;

    public BridgeCustomerCustomer(int idCustomer1, int idCustomer2) {
        this.idCustomer1 = idCustomer1;
        this.idCustomer2 = idCustomer2;
    }

    @Override
    public String toString() {
        return "C1: " + idCustomer1 + " C2: " + idCustomer2;
    }
}
