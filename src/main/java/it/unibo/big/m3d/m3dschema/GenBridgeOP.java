package it.unibo.big.m3d.m3dschema;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Random;

public class GenBridgeOP extends Gen {

    public int maxValues;
    public GenProduct genProduct;

    public GenBridgeOP(int maxValues, GenProduct genProduct) {
        this.maxValues = maxValues;
        this.genProduct = genProduct;
    }

    public ArrayList<BridgeOrderProduct> generate(Random random){
        int n = random.nextInt(maxValues)+1;
        ArrayList<BridgeOrderProduct> orderProducts = new ArrayList<>();
        HashSet<Integer> selectedProducts = new HashSet<>();
        for(int i = 0; i<n; i++){
            Integer p = genProduct.getId(random), tries = 0;
            while(selectedProducts.contains(p)){
                p = genProduct.getId(random);
                if(++tries % 10 == 0) System.out.println("Stuck in generating products for orders?");
            }
            selectedProducts.add(p);
            orderProducts.add(new BridgeOrderProduct(p, random));
        }
        return orderProducts;
    }

}
