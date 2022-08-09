package it.unibo.big.m3d.m3dschema;

import java.util.Objects;
import java.util.Random;

public class CustProdRating {

    public int idCustomer;
    public int idProduct;
    public Rating rating;

    public CustProdRating(int idCustomer, int idProduct, Rating rating) {
        this.idCustomer = idCustomer;
        this.idProduct = idProduct;
        this.rating = rating;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CustProdRating that = (CustProdRating) o;
        return idCustomer == that.idCustomer &&
                idProduct == that.idProduct;
    }

    @Override
    public int hashCode() {
        return Objects.hash(idCustomer, idProduct);
    }
}
